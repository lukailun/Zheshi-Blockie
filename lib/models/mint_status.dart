enum MintStatus {
  notLogin,
  notStartedAndUnqualified,
  notStarted,
  unqualified,
  mintable,
  runOut,
  expired,
  minting,
}

extension MintStatusExtension on MintStatus {
  String title({
    String? startedTime,
    bool isVideo = false,
  }) {
    switch (this) {
      case MintStatus.notLogin:
        return '注册/登录';
      case MintStatus.notStartedAndUnqualified:
      case MintStatus.notStarted:
        if (startedTime == null) {
          return '即将开启铸造';
        }
        return '$startedTime 开启铸造';
      case MintStatus.unqualified:
      case MintStatus.mintable:
      case MintStatus.runOut:
        return isVideo ? '生成个人视频 NFT' : '立即铸造';
      case MintStatus.minting:
        return isVideo ? '生成个人视频 NFT' : '正在铸造';
      case MintStatus.expired:
        return '活动已结束';
    }
  }

  String hint({
    required int userMintedAmount,
    required int? mintChances,
  }) {
    switch (this) {
      case MintStatus.notLogin:
        return '请登录以获取你的铸造资格';
      case MintStatus.notStartedAndUnqualified:
      case MintStatus.unqualified:
        return '您当前没有铸造资格，如何获取资格？';
      case MintStatus.notStarted:
        return '您当前有 ${mintChances ?? 0} 次铸造机会';
      case MintStatus.mintable:
      case MintStatus.runOut:
      case MintStatus.minting:
        return '您当前持有 $userMintedAmount 个，还有 ${mintChances ?? 0} 次铸造机会';
      case MintStatus.expired:
        return '您当前持有 $userMintedAmount 个';
    }
  }

  int get colorValue => () {
        switch (this) {
          case MintStatus.notLogin:
            return 0xFFFFFFFF;
          case MintStatus.mintable:
            return 0xFFFFFFFF;
          case MintStatus.minting:
            return 0xFF07DFAB;
          case MintStatus.notStartedAndUnqualified:
          case MintStatus.notStarted:
          case MintStatus.unqualified:
          case MintStatus.runOut:
          case MintStatus.expired:
            return 0x80FFFFFF;
        }
      }();

  bool get enabled => () {
        switch (this) {
          case MintStatus.notLogin:
          case MintStatus.mintable:
            return true;
          case MintStatus.notStartedAndUnqualified:
          case MintStatus.notStarted:
          case MintStatus.unqualified:
          case MintStatus.runOut:
          case MintStatus.expired:
          case MintStatus.minting:
            return false;
        }
      }();

  bool get showsHint => this != MintStatus.notLogin;

  bool get showsPreview => () {
        switch (this) {
          case MintStatus.notLogin:
          case MintStatus.notStartedAndUnqualified:
          case MintStatus.notStarted:
          case MintStatus.expired:
          case MintStatus.minting:
            return false;
          case MintStatus.unqualified:
          case MintStatus.mintable:
          case MintStatus.runOut:
            return true;
        }
      }();

  bool get previewEnabled => this == MintStatus.mintable;
}
