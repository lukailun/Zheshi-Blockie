import 'dart:convert';
import 'dart:ui';

import 'package:blockie_app/common/global.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blockie_app/common/user_info.dart';
import 'package:blockie_app/common/nft_info.dart';
import 'package:blockie_app/common/nft_load_info.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blockie_app/common/routes.dart';
import 'package:get/get.dart';

class UserPage extends StatefulWidget{
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>{
  bool _showQrCode = false;
  final _nfts = <NftInfo>[];
  UserInfo? _userInfo;
  String? _nextPageUrl;
  String _qrcode = '';

  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      setState(() {
        // _userInfo = ModalRoute.of(context)!.settings.arguments as UserInfo;
        _userInfo = UserInfo.fromJson(jsonDecode(Get.parameters["user"]!));
      });
      _addNfts();
      _loadQRCode();
    });
    super.initState();
  }

  _loadQRCode() async {
    String qrcode = DataStorage.getToken() == null ? '' : await HttpRequest.getUserQRCode(DataStorage.getToken()!);
    setState(() {
      _qrcode = qrcode;
    });
  }
  
  Widget _createNftItem(NftInfo nftInfo) {
    return GestureDetector(
      onTap: (){
        // Navigator.of(context).pushNamed("/nft", arguments: nftInfo);
        // print(jsonEncode(nftInfo.json));
        // print(jsonDecode(jsonEncode(nftInfo.json)));
        // Get.toNamed(Routes.nft, arguments: nftInfo);
        Get.toNamed("${Routes.nft}?uid=${nftInfo.uid}");
      },
      child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/ProfileCardOutline.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(children: [
            Container(
                padding: const EdgeInsets.all(8),
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
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 5, bottom: 6),
                            child: Text(
                              "${nftInfo.projectName} ${nftInfo.tokenId}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xffffffff),
                              ),
                            ),
                          )
                        ],
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
                )
            ),
          ],)
      ),
    );
  }

  void _addNfts() {
    String? pageUrl = _nextPageUrl;
    _nextPageUrl = null;
    Future.delayed(Duration.zero, () async {
      NftLoadInfo nftLoadInfo = await HttpRequest.loadUserNfts(userUid: _userInfo!.uid, pageUrl: pageUrl);
      setState(() {
        _nextPageUrl = nftLoadInfo.nextPageUrl;
        _nfts.insertAll(_nfts.length, nftLoadInfo.nfts);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget topButtons = Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: Global.titleButtonTop, bottom: 20),
      child: Row(
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
            ),
            const Spacer(),
            Container(
              // padding: const EdgeInsets.only(right: 30),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showQrCode = true;
                    });
                  }, // Image tapped
                  child: Image.asset(
                    "images/qrcode.png",
                    width: 30,
                    height: 30,
                  )
              ),
            )
          ]
      ),
    );

    Widget avatar = Container(
        padding: const EdgeInsets.only(top: 3, bottom: 7),
        child: CircleAvatar(
          radius: 36,
          backgroundImage: NetworkImage(
              _userInfo == null ? "" : _userInfo!.avatar,
          ),
          backgroundColor: Colors.transparent,
        )
    );

    Widget userTitle = Container(
        padding: const EdgeInsets.only(top: 9, bottom: 23),
        child: Column(
          children: [
            Text(
                _userInfo == null ? "" : _userInfo!.nickname,
                style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xffffffff)
                )
            ),
            SizedBox(
              // width: MediaQuery.of(context).size.width * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      child: Text( '区块链地址: ${_userInfo == null ? "" : _userInfo!.walletAddress}',
                          softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xccffffff)
                          )
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: _userInfo == null ? "" : _userInfo!.walletAddress));
                          MessageToast.showMessage("复制成功");
                        }, // Image tapped
                        child: Image.asset(
                          "images/copy.png",
                          width: 25,
                          height: 25,
                        )
                    )
                  ],
                )
            )
          ],
        )
    );

    Widget divideLine = Image.asset(
        "images/divideline.png",
        fit: BoxFit.contain
    );

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
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xffffffff)
                ),
              )
          ),
          Text(
            "共${_nfts.length}个",
            style: const TextStyle(
                fontSize: 15,
                color: Color(0xccffffff)
            ),
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
            childAspectRatio: 0.757
        ),
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
              height: 465,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 18, bottom: 7),
                    child: CircleAvatar(
                      radius: 36,
                      backgroundImage: NetworkImage(
                          _userInfo == null ? '' : _userInfo!.avatar
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Text(
                        _userInfo == null ? "" : _userInfo!.nickname,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xffffffff)
                        )
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.all(
                          Radius.circular(8)
                      ),
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
          )
      ),
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
                )
            )
        )
      ],
    );

    return Material(
          color: const Color(0xff3C63F8),
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Stack(
              alignment:Alignment.center ,
              children: <Widget>[
                ListView(
                  children: [
                    topButtons,
                    avatar,
                    userTitle,
                    divideLine,
                    nftTitle,
                    nftGridView
                  ],
                ),
                _showQrCode ? qrCodePanel : const SizedBox(height: 0)
              ],
            ),
          )
      );
  }

}
