// Package imports:
import 'package:json_annotation/json_annotation.dart';

enum NftPasterType {
  @JsonValue(0)
  undefined,
  @JsonValue(1)
  blockie,
  @JsonValue(2)
  blockie2d,
  @JsonValue(3)
  blockie3d;
}

extension NftPasterTypeExtension on NftPasterType {
  String get assetName {
    switch (this) {
      case NftPasterType.undefined:
        return '';
      case NftPasterType.blockie:
        return 'assets/images/project_details/paster_blockie.png';
      case NftPasterType.blockie2d:
        return 'assets/images/project_details/paster_2d.png';
      case NftPasterType.blockie3d:
        return 'assets/images/project_details/paster_3d.png';
    }
  }
}
