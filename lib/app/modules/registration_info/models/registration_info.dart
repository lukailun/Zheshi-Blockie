import 'package:blockie_app/app/modules/face_verification/models/face_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registration_info.g.dart';

@JsonSerializable(explicitToJson: true)
class RegistrationInfo {
  @JsonKey(name: 'number')
  String entryNumber;
  @JsonKey(name: 'is_signed')
  bool hasSigned;
  @JsonKey(name: 'faces')
  List<FaceInfo> faceInfos;

  RegistrationInfo({
    required this.entryNumber,
    required this.faceInfos,
    required this.hasSigned,
  });

  factory RegistrationInfo.fromJson(Map<String, dynamic> json) =>
      _$RegistrationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationInfoToJson(this);
}
