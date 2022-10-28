// Package imports:
import 'package:blockie_app/app/modules/ticket_checking/models/nft.dart';
import 'package:blockie_app/app/modules/ticket_checking/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_checking_details.g.dart';

@JsonSerializable(explicitToJson: true)
class TicketCheckingDetails {
  @JsonKey(name: 'user')
  User user;
  @JsonKey(name: 'nfts')
  List<Nft> nfts;

  TicketCheckingDetails({
    required this.user,
    required this.nfts,
  });

  factory TicketCheckingDetails.fromJson(Map<String, dynamic> json) =>
      _$TicketCheckingDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TicketCheckingDetailsToJson(this);
}
