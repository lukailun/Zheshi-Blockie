enum MintStatus {
  notLogin,
  notStartedAndUnqualified,
  notStarted,
  unqualified,
  stepNotCompleted,
  generating,
  generationFailed,
  mintable,
  runOut,
  expired,
  minting,
}

extension MintStatusExtension on MintStatus {
  String title({
    String? startedTime,
    bool isVideoNft = false,
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
      case MintStatus.stepNotCompleted:
      case MintStatus.mintable:
        return isVideoNft ? '生成个人视频 NFT' : '开启铸造';
      case MintStatus.runOut:
        return '已铸造';
      case MintStatus.generating:
        return '正在识别中';
      case MintStatus.generationFailed:
        return '没有识别到您的视频，请联系客服';
      case MintStatus.minting:
        return isVideoNft ? '生成个人视频 NFT' : '正在铸造';
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
      case MintStatus.stepNotCompleted:
        return '您当前没有铸造资格，如何获取资格？';
      case MintStatus.notStarted:
        return '您当前有 ${mintChances ?? 0} 次铸造机会';
      case MintStatus.generating:
      case MintStatus.generationFailed:
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
          case MintStatus.generating:
          case MintStatus.generationFailed:
          case MintStatus.stepNotCompleted:
            return 0xFF909090;
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
          case MintStatus.generating:
          case MintStatus.generationFailed:
          case MintStatus.stepNotCompleted:
            return false;
        }
      }();

  bool get showsHint => this != MintStatus.notLogin;

  bool get showsPreviewVideo => () {
        switch (this) {
          case MintStatus.notLogin:
          case MintStatus.notStartedAndUnqualified:
          case MintStatus.notStarted:
          case MintStatus.expired:
          case MintStatus.generating:
          case MintStatus.generationFailed:
          case MintStatus.stepNotCompleted:
          case MintStatus.unqualified:
            return true;
          case MintStatus.minting:
          case MintStatus.mintable:
          case MintStatus.runOut:
            return false;
        }
      }();
}
