// Package imports:
import 'package:blockie_app/app/modules/orders/models/order.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_orders.g.dart';

@JsonSerializable(explicitToJson: true)
class PaginatedOrders {
  @JsonKey(name: 'current_page')
  int currentPage;
  @JsonKey(name: 'next_page_url')
  String? nextPageUrl;
  @JsonKey(name: 'data')
  List<Order> orders;

  bool get isLastPage => (nextPageUrl ?? '').isEmpty;

  PaginatedOrders({
    required this.currentPage,
    required this.nextPageUrl,
    required this.orders,
  });

  factory PaginatedOrders.fromJson(Map<String, dynamic> json) =>
      _$PaginatedOrdersFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedOrdersToJson(this);
}
