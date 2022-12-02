// Package imports:
import 'package:json_annotation/json_annotation.dart';

enum Gender {
  @JsonValue(0)
  undefined,
  @JsonValue(1)
  male,
  @JsonValue(2)
  female,
}

extension GenderExtension on Gender {
  int get value {
    switch (this) {
      case Gender.undefined:
        return 0;
      case Gender.male:
        return 1;
      case Gender.female:
        return 2;
    }
  }

  String? get displayName {
    switch (this) {
      case Gender.undefined:
        return null;
      case Gender.male:
        return '男';
      case Gender.female:
        return '女';
    }
  }
}
