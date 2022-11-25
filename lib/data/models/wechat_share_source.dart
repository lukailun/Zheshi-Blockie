// Dart imports:
import 'dart:html' as html;

// Project imports:
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/apis/blockie_api/blockie_url_builder.dart';

enum WechatShareSource {
  activity,
  project,
  nft,
  defaults;
}

extension WechatShareSourceExtension on WechatShareSource {
  String getTitle({String? extraInfo}) {
    switch (this) {
      case WechatShareSource.activity:
        return '邀你参加！${extraInfo ?? ''}';
      case WechatShareSource.project:
        if (extraInfo == null) {
          return 'Blockie';
        }
        return 'Blockie | $extraInfo';
      case WechatShareSource.nft:
        return '来看这枚 NFT！${extraInfo ?? ''}';
      case WechatShareSource.defaults:
        return 'Blockie | 国内首个 Web3 运动数字身份平台';
    }
  }

  String getDescription({String? extraInfo}) {
    const defaultDescription = '参与各类活动、收集凭证 NFT，记录运动表现，构建属于自己的运动数字身份';
    switch (this) {
      case WechatShareSource.activity:
        return extraInfo ?? defaultDescription;
      case WechatShareSource.project:
        return extraInfo ?? defaultDescription;
      case WechatShareSource.nft:
        return extraInfo ?? defaultDescription;
      case WechatShareSource.defaults:
        return defaultDescription;
    }
  }

  String getLink({String? extraInfo}) {
    final defaultLink = html.window.location.href.split('#').first;
    switch (this) {
      case WechatShareSource.activity:
        return '$defaultLink#${Routes.activity}${extraInfo != null ? '?$extraInfo' : ''}';
      case WechatShareSource.project:
        return '$defaultLink#${Routes.projectDetails}${extraInfo != null ? '?$extraInfo' : ''}';
      case WechatShareSource.nft:
        return '$defaultLink#${Routes.nftDetails}${extraInfo != null ? '?$extraInfo' : ''}';
      case WechatShareSource.defaults:
        return defaultLink;
    }
  }

  String getImageUrl({String? extraInfo}) {
    final defaultImageUrl = BlockieUrlBuilder.buildAppIconUrl();
    final imageUrl = extraInfo ?? '';
    switch (this) {
      case WechatShareSource.activity:
        return imageUrl.isNotEmpty ? imageUrl : defaultImageUrl;
      case WechatShareSource.project:
        return imageUrl.isNotEmpty ? imageUrl : defaultImageUrl;
      case WechatShareSource.nft:
        return imageUrl.isNotEmpty ? imageUrl : defaultImageUrl;
      case WechatShareSource.defaults:
        return defaultImageUrl;
    }
  }
}
