import 'dart:html' as html;
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:blockie_app/app/modules/event/controllers/event_controller.dart';
import 'package:blockie_app/app/modules/share/controllers/share_controller.dart';
import 'package:blockie_app/models/app_bar_button_item.dart';
import 'package:blockie_app/models/nft_info.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_icon_button.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blockie_app/models/global.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/models/image_view_data.dart';
import 'package:blockie_app/models/project_detail_info.dart';
import 'package:blockie_app/widgets/description_text.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:blockie_app/widgets/screen_bound.dart';

import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/widgets/ellipsized_text.dart';
import 'package:blockie_app/widgets/license_dialog.dart';

enum MintState { mint, notLogIn, unopened, unqualified, minting }

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

class ProjectDetailsPage extends StatefulWidget {
  const ProjectDetailsPage({Key? key}) : super(key: key);

  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  bool _showNftCard = false;
  bool _showMintInfo = false;
  NftInfo? _mintedNft;
  MintState _mintState = MintState.mint;
  Color _mintColor = mintToColor[MintState.mint]!;
  String _mintText = mintToText[MintState.mint]!;
  bool _updatedMintState = false;
  bool _showLoginPanel = false;
  Future<ProjectDetailInfo>? _futureProject;
  String? _projectUid;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _projectUid = Get.parameters["projectUid"];
        _futureProject = HttpRequest.loadProjectDetail(
            uid: _projectUid, token: DataStorage.getToken());
      });
    });
    AnyWebService.to.accountsCode.listen((event) {
      if (event.isSuccessful) {
        _login(event.data as String);
      } else {
        setState(() {
          _showLoginPanel = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget projectDetailStack = FutureBuilder<ProjectDetailInfo>(
      future: _futureProject,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        if (!_updatedMintState) {
          Future.delayed(Duration.zero, () {
            _setMintState(_getMintState(DataStorage.getToken(),
                snapshot.data!.isOpen, snapshot.data!.mintChances));
            _updatedMintState = true;
          });
        }
        Widget images = Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(snapshot.data!.cover),
                fit: BoxFit.cover,
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: Global.titleButtonTop),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 22),
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.images.length + 1,
                      padding: const EdgeInsets.only(top: 0),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Container(width: 20);
                        } else {
                          return Container(
                              width: 50,
                              height: 50,
                              margin: const EdgeInsets.only(right: 9),
                              child: GestureDetector(
                                onTap: () {
                                  var data = ImageViewData(
                                      snapshot.data!.images, index - 1);
                                  // Navigator.of(context).pushNamed("/image_view", arguments: data);
                                  Get.toNamed(
                                      "${Routes.imageView}?index=${index - 1}&projectUid=${snapshot.data!.uid}");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: const Color(0x66ffffff)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(2)),
                                  ),
                                  child: Image.network(
                                    snapshot.data!.images[index - 1],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ));
                        }
                      }),
                )
              ],
            ));

        Widget projectTitle = Container(
          padding:
              const EdgeInsets.only(left: 22, right: 22, top: 14, bottom: 8),
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
                    ]),
              )
            ],
          ),
        );

        Widget brandInfo = Container(
          padding: const EdgeInsets.only(left: 22, right: 22, bottom: 13),
          child: GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed("/brand", arguments: snapshot.data!.issuer);
                Get.toNamed(
                    "${Routes.brand}?issuerUid=${snapshot.data!.issuer.uid}");
              },
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                        snapshot.data!.issuer.logo,
                      )),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      snapshot.data!.issuer.title,
                      style: const TextStyle(
                          color: Color(0xffffffff), fontSize: 14),
                    ),
                  )
                ],
              )),
        );

        Widget brandIntro = Container(
          padding: const EdgeInsets.only(left: 22, right: 25),
          child: DescriptionTextWidget(
            text: snapshot.data!.description,
            minLines: 2,
          ),
        );

        const titles = ["发行总量", "已铸造", "持有者", "铸造资格说明", "铸造时间", "合约地址"];
        List<String> values = [
          snapshot.data!.totalAmount.toString(),
          snapshot.data!.mintedAmount.toString(),
          snapshot.data!.holdPersonAmount.toString(),
          "购买线下实体并使用手机号登录，即可获得铸造资格",
          snapshot.data!.startedTime,
          snapshot.data!.contract
        ];
        Widget detailList = Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 180),
          child: ListView.separated(
            itemCount: titles.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(top: 0),
            itemBuilder: (BuildContext context, int index) {
              Widget titleText = Container(
                padding: const EdgeInsets.only(right: 35),
                child: Text(
                  titles[index],
                  style:
                      const TextStyle(color: Color(0xb3ffffff), fontSize: 14),
                ),
              );

              Widget valueText = Expanded(
                  child: index != 5
                      ? Text(
                          values[index],
                          textAlign: TextAlign.right,
                          maxLines: index == 3 ? 2 : 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color(0xffffffff), fontSize: 14),
                        )
                      : EllipsizedText(
                          values[index],
                          style: const TextStyle(
                              color: Color(0xffffffff), fontSize: 14),
                          ellipsis: Ellipsis.middle,
                        ));

              Widget copyButton = BasicIconButton(
                assetName: "images/app_bar/copy.png",
                size: 23,
                onTap: () {
                  Clipboard.setData(
                      ClipboardData(text: values[values.length - 1]));
                  MessageToast.showMessage("复制成功");
                },
              );

              Widget linkButton = GestureDetector(
                  onTap: () {}, // Image tapped
                  child: Image.asset(
                    "images/link.png",
                    width: 23,
                    height: 23,
                  ));

              return Container(
                padding: const EdgeInsets.only(top: 15, bottom: 0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: index < titles.length - 1
                        ? [titleText, valueText]
                        : [
                            titleText,
                            valueText,
                            Container(
                              padding: const EdgeInsets.only(left: 9, right: 9),
                              child: copyButton,
                            ),
                            linkButton
                          ]),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(color: Color(0x1affffff));
            },
          ),
        );

        Widget mintButton = ElevatedButton(
          onPressed: () {
            _startMint(snapshot.data!.uid);
          },
          style: ElevatedButton.styleFrom(
              primary: _mintColor,
              elevation: 20,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text(_mintText,
              style: const TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        );

        Widget bottomPanel = Container(
            decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(color: Colors.white24, width: 1))),
            width: double.infinity,
            height: 160,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    _getMintTitle(snapshot.data!.userMintedAmount ?? 0,
                        snapshot.data!.mintChances ?? 0),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: 60,
                      child: mintButton,
                    )
                  ],
                ),
              ),
            ));

        Widget nftCard = Container(
          color: const Color(0x80ffffff),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff3c63f8),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  width: 300,
                  height: 465,
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      SizedBox(
                          width: 266,
                          height: 325,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 5),
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
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    _mintedNft == null
                                        ? ""
                                        : "${_mintedNft!.projectName} ${_mintedNft!.tokenId}",
                                    style: const TextStyle(
                                        color: Color(0xffffffff), fontSize: 15),
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )).outlined(),
                      Container(
                          padding: const EdgeInsets.only(top: 17, bottom: 19),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _showNftCard = false;
                              });
                              if (_mintedNft != null) {
                                // Navigator.of(context).pushNamed("/nft", arguments: _mintedNft);
                                Get.toNamed(
                                    "${Routes.nft}?uid=${_mintedNft!.uid}");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                onPrimary: const Color(0xff3c63f8),
                                primary: const Color(0xffffffff),
                                shadowColor: Colors.black,
                                elevation: 10.0),
                            child: const SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: Center(
                                child: Text(
                                  "立即查看",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          )),
                      RichText(
                        text: const TextSpan(
                            text: "您之后可以在 ",
                            style: TextStyle(
                                color: Color(0x80ffffff), fontSize: 14),
                            children: [
                              TextSpan(
                                  text: "我的-我的NFT",
                                  style: TextStyle(
                                      color: Color(0xccffffff), fontSize: 14)),
                              TextSpan(
                                  text: " 查看",
                                  style: TextStyle(
                                      color: Color(0x80ffffff), fontSize: 14))
                            ]),
                      )
                    ],
                  ),
                ),
              )),
        );

        Widget mintInfo = Container(
          color: const Color(0x80ffffff),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff3c63f8),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
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
                          style:
                              TextStyle(color: Color(0xffffffff), fontSize: 18),
                        ),
                      ),
                      Container(
                          width: 266,
                          height: 88,
                          child: const Center(
                            child: Text(
                              "购买线下实体\n 并使用手机号登录\n 即可获得铸造资格",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xccffffff), fontSize: 16),
                            ),
                          )).outlined().paddingOnly(bottom: 24),
                      SizedBox(
                          width: 266,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _showMintInfo = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xffffffff)),
                            child: const Text(
                              "好的",
                              style: TextStyle(
                                  color: Color(0xff3c63f8), fontSize: 18),
                            ),
                          )),
                    ],
                  ),
                ),
              )),
        );

        //ignore: undefined_prefixed_name
        ui.platformViewRegistry.registerViewFactory('login', (int viewId) {
          return html.IFrameElement()
            ..style.width = '100%'
            ..style.height = '100%'
            ..src = 'https://zheshi.tech/public/dist/?method=cfx_accounts'
            ..style.border = 'none';
        });

        Widget loginPanel = BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: const HtmlElementView(viewType: 'login'));

        return Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              padding: const EdgeInsets.only(top: 0),
              children: [
                Stack(
                  children: [
                    images,
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppThemeData.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 100,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFB3BCC5),
                                  Color(0xFF3C63F8),
                                ],
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              projectTitle,
                              brandInfo,
                              brandIntro,
                              detailList
                            ],
                          )
                        ],
                      ),
                    ).paddingOnly(top: MediaQuery.of(context).size.width - 16)
                  ],
                )
              ],
            ),
            if (!_showLoginPanel)
              Container(
                alignment: Alignment.bottomCenter,
                child: bottomPanel,
              ),
            if (_showMintInfo) mintInfo,
            if (_showNftCard) nftCard,
            if (_showLoginPanel) loginPanel,
          ],
        );
      },
    );
    final menuItems = [
      AppBarButtonItem(
        title: '首页',
        assetName: "images/app_bar/home.png",
        onTap: () => Get.offAllNamed(Routes.initial),
      ),
      AppBarButtonItem(
        title: '我的',
        assetName: "images/app_bar/user.png",
        onTap: () => Get.toNamed(
            "${Routes.user}?uid=${AuthService.to.userInfo.value?.uid ?? ""}"),
      ),
    ];
    menuItems.add(
      AppBarButtonItem(
        title: '铸造规则',
        assetName: "images/app_bar/info.png",
        onTap: () =>
            Get.toNamed("${Routes.event}?${EventParameter.ID}=$_projectUid"),
      ),
    );
    return ScreenBoundary(
      body: Scaffold(
        appBar: !_showLoginPanel
            ? BasicAppBar(
                buttonStyle: AppBarButtonStyle.flat,
                actionItems: [
                  AppBarButtonItem(
                    assetName: "images/app_bar/share.png",
                    onTap: () => Get.toNamed(Routes.share, arguments: {
                      ShareParameter.ID: _projectUid,
                      ShareParameter.isNFT: false,
                    }),
                  ),
                  AppBarButtonItem(
                    assetName: "images/app_bar/menu.png",
                    items: menuItems,
                  ),
                ],
              )
            : null,
        extendBodyBehindAppBar: true,
        body: projectDetailStack,
      ),
      padding: 0,
    );
  }

  MintState _getMintState(String? token, bool? isOpened, int? mintChance) {
    if ((token ?? "").isEmpty) {
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

  Widget _getMintTitle(int userMintedAmount, int mintChances) {
    String description = "";
    if (_mintState == MintState.notLogIn) {
      description = "请登陆后查看铸造资格";
    } else if (_mintState == MintState.unqualified) {
      description = "未获得铸造资格";
    } else if (userMintedAmount == 0) {
      description = "剩余$mintChances次铸造机会";
    } else {
      description = "已铸造$userMintedAmount次，剩余$mintChances次铸造机会";
    }
    Widget text = Text(
      description,
      style: const TextStyle(color: Color(0xffffffff), fontSize: 17),
    );
    if (_mintState == MintState.notLogIn) {
      return text;
    }
    Widget b = GestureDetector(
        onTap: () {
          setState(() {
            _showMintInfo = true;
          });
        }, // Image tapped
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            text,
            const SizedBox(
              width: 5,
            ),
            Image.asset(
              "images/hint.png",
              width: 20,
              height: 20,
            )
          ],
        ));
    return b;
  }

  void _showLicenseDialog() {
    Get.dialog(LicenseDialog(
      onTermsOfServiceTap: () {
        Get.back();
      },
      onPrivacyPolicyTap: () {
        Get.back();
      },
      onPositiveButtonTap: () {
        Get.back();
        _switchLoginPanel(true);
      },
      onNegativeButtonTap: () => Get.back(),
    ));
  }

  void _startMint(String uid) async {
    if (_mintState == MintState.notLogIn) {
      _showLicenseDialog();
    } else if (_mintState == MintState.mint) {
      _setMintState(MintState.minting);
      try {
        _mintedNft =
            await HttpRequest.projectMint(uid, DataStorage.getToken()!);
        setState(() {
          _showNftCard = true;
          _futureProject = HttpRequest.loadProjectDetail(
              uid: _projectUid, token: DataStorage.getToken());
          _updatedMintState = false;
        });
      } catch (e) {
        MessageToast.showException(e.toString());
        _setMintState(MintState.mint);
      }
    }
  }

  void _login(String code) async {
    try {
      Map<String, dynamic> res = await HttpRequest.login(code);
      String token = res['token'];
      UserInfo userInfo = res['user'];
      DataStorage.setToken(token);
      DataStorage.setUserUid(userInfo.uid);
      setState(() {
        _futureProject = HttpRequest.loadProjectDetail(
            uid: _projectUid, token: DataStorage.getToken());
        _updatedMintState = false;
        _showLoginPanel = false;
      });
    } catch (e) {
      setState(() {
        _futureProject = HttpRequest.loadProjectDetail(
            uid: _projectUid, token: DataStorage.getToken());
        _updatedMintState = false;
        _showLoginPanel = false;
      });
    }
  }
}
