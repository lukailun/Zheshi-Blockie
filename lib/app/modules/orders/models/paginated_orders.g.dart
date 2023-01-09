// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedOrders _$PaginatedOrdersFromJson(Map<String, dynamic> json) =>
    PaginatedOrders(
      nextPageUrl: json['next_page_url'] as String?,
      orders: (json['data'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaginatedOrdersToJson(PaginatedOrders instance) =>
    <String, dynamic>{
      'next_page_url': instance.nextPageUrl,
      'data': instance.orders.map((e) => e.toJson()).toList(),
    };
