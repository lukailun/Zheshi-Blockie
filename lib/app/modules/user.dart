import 'dart:convert';
import 'dart:ui';

import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/ellipsized_text.dart';
import 'package:blockie_app/widgets/empty_dataset_view.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/models/nft_info.dart';
import 'package:blockie_app/models/nft_load_info.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:blockie_app/widgets/screen_bound.dart';
import 'package:blockie_app/models/app_bar_button_item.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _showQrCode = false;
  final _nfts = <NftInfo>[];
  String? _nextPageUrl;
  String _qrcode = '';
  bool _isLoading = false;
  bool _myself = false;

  final _userInfo = AuthService.to.userInfo;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _loadUserInfo(Get.parameters["uid"]??'');
      _addNfts();
      _loadQRCode();
    });
    super.initState();
  }

  _loadUserInfo(String uid) async {
    bool myself = uid == DataStorage.getUserUid();
    UserInfo? userInfo;
    if (myself) {
      if (DataStorage.getToken() != null) {
        userInfo = await HttpRequest.getUserInfo(DataStorage.getToken()!);
      }
      AuthService.to.updateUserInfo(userInfo);
    } else {
      userInfo = await HttpRequest.getOtherUserInfo(uid);
    }
    setState(() {
      _myself = myself;
    });
  }

  _loadQRCode() async {
    String qrcode = DataStorage.getToken() == null
        ? ''
        : await HttpRequest.getUserQRCode(DataStorage.getToken()!);
    setState(() {
      _qrcode = qrcode;
    });
  }

  Widget _createNftItem(NftInfo nftInfo) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed("/nft", arguments: nftInfo);
        // print(jsonEncode(nftInfo.json));
        // print(jsonDecode(jsonEncode(nftInfo.json)));
        // Get.toNamed(Routes.nft, arguments: nftInfo);
        Get.toNamed("${Routes.nft}?uid=${nftInfo.uid}");
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
            Container(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(5)
                  ),
                  child: Image.network(
                    nftInfo.cover,
                    fit: BoxFit.contain,
                  ),
                )
            ),
            Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 6),
                        child: Text(
                          "${nftInfo.projectName} ${nftInfo.tokenId}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xffffffff),
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
                      ),
                      Text(
                        "by ${nftInfo.issuer.title}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xccffffff)
                        ),
                      )
                    ],
                  ),
            ),
          ],)
      ).outlined(),
    );
  }

  void _addNfts() {
    String? pageUrl = _nextPageUrl;
    _nextPageUrl = null;
    _isLoading = true;
    Future.delayed(Duration.zero, () async {
      NftLoadInfo nftLoadInfo = await HttpRequest.loadUserNfts(
          userUid: _userInfo.value?.uid ?? "", pageUrl: pageUrl);
      setState(() {
        _nextPageUrl = nftLoadInfo.nextPageUrl;
        _nfts.insertAll(_nfts.length, nftLoadInfo.nfts);
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget avatar = GestureDetector(
      onTap: () => Get.toNamed(Routes.updateAvatar),
      child: Container(
          width: 36,
          padding: const EdgeInsets.only(top: 3, bottom: 7),
          child: Center(child: CircleAvatar(
            radius: 36,
            backgroundImage: NetworkImage(_userInfo.value?.avatar ?? ""),
            backgroundColor: Colors.transparent,
          ),)
      ),
    );

    Widget userTitle = Container(
        padding: const EdgeInsets.only(top: 9, bottom: 23),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(Routes.updateName),
              child: Obx(
                  () => Text(_userInfo.value?.nickname ?? "")
                      .fontSize(20)
                      .textColor(Colors.white)
              ),
            ),
            SizedBox(
              height: 30,
              child: Stack(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            '区块链地址: ',
                            style: TextStyle(fontSize: 14, color: Color(0xccffffff))
                        ),
                        SizedBox(
                          width: 200,
                          child: EllipsizedText(
                            _userInfo.value?.walletAddress ?? "",
                            style: const TextStyle(fontSize: 14, color: Color(0xccffffff)),
                            ellipsis: Ellipsis.middle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                          text: _userInfo.value?.walletAddress ?? ""));
                      MessageToast.showMessage("复制成功");
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );

    Widget divideLine =
        Image.asset("images/divideline.png", fit: BoxFit.contain);

    Widget nftTitle = Container(
      padding: const EdgeInsets.only(left: 22, right: 22, top: 17, bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 2),
            child: Image.asset(
              "images/cube.png",
              width: 23,
              height: 23,
            ),
          ),
          const Expanded(
              child: Text(
            "我的NFT",
            style: TextStyle(fontSize: 15, color: Color(0xffffffff)),
          )),
          Text(
            "共${_nfts.length}个",
            style: const TextStyle(fontSize: 15, color: Color(0xccffffff)),
          )
        ],
      ),
    );

    Widget nftGridView = Container(
      padding: const EdgeInsets.only(left: 22, right: 22, bottom: 22),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.757),
        itemCount: _nfts.length,
        itemBuilder: (context, index) {
          if (index == _nfts.length - 1) {
            if (_nextPageUrl != null) {
              _addNfts();
            }
          }
          return _createNftItem(_nfts[index]);
        },
      ),
    );

    Widget qrCode = Container(
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
              height: 465,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 18, bottom: 7),
                    child: CircleAvatar(
                      radius: 36,
                      backgroundImage: NetworkImage(_userInfo.value?.avatar ?? "")),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Text(_userInfo.value?.nickname ?? "",
                        style: const TextStyle(
                            fontSize: 18, color: Color(0xffffffff))),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    width: 243,
                    height: 243,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Image.memory(
                        base64Decode(_qrcode),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 25),
                    child: Image.asset(
                      'images/blockie.png',
                      width: 151,
                      height: 25,
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
            ),
          )),
    );

    Widget qrCodePanel = Stack(
      alignment: Alignment.center,
      children: [
        qrCode,
        Positioned(
            right: 19,
            top: 50,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showQrCode = false;
                  });
                }, // Image tapped
                child: Image.asset(
                  "images/close_panel.png",
                  width: 26,
                  height: 26,
                )))
      ],
    );

    List<Widget> headers = [
      avatar,
      userTitle,
      divideLine,
      nftTitle
    ];
    return ScreenBoundary(
      padding: 0,
      body: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: BasicAppBar(
          actionItems: [
            AppBarButtonItem(
              assetName: 'images/app_bar/qrcode.png',
              onTap: () {
                setState(() {
                  _showQrCode = true;
                });
              },
            ),
            AppBarButtonItem(
              assetName: 'images/app_bar/settings.png',
              onTap: () => Get.toNamed(Routes.settings),
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
           Visibility(
              visible: _nfts.isNotEmpty,
              replacement: Column(
                children: [
                  ListView(shrinkWrap: true, children: headers),
                  _isLoading ? const LoadingIndicator() : const Expanded(child: EmptyDatasetView())
                ],
              ),
              child: ListView(
                children: headers + (_isLoading ? [const LoadingIndicator()] : [nftGridView]),
              ),
            ),
            if (_showQrCode) qrCodePanel,
          ],
        ),
      ),
    );
  }
}