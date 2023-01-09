// Package imports:
import 'package:blockie_app/app/modules/orders/models/order_status.dart';
import 'package:blockie_app/utils/date_time_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  @JsonKey(name: 'uid')
  String id;
  @JsonKey(name: 'total_fee')
  String totalPrice;
  @JsonKey(name: 'status')
  OrderStatus status;
  @JsonKey(name: 'extra_json')
  List<OrderGoods> goods;
  @JsonKey(name: 'group')
  OrderSubactivity subactivity;

  int get totalAmount => goods.isNotEmpty
      ? goods.fold(
          0, (previousValue, element) => previousValue + element.amount)
      : 0;

  Order({
    required this.id,
    required this.totalPrice,
    required this.status,
    required this.goods,
    required this.subactivity,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderGoods {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'number')
  int amount;

  OrderGoods({
    required this.name,
    required this.amount,
  });

  factory OrderGoods.fromJson(Map<String, dynamic> json) =>
      _$OrderGoodsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderGoodsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderSubactivity {
  @JsonKey(name: 'uid')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'address')
  String location;
  @JsonKey(name: 'is_online')
  bool isOnline;
  @JsonKey(name: 'started_at')
  int startedTimestamp;

  String? get startedTime {
    if (startedTimestamp <= 0) {
      return null;
    }
    return DateTimeUtils.dateTimeStringFromTimestamp(
      timestamp: startedTimestamp,
      dateFormatType: DateFormatType.MM_DD_EEE_HH_MM,
    );
  }

  OrderSubactivity({
    required this.id,
    required this.name,
    required this.location,
    required this.isOnline,
    required this.startedTimestamp,
  });

  factory OrderSubactivity.fromJson(Map<String, dynamic> json) =>
      _$OrderSubactivityFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSubactivityToJson(this);
}
