enum MintStatus {
  mintable(title: '开始铸造', colorValue: 0xFFF9D038),
  notLogin(title: '关联区块链账户', colorValue: 0xFFFFFFFF),
  unopened(title: '即将开放铸造', colorValue: 0xFFC8C8C8),
  unqualified(title: '开始铸造', colorValue: 0xFFC8C8C8),
  minting(title: '正在铸造', colorValue: 0xFF07DFAB);

  const MintStatus({
    required this.title,
    required this.colorValue,
  });

  final String title;
  final int colorValue;

  // if (_mintState == MintState.notLogIn) {
  // description = "请登陆后查看铸造资格";
  // } else if (_mintState == MintState.unqualified) {
  // description = "未获得铸造资格";
  // } else if (userMintedAmount == 0) {
  // description = "剩余$mintChances次铸造机会";
  // } else {
  // description = "已铸造$userMintedAmount次，剩余$mintChances次铸造机会";
  // }
  // Widget text = Text(
  //   description,
  //   style: const TextStyle(color: Color(0xffffffff), fontSize: 17),
  // );
  // if (_mintState == MintState.notLogIn) {
  // return text;
  // }
}
