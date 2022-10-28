// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'wallet.g.dart';

@JsonSerializable(explicitToJson: true)
class Wallet {
  @JsonKey(name: 'uid')
  String id;
  @JsonKey(name: 'address')
  String address;

  Wallet({
    required this.id,
    required this.address,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
