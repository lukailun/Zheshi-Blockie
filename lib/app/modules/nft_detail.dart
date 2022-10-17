// Dart imports:
import 'dart:async';
import 'dart:html';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/event/controllers/event_controller.dart';
import 'package:blockie_app/app/modules/share/controllers/share_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/extensions/get_extension.dart';
import 'package:blockie_app/models/app_bar_button_item.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/models/global.dart';
import 'package:blockie_app/models/nft_info.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_icon_button.dart';
import 'package:blockie_app/widgets/description_text.dart';
import 'package:blockie_app/widgets/ellipsized_text.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:blockie_app/widgets/screen_bound.dart';

class NftPage extends StatefulWidget {
  const NftPage({Key? key}) : super(key: key);

  @override
  _NftPageState createState() => _NftPageState();
}

class _NftPageState extends State<NftPage> {
  NftInfo? _nftInfo;
  bool updatedNftUrl = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('blockie_moment', (int viewId) {
      return IFrameElement()
        ..id = "iframe"
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.border = 'none';
    });
    if (_nftInfo == null) {
      _isLoading = true;
      Future.delayed(Duration.zero, () async {
        NftInfo nftInfo =
            await HttpRequest.loadNft(uid: Get.jsonParameters["uid"]!);
        setState(() {
          _nftInfo = nftInfo;
          _isLoading = false;
        });
      });
    }
  }

  String getNftSceneUrl(NftInfo nftInfo) {
    switch (nftInfo.type) {
      case 2:
        return 'https://sandbox.blockie.zheshi.tech?type=cube&video=${nftInfo.video}&image0=${nftInfo.textures['part0'] ?? ''}&image1=${nftInfo.textures['part1'] ?? ''}&image2=${nftInfo.textures['part2'] ?? ''}&image3=${nftInfo.textures['part3'] ?? ''}&image4=${nftInfo.textures['part4'] ?? ''}';
      case 3:
        return 'https://sandbox.blockie.zheshi.tech?type=card&image1=${nftInfo.textures['part0'] ?? ''}&image2=${nftInfo.textures['part1'] ?? ''}';
      case 4:
        return 'https://sandbox.blockie.zheshi.tech?type=kettlebell&model=${nftInfo.model}';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_nftInfo == null) {
      return ScreenBoundary(
        body: Container(
          padding: const EdgeInsets.only(top: Global.titleButtonTop),
          color: AppThemeData.primaryColor,
          child: const Expanded(child: LoadingIndicator()),
        ),
      );
    }
    if (!updatedNftUrl) {
      Future.delayed(Duration.zero, () async {
        setState(() {
          IFrameElement? element =
              document.getElementById('iframe') as IFrameElement?;
          if (element != null) {
            element.src = getNftSceneUrl(_nftInfo!);
            updatedNftUrl = true;
          }
        });
      });
    }

    Widget webView = SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      child: const IgnorePointer(
          child: HtmlElementView(viewType: 'blockie_moment')),
    );

    Widget nftImage = Image.network(
      _nftInfo!.image ?? '',
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.contain,
    );

    Widget webPanel = _nftInfo!.type == 1 ? nftImage : webView;

    Widget projectTitle = Container(
      padding: const EdgeInsets.only(left: 22, right: 22, top: 14, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _nftInfo!.projectName,
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
            final parameters = {
              'issuerUid': _nftInfo!.issuer.uid,
            };
            Get.toNamedWithJsonParameters(Routes.brand, parameters: parameters);
          },
          child: Row(
            children: [
              CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    _nftInfo!.issuer.logo,
                  )),
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  _nftInfo!.issuer.title,
                  style:
                      const TextStyle(color: Color(0xffffffff), fontSize: 14),
                ),
              ),
              const Expanded(child: SizedBox()),
              Text(
                "限量${_nftInfo!.projectAmount}",
                style: const TextStyle(color: Color(0xccffffff), fontSize: 14),
              ),
            ],
          )),
    );

    Widget description = DescriptionTextWidget(
      text: _nftInfo == null ? "" : _nftInfo!.projectSummary,
      minLines: 2,
    );

    TextStyle itemNameStyle =
        const TextStyle(color: Color(0xb3ffffff), fontSize: 13);

    TextStyle itemValueStyle =
        const TextStyle(color: Color(0xffffffff), fontSize: 14);

    Widget copyButton = BasicIconButton(
      assetName: "images/app_bar/copy.png",
      size: 23,
      onTap: () {
        try {
          Clipboard.setData(ClipboardData(text: _nftInfo!.projectContract));
          MessageToast.showMessage("复制成功");
        } catch (e) {
          MessageToast.showException(e.toString());
        }
      },
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
              )),
              Container(
                padding: const EdgeInsets.only(right: 3),
                width: 150,
                child: EllipsizedText(
                  _nftInfo!.projectContract,
                  style: itemValueStyle,
                  ellipsis: Ellipsis.middle,
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
              )),
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
    final menuItems = [
      AppBarButtonItem(
        title: '首页',
        assetName: "images/app_bar/home.svg",
        onTap: () => Get.offAllNamed(Routes.initial),
      ),
      AppBarButtonItem(
        title: '我的',
        assetName: "images/app_bar/user.svg",
        onTap: () {
          final parameters = {
            'uid': AuthService.to.userInfo.value?.uid ?? "",
          };
          Get.toNamedWithJsonParameters(Routes.user, parameters: parameters);
        },
      ),
    ];
    return ScreenBoundary(
      body: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: BasicAppBar(
          title: "${_nftInfo?.projectName ?? ""} ${_nftInfo?.tokenId ?? ""}",
          buttonStyle: AppBarButtonStyle.flat,
          actionItems: [
            AppBarButtonItem(
              assetName: "images/app_bar/share.svg",
              onTap: () {
                final parameters = {
                  ShareParameter.ID: _nftInfo?.uid ?? "",
                  ShareParameter.isNFT: true,
                  ShareParameter.title: _nftInfo?.projectName ?? '',
                  ShareParameter.description: _nftInfo?.projectSummary ?? '',
                  ShareParameter.imageUrl: _nftInfo?.image,
                };
                Get.toNamedWithJsonParameters(Routes.share,
                    parameters: parameters);
              },
            ),
            AppBarButtonItem(
              assetName: "images/app_bar/menu.svg",
              items: menuItems,
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 0),
          children: [
            webPanel,
            Stack(
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
                  transform: Matrix4.translationValues(0.0, -16.0, 0.0),
                ),
                Column(
                  children: [
                    // brand,
                    projectTitle,
                    brandInfo,
                    nftDetail,
                  ],
                )
              ],
            )
          ],
        ),
      ),
      padding: 0,
    );
  }
}
