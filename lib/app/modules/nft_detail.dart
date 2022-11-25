// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:ui' as ui;

// Flutter imports:
import 'package:blockie_app/app/modules/nft_details/controllers/nft_details_controller.dart';
import 'package:blockie_app/data/models/nft_info.dart';
import 'package:blockie_app/data/models/wechat_shareable.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/brand_details/controllers/brand_details_controller.dart';
import 'package:blockie_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:blockie_app/app/modules/share/controllers/share_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/models/wechat_share_source.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/data/models/app_bar_button_item.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/clipboard_utils.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_icon_button.dart';
import 'package:blockie_app/widgets/ellipsized_text.dart';
import 'package:blockie_app/widgets/expandable_text.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:blockie_app/widgets/message_toast.dart';

class NftPage extends StatefulWidget {
  const NftPage({Key? key}) : super(key: key);

  @override
  _NftPageState createState() => _NftPageState();
}

class _NftPageState extends State<NftPage> with WechatShareable {
  NftInfo? _nftInfo;
  bool updatedNftUrl = false;
  bool _goneToShare = false;
  final _uid = Get.parameters["id"] as String;
  StreamSubscription<html.MessageEvent>? _scription;

  @override
  void initState() {
    super.initState();
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('blockie_moment', (int viewId) {
      return html.IFrameElement()
        ..id = "iframe"
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.border = 'none';
    });
    if (_nftInfo == null) {
      Future.delayed(Duration.zero, () async {
        NftInfo nftInfo = await HttpRequest.loadNft(uid: _uid);
        setState(() {
          _nftInfo = nftInfo;
          isDefaultConfig = false;
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDefaultConfig = true;
    _scription?.cancel();
    _scription = null;
  }

  String getNftSceneUrl(NftInfo nftInfo) {
    String url = '';
    switch (nftInfo.type) {
      case 2:
        url =
            'https://sandbox.blockie.zheshi.tech?type=cube&video=${nftInfo.video}&model=${nftInfo.model}&images=${jsonEncode(nftInfo.modelImage)}';
        break;
      case 3:
        url =
            'https://sandbox.blockie.zheshi.tech?type=card&image1=${nftInfo.textures['part0'] ?? ''}&image2=${nftInfo.textures['part1'] ?? ''}';
        break;
      case 4:
        url =
            'https://sandbox.blockie.zheshi.tech?type=model&model=${nftInfo.model}&images=${jsonEncode(nftInfo.modelImage)}';
        break;
      default:
        break;
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    if (_nftInfo == null) {
      return Container(
        padding: const EdgeInsets.only(top: 23),
        color: AppThemeData.primaryColor,
        child: const Expanded(child: LoadingIndicator()),
      );
    }
    if (!updatedNftUrl) {
      Future.delayed(Duration.zero, () async {
        setState(() {
          html.IFrameElement? element =
              html.document.getElementById('iframe') as html.IFrameElement?;
          if (element != null) {
            element.src = getNftSceneUrl(_nftInfo!);
            element.onLoad.listen((event) async {
              _scription?.cancel();
              _scription = html.window.onMessage
                  .listen((html.MessageEvent messageEvent) {
                final data = messageEvent.data;
                final event = jsonDecode(data);
                final status = event['status'];
                final method = event['method'];
                if (status == 'ok' && method == 'download') {
                  if (_goneToShare) {
                    return;
                  }
                  _goneToShare = true;
                  goToShare();
                }
              });
            });
            updatedNftUrl = true;
          }
        });
      });
    }

    Widget webView = SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
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
          onTap: () async {
            final parameters = {
              BrandDetailsParameter.id: _nftInfo?.issuer.id ?? ''
            };
            await Get.toNamed(Routes.brand, parameters: parameters);
            isDefaultConfig = false;
          },
          child: Row(
            children: [
              CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    _nftInfo!.issuer.logoUrl ?? '',
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

    Widget description = ExpandableText(
      text: _nftInfo == null ? "" : _nftInfo!.projectSummary,
      maxLines: 2,
    );

    TextStyle itemNameStyle =
        const TextStyle(color: Color(0xb3ffffff), fontSize: 13);

    TextStyle itemValueStyle =
        const TextStyle(color: Color(0xffffffff), fontSize: 14);

    Widget copyButton = BasicIconButton(
      assetName: "assets/images/common/copy.png",
      size: 23,
      onTap: () {
        final copySuccess =
            ClipboardUtils.copyToClipboard(_nftInfo?.projectContract ?? '');
        MessageToast.showMessage(copySuccess ? '复制成功' : '复制失败');
      },
    );

    Widget nftDetail = Container(
      padding: const EdgeInsets.only(left: 22, right: 22, bottom: 22),
      // height: 185,
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
          ).paddingSymmetric(vertical: 15),
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
          ).paddingSymmetric(vertical: 15),
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
                  backgroundImage: NetworkImage(_nftInfo!.user.avatarUrl),
                ),
              ),
              Text(
                _nftInfo!.user.username,
                style: itemValueStyle,
              )
            ],
          ).paddingSymmetric(vertical: 15),
        ],
      ),
    );
    final menuItems = [
      AppBarButtonItem(
        title: '首页',
        assetName: "assets/images/app_bar/home.png",
        onTap: () => Get.offAllNamed(Routes.activities),
      ),
      AppBarButtonItem(
        title: '我的',
        assetName: "assets/images/app_bar/user.png",
        onTap: () {
          final parameters = {
            ProfileParameter.id: AuthService.to.userInfo.value?.id ?? "",
          };
          Get.offNamed(Routes.profile, parameters: parameters);
        },
      ),
    ];
    final appBar = BasicAppBar(
      pointerIntercepting: true,
      actionItems: [
        AppBarButtonItem(
          assetName: "assets/images/app_bar/share.png",
          onTap: goToShare,
        ),
        AppBarButtonItem(
          assetName: "assets/images/app_bar/menu.png",
          items: menuItems,
        ),
      ],
    );
    return Scaffold(
      backgroundColor: AppThemeData.primaryColor,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: ListView(
        padding: const EdgeInsets.only(top: 0),
        children: [
          Stack(
            children: [
              webPanel,
              SizedBox(
                width: double.infinity,
                child: Text(
                  "${_nftInfo?.projectName ?? ""} ${_nftInfo?.tokenId ?? ""}",
                  maxLines: 2,
                )
                    .textAlignment(TextAlign.center)
                    .textColor(const Color(0xFF666666))
                    .fontSize(19)
                    .paddingOnly(top: appBar.toolbarHeight),
              ).paddingSymmetric(horizontal: 22),
            ],
          ),
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
                      Color(0xFF696969),
                      AppThemeData.primaryColor,
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
                  projectTitle,
                  brandInfo,
                  nftDetail,
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void goToShare() async {
    final parameters = {
      ShareParameter.id: _uid,
      ShareParameter.isNft: 'true',
    };
    await Get.toNamed(Routes.share, parameters: parameters);
    isDefaultConfig = false;
    _goneToShare = false;
  }

  @override
  String description() {
    final nftInfoValue = _nftInfo;
    if (nftInfoValue == null) {
      return WechatShareSource.defaults.getDescription();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getTitle()
        : (nftInfoValue.shareDescription.isNotEmpty
            ? nftInfoValue.shareDescription
            : WechatShareSource.nft
                .getDescription(extraInfo: nftInfoValue.projectSummary));
  }

  @override
  String imageUrl() {
    final nftInfoValue = _nftInfo;
    if (nftInfoValue == null) {
      return WechatShareSource.defaults.getImageUrl();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getTitle()
        : WechatShareSource.nft.getImageUrl(extraInfo: nftInfoValue.cover);
  }

  @override
  String link() {
    final nftInfoValue = _nftInfo;
    if (nftInfoValue == null) {
      return WechatShareSource.defaults.getImageUrl();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getLink()
        : WechatShareSource.nft.getLink(
            extraInfo: '${NftDetailsParameter.id}=${nftInfoValue.uid}');
  }

  @override
  String title() {
    final nftInfoValue = _nftInfo;
    if (nftInfoValue == null) {
      return WechatShareSource.defaults.getTitle();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getTitle()
        : (nftInfoValue.shareTitle.isNotEmpty
            ? nftInfoValue.shareTitle
            : WechatShareSource.nft
                .getTitle(extraInfo: nftInfoValue.projectName));
  }
}
