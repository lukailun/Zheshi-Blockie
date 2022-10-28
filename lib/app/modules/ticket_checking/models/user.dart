// Package imports:
import 'package:blockie_app/models/wallet.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: 'phone')
  String phoneNumber;
  @JsonKey(name: 'in_whitelist')
  bool isQualified;
  @JsonKey(name: 'wallets')
  List<Wallet> wallet;

  User({
    required this.phoneNumber,
    required this.isQualified,
    required this.wallet,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
