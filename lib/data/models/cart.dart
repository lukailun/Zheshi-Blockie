// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart {
  @JsonKey(name: 'activity_uid')
  String id;
  @JsonKey(name: 'merches')
  List<CartGoods> goods;

  Cart({
    required this.id,
    required this.goods,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartGoods {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'inventory')
  int inventory;
  @JsonKey(name: 'discounted_price')
  String price;
  @JsonKey(name: 'number')
  int amount;

  CartGoods({
    required this.name,
    required this.inventory,
    required this.price,
    required this.amount,
  });

  factory CartGoods.fromJson(Map<String, dynamic> json) =>
      _$CartGoodsFromJson(json);

  Map<String, dynamic> toJson() => _$CartGoodsToJson(this);
}
