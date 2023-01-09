// Package imports:
import 'package:blockie_app/app/modules/orders/models/order.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_orders.g.dart';

@JsonSerializable(explicitToJson: true)
class PaginatedOrders {
  @JsonKey(name: 'next_page_url')
  String? nextPageUrl;
  @JsonKey(name: 'data')
  List<Order> orders;

  PaginatedOrders({
    required this.nextPageUrl,
    required this.orders,
  });

  factory PaginatedOrders.fromJson(Map<String, dynamic> json) =>
      _$PaginatedOrdersFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedOrdersToJson(this);
}