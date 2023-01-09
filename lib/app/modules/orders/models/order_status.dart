// Package imports:
import 'package:json_annotation/json_annotation.dart';

enum OrderStatus {
  @JsonValue(0)
  pending,
  @JsonValue(1)
  paid,
  @JsonValue(2)
  failed,
  @JsonValue(3)
  refunding,
  @JsonValue(4)
  refunded,
  @JsonValue(5)
  cancelled,
  @JsonValue(6)
  closed;
}

extension OrderStatusExtension on OrderStatus {
  String get displayValue {
    switch (this) {
      case OrderStatus.pending:
        return '待支付';
      case OrderStatus.paid:
        return '已支付';
      case OrderStatus.failed:
        return '支付失败';
      case OrderStatus.refunding:
        return '退款中';
      case OrderStatus.refunded:
        return '已退款';
      case OrderStatus.cancelled:
        return '已取消';
      case OrderStatus.closed:
        return '已关闭';
    }
  }
}
