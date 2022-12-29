// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: json['activity_uid'] as String,
      goods: (json['merches'] as List<dynamic>)
          .map((e) => CartGoods.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'activity_uid': instance.id,
      'merches': instance.goods.map((e) => e.toJson()).toList(),
    };

CartGoods _$CartGoodsFromJson(Map<String, dynamic> json) => CartGoods(
      name: json['name'] as String,
      inventory: json['inventory'] as int,
      price: (json['discounted_price'] as num).toDouble(),
      amount: json['number'] as int,
    );

Map<String, dynamic> _$CartGoodsToJson(CartGoods instance) => <String, dynamic>{
      'name': instance.name,
      'inventory': instance.inventory,
      'discounted_price': instance.price,
      'number': instance.amount,
    };
