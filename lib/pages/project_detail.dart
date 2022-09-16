import 'dart:convert';
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:blockie_app/common/nft_info.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blockie_app/common/global.dart';
import 'package:blockie_app/common/image_view_data.dart';
import 'package:blockie_app/common/project_detail_info.dart';
import 'package:blockie_app/widgets/description_text.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blockie_app/common/routes.dart';
import 'package:get/get.dart';

enum MintState {
  mint,
  notLogIn,
  unopened,
  unqualified,
  minting
}

const Map<MintState, Color> mintToColor = {
  MintState.mint: Color(0xfff9d038),
  MintState.notLogIn: Color(0xffffffff),
  MintState.unopened: Color(0xffc8c8c8),
  MintState.unqualified: Color(0xffc8c8c8),
  MintState.minting: Color(0xff07dfab)
};

const Map<MintState, String> mintToText = {
  MintState.mint: "开始铸造",
  MintState.notLogIn: "关联区块链账户",
  MintState.unopened: "即将开放铸造",
  MintState.unqualified: "开始铸造",
  MintState.minting: "正在铸造"
};

class ProjectPage extends StatefulWidget{
  const ProjectPage({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  bool _showNftCard = false;
  bool _showMintInfo = false;
  NftInfo? _mintedNft;
  MintState _mintState = MintState.mint;
  Color _mintColor = mintToColor[MintState.mint]!;
  String _mintText = mintToText[MintState.mint]!;
  bool _initMintState = false;
  bool _showLoginPanel = false;
  Future<ProjectDetailInfo>? _futureProject;
  String? _projectUid;

  @override
  void initState() {
    html.window.onMessage.listen((event) {
      var data = jsonDecode(event.data);
      if (data["status"] != "ok") {
        throw Exception("登录错误${data["code"]}");
      }
      String code = data["data"]["code"];
      _login(code);
    });
    Future.delayed(Duration.zero,(){
      setState(() {
        // _projectUid = ModalRoute.of(context)!.settings.arguments as String;
        _projectUid = Get.parameters["projectUid"];
        _futureProject = HttpRequest.loadProjectDetail(uid: _projectUid, token: DataStorage.getToken());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget projectDetailStack = FutureBuilder<ProjectDetailInfo>(
        future: _futureProject,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              if (!_initMintState) {
                Future.delayed(Duration.zero, (){
                  _setMintState(_getMintState(DataStorage.getToken(), snapshot.data!.isOpen, snapshot.data!.mintChances));
                  _initMintState = true;
                });
              }
              Widget images = Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(snapshot.data!.cover),
                      fit: BoxFit.fill,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20, top: Global.titleButtonTop),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.back();
                                }, // Image tapped
                                child: Image.asset(
                                  "images/back.png",
                                  width: 29,
                                  height: 29,
                                )
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 22),
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.images.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Container(width: 20);
                              } else {
                                return Container(
                                    width: 50,
                                    height: 50,
                                    margin: const EdgeInsets.only(right: 9),
                                    child: GestureDetector(
                                      onTap: (){
                                        var data = ImageViewData(snapshot.data!.images, index - 1);
                                        // Navigator.of(context).pushNamed("/image_view", arguments: data);
                                        Get.toNamed("${Routes.imageView}?index=${index - 1}&images=${jsonEncode(snapshot.data!.images)}");
                                      },
                                      child:
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: const Color(0x66ffffff)
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(2)
                                          ),
                                        ),
                                        child: Image.network(
                                          snapshot.data!.images[index - 1],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    )
                                );
                              }
                            }),
                      )
                    ],
                  )
              );

              Widget projectTitle = Container(
                padding: const EdgeInsets.only(left: 22, right: 22, top: 14, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      snapshot.data!.name,
                      style: const TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 20,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 2,
                              color: Color.fromARGB(63, 0, 0, 0),
                            )
                          ]
                      ),
                    )
                  ],
                ),
              );

              Widget brandInfo = Container(
                padding: const EdgeInsets.only(left: 22, right: 22, bottom: 13),
                child: GestureDetector(
                    onTap: (){
                      // Navigator.of(context).pushNamed("/brand", arguments: snapshot.data!.issuer);
                      Get.toNamed("${Routes.brand}?issuer=${jsonEncode(snapshot.data!.issuer.json)}");
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(
                                snapshot.data!.issuer.logo,
                            )
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            snapshot.data!.issuer.title,
                            style: const TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 14
                            ),
                          ),
                        )
                      ],
                    )
                ),
              );

              Widget brandIntro = Container(
                padding: const EdgeInsets.only(left: 22, right: 25),
                child: DescriptionTextWidget(text: snapshot.data!.description, minLines: 2,),
              );

              const titles = ["发行总量", "已铸造", "持有者", "铸造资格说明", "铸造时间", "合约地址"];
              List<String> values = [
                snapshot.data!.totalAmount.toString(),
                snapshot.data!.mintedAmount.toString(),
                snapshot.data!.holdPersonAmount.toString(),
                "购买线下实体并使用手机号登录，即可获得铸造资格",
                snapshot.data!.startedTime,
                snapshot.data!.contract];
              Widget detailList = Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 130),
                child: ListView.separated(
                  itemCount: titles.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Widget titleText = Container(
                      padding: const EdgeInsets.only(right: 35),
                      child: Text(
                        titles[index],
                        style: const TextStyle(
                            color: Color(0xb3ffffff),
                            fontSize: 14
                        ),
                      ),
                    );

                    Widget valueText = Expanded(
                        child: Text(
                          values[index],
                          textAlign: TextAlign.right,
                          maxLines: index == 3 ? 2 : 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 14
                          ),
                        )
                    );

                    Widget copyButton = GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: values[values.length - 1]));
                          MessageToast.showMessage("复制成功");
                        }, // Image tapped
                        child: Image.asset(
                          "images/copy.png",
                          width: 23,
                          height: 23,
                        )
                    );

                    Widget linkButton = GestureDetector(
                        onTap: () {
                        }, // Image tapped
                        child: Image.asset(
                          "images/link.png",
                          width: 23,
                          height: 23,
                        )
                    );

                    return Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: index < titles.length - 1 ? [titleText, valueText] : [
                            titleText,
                            valueText,
                            Container(
                              padding: const EdgeInsets.only(left: 9, right: 9),
                              child: copyButton,
                            ),
                            linkButton
                          ]
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(color: Color(0x1affffff));
                  },
                ),
              );

              Widget mintButton = ElevatedButton(
                onPressed: (){
                  _startMint(snapshot.data!.uid);
                },
                style: ElevatedButton.styleFrom(
                    primary: _mintColor
                ),
                child: Text(
                    _mintText,
                    style: const TextStyle(
                        color: Color(0xff000000),
                        fontSize: 18
                    )
                ),
              );

              Widget bottomPanel = ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 12, bottom: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: _getMintTitle(snapshot.data!.userMintedAmount??0, snapshot.data!.mintChances??0),
                          ),
                        ),
                        mintButton,
                        const SizedBox(height: 20,)
                      ],
                    ),
                  ),
                ),
              );

              Widget nftCard = Container(
                color: const Color(0x80ffffff),
                child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5
                    ),
                    child: Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff3c63f8),
                          borderRadius: BorderRadius.all(
                              Radius.circular(8)
                          ),
                        ),
                        width: 300,
                        height: 465,
                        child: Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 18),
                                width: 266,
                                height: 325,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/MintPopUpOutline.png"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                        child: Image.network(
                                          _mintedNft == null ? "" : _mintedNft!.cover,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          _mintedNft == null ? "" : "${_mintedNft!.projectName} ${_mintedNft!.tokenId}",
                                          style: const TextStyle(
                                              color: Color(0xffffffff),
                                              fontSize: 20
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ),
                            Container(
                                padding: const EdgeInsets.only(top: 17, bottom: 19),
                                child: ElevatedButton(
                                  onPressed: (){
                                    setState(() {
                                      _showNftCard = false;
                                    });
                                    if (_mintedNft != null) {
                                      // Navigator.of(context).pushNamed("/nft", arguments: _mintedNft);
                                      Get.toNamed("${Routes.nft}?uid=${_mintedNft!.uid}");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color(0xffffffff)
                                  ),
                                  child: const Text(
                                    "立即查看",
                                    style: TextStyle(
                                        color: Color(0xff3c63f8),
                                        fontSize: 18
                                    ),
                                  ),
                                )
                            ),
                            RichText(
                              text: const TextSpan(
                                  text: "您之后可以在 ",
                                  style: TextStyle(
                                      color: Color(0x80ffffff),
                                      fontSize: 14
                                  ),
                                  children: [
                                    TextSpan(
                                        text: "我的-我的NFT",
                                        style: TextStyle(
                                            color: Color(0xccffffff),
                                            fontSize: 14
                                        )
                                    ),
                                    TextSpan(
                                        text: " 查看",
                                        style: TextStyle(
                                            color: Color(0x80ffffff),
                                            fontSize: 14
                                        )
                                    )
                                  ]
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                ),
              );

              Widget mintInfo = Container(
                color: const Color(0x80ffffff),
                child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5
                    ),
                    child: Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff3c63f8),
                          borderRadius: BorderRadius.all(
                              Radius.circular(8)
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 38, right: 38),
                        width: 300,
                        height: 241,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10, bottom: 6),
                              child: const Text(
                                "铸造资格说明",
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 18
                                ),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(bottom: 24),
                                width: 266,
                                height: 88,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/MintInfoOutline.png"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "购买线下实体\n 并使用手机号登录\n 即可获得铸造资格",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xccffffff),
                                        fontSize: 16
                                    ),
                                  ),
                                )
                            ),
                            SizedBox(
                                width: 266,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: (){
                                    setState(() {
                                      _showMintInfo = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color(0xffffffff)
                                  ),
                                  child: const Text(
                                    "好的",
                                    style: TextStyle(
                                        color: Color(0xff3c63f8),
                                        fontSize: 18
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    )
                ),
              );

              //ignore: undefined_prefixed_name
              ui.platformViewRegistry.registerViewFactory('login', (int viewId) {
                return html.IFrameElement()
                  ..style.width = '100%'
                  ..style.height = '100%'
                  ..src = 'https://zheshi.tech/public/dist/?method=cfx_accounts'
                  ..style.border = 'none';
              });

              Widget loginPanel = Container(
                color: const Color(0x80ffffff),
                child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: const HtmlElementView(viewType: 'login'),
                          ),
                        ),
                        Positioned(
                            right: 23,
                            top: Global.titleButtonTop,
                            child: GestureDetector(
                                onTap: () {
                                  _switchLoginPanel(false);
                                }, // Image tapped
                                child: Image.asset(
                                  "images/close_panel.png",
                                  width: 29,
                                  height: 29,
                                )
                            )
                        )
                      ],
                    )
                ),
              );


              return Stack(
                alignment:Alignment.center ,
                children: [
                  ListView(
                    children: [
                      images,
                      projectTitle,
                      brandInfo,
                      brandIntro,
                      detailList
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    child: bottomPanel,
                  ),
                  _showMintInfo ? mintInfo : const SizedBox(height: 0),
                  _showNftCard ? nftCard : const SizedBox(height: 0),
                  _showLoginPanel ? loginPanel : const SizedBox(height: 0)
                ],
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
    );

    return Material(
      color: const Color(0xff3c63f8),
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: projectDetailStack,
      ),
    );
  }

  MintState _getMintState(String? token, bool? isOpened, int? mintChance) {
    if (token == null) {
      return MintState.notLogIn;
    } else if (isOpened == null || !isOpened) {
      return MintState.unopened;
    } else if (mintChance == null || mintChance <= 0) {
      return MintState.unqualified;
    }
    return MintState.mint;
  }

  void _setMintState(MintState mintState) {
    setState(() {
      _mintState = mintState;
      _mintColor = mintToColor[mintState]!;
      _mintText = mintToText[mintState]!;
    });
  }

  void _switchLoginPanel(bool show) {
    setState(() {
      _showLoginPanel = show;
    });
  }

  List<Widget> _getMintTitle(int userMintedAmount, int mintChances) {
    String description = "";
    if (_mintState == MintState.notLogIn) {
      description = "请登陆后查看铸造资格";
    } else if (_mintState == MintState.unqualified) {
      description = "未获得铸造资格";
    } else if (userMintedAmount == 0){
      description = "剩余$mintChances次铸造机会";
    } else {
      description = "已铸造$userMintedAmount次，剩余$mintChances次铸造机会";
    }
    Widget text =  Text(
      description,
      style: const TextStyle(
          color: Color(0xffffffff),
          fontSize: 14
      ),
    );
    Widget button = GestureDetector(
        onTap: () {
          setState(() {
            _showMintInfo = true;
          });
        }, // Image tapped
        child: Image.asset(
          "images/info.png",
          width: 17,
          height: 17,
        )
    );
    if (_mintState == MintState.notLogIn) {
      return [text];
    } else {
      return [text, button];
    }
  }

  void _startMint(String uid) async {
    if (_mintState == MintState.notLogIn) {
      _switchLoginPanel(true);
    }else if (_mintState == MintState.mint) {
      _setMintState(MintState.minting);
      try {
        _mintedNft = await HttpRequest.projectMint(uid, DataStorage.getToken()!);
        setState(() {
          _showNftCard = true;
          _futureProject = HttpRequest.loadProjectDetail(uid: _projectUid, token: DataStorage.getToken());
          _initMintState = false;
        });
      } catch (e) {
        MessageToast.showException(e.toString());
        _setMintState(MintState.mint);
      }
    }
  }

  void _login(String code) async {
    try {
      String token = await HttpRequest.login(code);
      DataStorage.setToken(token);
      Future.delayed(Duration.zero, (){
        setState(() {
          _futureProject = HttpRequest.loadProjectDetail(uid: _projectUid, token: DataStorage.getToken());
          _initMintState = false;
          _showLoginPanel = false;
        });
      });
      MessageToast.showMessage("登录成功");
    } catch(e) {
      print(e.toString());
      Future.delayed(Duration.zero, (){
        setState(() {
          if (DataStorage.getToken() != null) {
            _futureProject = HttpRequest.loadProjectDetail(uid: _projectUid, token: DataStorage.getToken());
            _initMintState = false;
          }
          _showLoginPanel = false;
        });
      });
    }
  }
}
