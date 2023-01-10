// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['uid'] as String,
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      goods: (json['extra_json'] as List<dynamic>)
          .map((e) => OrderGoods.fromJson(e as Map<String, dynamic>))
          .toList(),
      subactivity:
          OrderSubactivity.fromJson(json['group'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'uid': instance.id,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'extra_json': instance.goods.map((e) => e.toJson()).toList(),
      'group': instance.subactivity.toJson(),
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 0,
  OrderStatus.paid: 1,
  OrderStatus.failed: 2,
  OrderStatus.refunding: 3,
  OrderStatus.refunded: 4,
  OrderStatus.cancelled: 5,
  OrderStatus.closed: 6,
};

OrderGoods _$OrderGoodsFromJson(Map<String, dynamic> json) => OrderGoods(
      name: json['name'] as String,
      amount: json['number'] as int,
      price: (json['discounted_price'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderGoodsToJson(OrderGoods instance) =>
    <String, dynamic>{
      'name': instance.name,
      'number': instance.amount,
      'discounted_price': instance.price,
    };

OrderSubactivity _$OrderSubactivityFromJson(Map<String, dynamic> json) =>
    OrderSubactivity(
      id: json['uid'] as String,
      name: json['name'] as String,
      location: json['address'] as String,
      isOnline: json['is_online'] as bool,
      startedTimestamp: json['started_at'] as int,
    );

Map<String, dynamic> _$OrderSubactivityToJson(OrderSubactivity instance) =>
    <String, dynamic>{
      'uid': instance.id,
      'name': instance.name,
      'address': instance.location,
      'is_online': instance.isOnline,
      'started_at': instance.startedTimestamp,
    };
