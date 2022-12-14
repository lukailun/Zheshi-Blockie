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
  needToClaimSouvenir,
}

extension MintStatusExtension on MintStatus {
  String title({
    String? startedTime,
    bool isBlockieNft = false,
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
        return isBlockieNft ? '生成视频 NFT' : '开启铸造';
      case MintStatus.runOut:
        return '我的页面';
      case MintStatus.generating:
        return '视频生成中';
      case MintStatus.generationFailed:
        return '没有识别到您的视频，请联系客服';
      case MintStatus.minting:
        return isBlockieNft ? '生成视频 NFT' : '正在铸造';
      case MintStatus.expired:
        return '活动已结束';
      case MintStatus.needToClaimSouvenir:
        return '我的二维码';
    }
  }

  String message({
    required String category,
    bool isBlockieNft = false,
  }) {
    switch (this) {
      case MintStatus.notLogin:
      case MintStatus.notStartedAndUnqualified:
      case MintStatus.stepNotCompleted:
      case MintStatus.notStarted:
        return '请完成所有$category开启铸造';
      case MintStatus.unqualified:
        return '暂无铸造资格';
      case MintStatus.generating:
        return '已完成所有$category';
      case MintStatus.generationFailed:
        return '很遗憾，未能生成视频';
      case MintStatus.mintable:
      case MintStatus.minting:
        return isBlockieNft ? '视频已生成完毕，点击按钮铸造 3D NFT' : '点击按钮铸造';
      case MintStatus.runOut:
        return isBlockieNft ? '视频已铸造，请至“我的”页面查看' : '数字藏品已铸造，请至“我的”页面查看';
      case MintStatus.needToClaimSouvenir:
        return '线下扫码领取礼品';
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
      case MintStatus.needToClaimSouvenir:
        return '您当前持有 $userMintedAmount 个，还有 ${mintChances ?? 0} 次铸造机会';
      case MintStatus.expired:
        return '您当前持有 $userMintedAmount 个';
    }
  }

  int get colorValue {
    switch (this) {
      case MintStatus.notLogin:
      case MintStatus.runOut:
      case MintStatus.mintable:
      case MintStatus.needToClaimSouvenir:
        return 0xFFFFFFFF;
      case MintStatus.minting:
        return 0xFF07DFAB;
      case MintStatus.notStartedAndUnqualified:
      case MintStatus.notStarted:
      case MintStatus.unqualified:
      case MintStatus.expired:
      case MintStatus.generating:
      case MintStatus.generationFailed:
      case MintStatus.stepNotCompleted:
        return 0xFF909090;
    }
  }

  List<int>? get colorValues {
    switch (this) {
      case MintStatus.generating:
        return [0xFF07DFAB, 0xFF07DFAB, 0xFFFFFFFF, 0xFFFFFFFF];
      case MintStatus.notLogin:
      case MintStatus.runOut:
      case MintStatus.mintable:
      case MintStatus.needToClaimSouvenir:
      case MintStatus.minting:
      case MintStatus.notStartedAndUnqualified:
      case MintStatus.notStarted:
      case MintStatus.unqualified:
      case MintStatus.expired:
      case MintStatus.generationFailed:
      case MintStatus.stepNotCompleted:
        return null;
    }
  }

  bool get enabled {
    switch (this) {
      case MintStatus.notLogin:
      case MintStatus.mintable:
      case MintStatus.runOut:
      case MintStatus.needToClaimSouvenir:
        return true;
      case MintStatus.notStartedAndUnqualified:
      case MintStatus.notStarted:
      case MintStatus.unqualified:
      case MintStatus.expired:
      case MintStatus.minting:
      case MintStatus.generating:
      case MintStatus.generationFailed:
      case MintStatus.stepNotCompleted:
        return false;
    }
  }

  bool get showsHint => this != MintStatus.notLogin;

  bool get showsPreviewVideo {
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
      case MintStatus.needToClaimSouvenir:
        return false;
    }
  }
}
