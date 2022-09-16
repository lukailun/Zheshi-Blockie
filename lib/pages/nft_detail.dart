import 'dart:async';
import 'dart:convert';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;
import 'dart:html';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:blockie_app/widgets/description_text.dart';
import 'package:blockie_app/common/global.dart';
import 'package:blockie_app/common/nft_info.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:blockie_app/common/routes.dart';
import 'package:get/get.dart';

class NftPage extends StatefulWidget{
  const NftPage({Key? key}) : super(key: key);

  @override
  _NftPageState createState() => _NftPageState();
}

class _NftPageState extends State<NftPage> {
  NftInfo? _nftInfo;
  bool updatedNftUrl = false;
  @override
  void initState() {
    // Future.delayed(Duration.zero,(){
    //   setState(() {
    //     _nftInfo = ModalRoute.of(context)!.settings.arguments as NftInfo;
    //   });
    // });
    super.initState();
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('blockie_moment', (int viewId) {
      return IFrameElement()
        ..id="iframe"
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.border = 'none';
    });
  }

  String getNftSceneUrl(NftInfo nftInfo) {
    switch(nftInfo.type) {
      case 2:
        return 'https://sandbox.blockie.zheshi.tech?type=cube&video=${nftInfo.video}&image1=${nftInfo.textures['part1']??''}&image2=${nftInfo.textures['part2']??''}&image3=${nftInfo.textures['part3']??''}&image4=${nftInfo.textures['part4']??''}';
      case 3:
        return 'https://sandbox.blockie.zheshi.tech?type=card&image1=${nftInfo.textures['part0']??''}&image2=${nftInfo.textures['part1']??''}';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_nftInfo == null) {
      Future.delayed(Duration.zero,() async {
        NftInfo nftInfo = await HttpRequest.loadNft(uid: Get.parameters["uid"]!);
        setState(() {
          // _nftInfo = ModalRoute.of(context)!.settings.arguments as NftInfo;
          _nftInfo = nftInfo;
          // _nftInfo = Get.arguments;
        });
      });
      return const Material(
        color: Color(0xff3c63f8),
        child: SizedBox(),
      );
    }
    if (!updatedNftUrl) {
      Future.delayed(Duration.zero,() async {
        setState(() {
          IFrameElement? element = document.getElementById('iframe') as IFrameElement?;
          if (element != null) {
            element.src = getNftSceneUrl(_nftInfo!);
            updatedNftUrl = true;
          }
        });
      });
    }

    Widget webView = SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
      child: const HtmlElementView(viewType: 'blockie_moment'),
    );

    Widget nftImage = Image.network(
      _nftInfo!.image??'',
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.contain,
    );

    Widget title = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 22),
          child: PointerInterceptor(
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  }, // Image tapped
                  child: Image.asset(
                    "images/back.png",
                    width: 29,
                    height: 29,
                  )
              )
          ),
        ),
        Expanded(
          child: Text(
            "${_nftInfo!.projectName} ${_nftInfo!.tokenId}",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color(0xffffffff),
                fontSize: 20
            ),
          )
        ),
        Container(
          padding: const EdgeInsets.only(right: 22),
          child: PointerInterceptor(
            child: GestureDetector(
                onTap: () {
                  try {
                    Clipboard.setData(ClipboardData(text: Global.webLink + Get.currentRoute));
                    MessageToast.showMessage("复制nft成功");
                  } catch (e) {
                    MessageToast.showException(e.toString());
                  }
                }, // Image tapped
                child: Image.asset(
                  "images/copy.png",
                  width: 23,
                  height: 23,
                )
            ),
          ),
        )
      ],
    );

    Widget zoomButton = GestureDetector(
        onTap: () {
          Navigator.pop(context);
        }, // Image tapped
        child: Image.asset(
          "images/zoom.png",
          width: 29,
          height: 29,
        )
    );

    Widget webPanel = Stack(
      alignment: Alignment.center,
      children: [
        _nftInfo!.type == 1 ? nftImage : webView,
        Positioned(
            top: Global.titleButtonTop,
            width: MediaQuery.of(context).size.width,
            child: title
        ),
        // Positioned(
        //     bottom: 22,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [zoomButton],
        //     ),
        // )
      ],
    );

    Widget brand = Container(
      padding: const EdgeInsets.only(left: 19, right: 22, top: 20, bottom: 25),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 5),
            child: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(_nftInfo!.issuer.logo),
            ),
          ),
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        _nftInfo!.projectName,
                        style: const TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 16
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _nftInfo!.issuer.title,
                        style: const TextStyle(
                          color: Color(0xccffffff),
                          fontSize: 14
                        ),
                      ),
                      Text(
                        "限量${_nftInfo!.projectAmount}",
                        style: const TextStyle(
                          color: Color(0xccffffff),
                          fontSize: 14
                        ),
                      )
                    ],
                  )
                ],
              )
          )
        ],
      ),
    );

    Widget description = DescriptionTextWidget(text: _nftInfo == null ? "" : _nftInfo!.projectSummary, minLines: 2,);

    TextStyle itemNameStyle = const TextStyle(
      color: Color(0xb3ffffff),
      fontSize: 13
    );

    TextStyle itemValueStyle = const TextStyle(
      color: Color(0xffffffff),
      fontSize: 14
    );

    Widget copyButton = GestureDetector(
        onTap: () {
          try {
            Clipboard.setData(ClipboardData(text: _nftInfo!.projectContract));
            MessageToast.showMessage("复制成功");
          } catch (e) {
            MessageToast.showException(e.toString());
          }
        }, // Image tapped
        child: Image.asset(
          "images/copy.png",
          width: 23,
          height: 23,
        )
    );

    Widget nftDetail = Container(
      padding: const EdgeInsets.only(left: 22, right: 22, bottom: 22),
      height: 185,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          description,
          Row(
            children: [
              Expanded(
                  child: Text(
                    "合约地址",
                    style: itemNameStyle,
                  )
              ),
              Container(
                padding: const EdgeInsets.only(right: 3),
                width: 150,
                child: Text(
                  _nftInfo!.projectContract,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: itemValueStyle,
                ),
              ),
              copyButton
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "铸造时间",
                style: itemNameStyle,
              ),
              Text(
                _nftInfo!.mintedAt,
                style: itemValueStyle,
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                    "持有者",
                    style: itemNameStyle,
                  )
              ),
              Container(
                padding: const EdgeInsets.only(right: 3),
                child: CircleAvatar(
                  radius: 11,
                  backgroundImage: NetworkImage(_nftInfo!.user.avatar),
                ),
              ),
              Text(
                _nftInfo!.user.nickname,
                style: itemValueStyle,
              )
            ],
          )
        ],
      ),
    );

    return Material(
      color: const Color(0xff3c63f8),
      child: ListView(
        children: [
          webPanel,
          brand,
          nftDetail
        ],
      ),
    );
  }
}