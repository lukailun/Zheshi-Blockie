// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/data/models/basic_details_card_item.dart';
import 'package:blockie_app/data/models/issuer.dart';
import 'package:blockie_app/data/models/nft_paster_type.dart';
import 'package:blockie_app/data/models/nft_type.dart';
import 'package:blockie_app/data/models/user_info.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/utils/date_time_utils.dart';

part 'nft_details.g.dart';

@JsonSerializable(explicitToJson: true)
class NftDetails {
  @JsonKey(name: 'token_id')
  final String tokenId;
  @JsonKey(name: 'minted_at')
  final int mintedTimestamp;
  @JsonKey(name: 'cover', defaultValue: '')
  final String coverPath;
  @JsonKey(name: 'image', defaultValue: {})
  final dynamic texturesValue;
  @JsonKey(name: 'model_image', defaultValue: [])
  final List<Map<String, String>> modelImages;
  @JsonKey(name: 'model', defaultValue: '')
  final String modelPath;
  @JsonKey(name: 'video', defaultValue: '')
  final String videoPath;
  @JsonKey(name: 'type')
  final NftType nftType;
  @JsonKey(name: 'uid')
  final String id;
  @JsonKey(name: 'activity')
  final NftDetailsSubactivity subactivity;
  @JsonKey(name: 'right')
  final NftDetailsBenefit benefit;
  @JsonKey(name: 'issuer')
  final Issuer issuer;
  @JsonKey(name: 'user')
  final UserInfo userInfo;
  @JsonKey(name: 'union_token_id')
  final String unionTokenId;
  @JsonKey(name: 'blockie_type')
  final NftPasterType pasterType;
  @JsonKey(name: 'souvenirs', defaultValue: [])
  final List<NftDetailsSouvenir> souvenirs;
  @JsonKey(name: 'attributes', defaultValue: [])
  final List<NftDetailsAttribute> attributes;

  NftDetails({
    required this.tokenId,
    required this.mintedTimestamp,
    required this.coverPath,
    required this.texturesValue,
    required this.modelImages,
    required this.modelPath,
    required this.videoPath,
    required this.nftType,
    required this.id,
    required this.subactivity,
    required this.benefit,
    required this.issuer,
    required this.userInfo,
    required this.unionTokenId,
    required this.pasterType,
    required this.souvenirs,
    required this.attributes,
  });

  String? get mintedTime {
    if (mintedTimestamp <= 0) {
      return null;
    }
    return DateTimeUtils.dateTimeStringFromTimestamp(
      timestamp: mintedTimestamp,
      dateFormatType: DateFormatType.YYYY_MM_DD_HH_MM,
    );
  }

  String? get coverUrl => coverPath.isNotEmpty ? coverPath.hostAdded : null;

  Map<String, String> get textures => Map.from(texturesValue);

  String get src {
    const baseUrl = 'https://sandbox.blockie.zheshi.tech';
    switch (nftType) {
      case NftType.image:
        return (textures['normal'] ?? '').hostAdded;
      case NftType.blockie:
        return '$baseUrl?type=${nftType.srcValue}&video=$videoPath&model=$modelPath&images=${jsonEncode(modelImages)}';
      case NftType.card:
        return '$baseUrl?type=${nftType.srcValue}&image1=${textures['part0'] ?? ''}&image2=${textures['part1'] ?? ''}';
      case NftType.model:
        return '$baseUrl?type=${nftType.srcValue}&model=$modelPath&images=${jsonEncode(modelImages)}';
    }
  }

  factory NftDetails.fromJson(Map<String, dynamic> json) =>
      _$NftDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$NftDetailsToJson(this);
}

extension NftDetailsExtension on NftDetails {
  List<BasicDetailsCardItem> get items => [
        BasicDetailsCardItem(
            title: '序列号',
            content: '${tokenId.replaceFirst('#', '')}/${benefit.totalAmount}'),
        BasicDetailsCardItem(
          title: '持有者',
          content: userInfo.username,
          iconUrl: userInfo.avatarUrl,
        ),
        BasicDetailsCardItem(
          title: '合约地址',
          content: benefit.walletAddress,
          ellipsized: true,
          copyable: true,
        ),
        BasicDetailsCardItem(title: 'Token ID', content: unionTokenId),
        const BasicDetailsCardItem(title: '链', content: 'Conflux'),
      ];
}

@JsonSerializable(explicitToJson: true)
class NftDetailsSubactivity {
  @JsonKey(name: 'share_title', defaultValue: '')
  final String shareTitle;
  @JsonKey(name: 'share_msg', defaultValue: '')
  final String shareDescription;
  @JsonKey(name: 'uid')
  final String id;

  NftDetailsSubactivity({
    required this.shareTitle,
    required this.shareDescription,
    required this.id,
  });

  factory NftDetailsSubactivity.fromJson(Map<String, dynamic> json) =>
      _$NftDetailsSubactivityFromJson(json);

  Map<String, dynamic> toJson() => _$NftDetailsSubactivityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NftDetailsBenefit {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'contract')
  final String walletAddress;
  @JsonKey(name: 'total_amount')
  final int totalAmount;
  @JsonKey(name: 'uid')
  final String id;

  NftDetailsBenefit({
    required this.name,
    required this.description,
    required this.walletAddress,
    required this.totalAmount,
    required this.id,
  });

  factory NftDetailsBenefit.fromJson(Map<String, dynamic> json) =>
      _$NftDetailsBenefitFromJson(json);

  Map<String, dynamic> toJson() => _$NftDetailsBenefitToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NftDetailsSouvenir {
  @JsonKey(name: 'uid')
  String id;
  @JsonKey(name: 'msg')
  String description;

  NftDetailsSouvenir({
    required this.id,
    required this.description,
  });

  factory NftDetailsSouvenir.fromJson(Map<String, dynamic> json) =>
      _$NftDetailsSouvenirFromJson(json);

  Map<String, dynamic> toJson() => _$NftDetailsSouvenirToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NftDetailsAttribute {
  @JsonKey(name: 'key')
  String key;
  @JsonKey(name: 'value')
  String value;

  NftDetailsAttribute({
    required this.key,
    required this.value,
  });

  factory NftDetailsAttribute.fromJson(Map<String, dynamic> json) =>
      _$NftDetailsAttributeFromJson(json);

  Map<String, dynamic> toJson() => _$NftDetailsAttributeToJson(this);
}
