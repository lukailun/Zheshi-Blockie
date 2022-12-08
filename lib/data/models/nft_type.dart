// Package imports:
import 'package:json_annotation/json_annotation.dart';

enum NftType {
  @JsonValue(1)
  image,
  @JsonValue(2)
  blockie,
  @JsonValue(3)
  card,
  @JsonValue(4)
  model;
}

extension NftTypeExtension on NftType {
  String get srcValue {
    switch (this) {
      case NftType.image:
        return '';
      case NftType.blockie:
        return 'cube';
      case NftType.card:
        return 'card';
      case NftType.model:
        return 'model';
    }
  }
}
