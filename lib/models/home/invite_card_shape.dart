import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_card_shape.freezed.dart';

@freezed
class InviteCardShape with _$InviteCardShape {
  const InviteCardShape._();

  const factory InviteCardShape({
    @Default(70) double shoulderY,
    @Default(158) double archWidth,
    @Default(42) double archHeight,
    @Default(10) double cornerRadius,
  }) = _InviteCardShape;

  InviteCardShape inset(double amount) {
    return copyWith(
      archWidth: archWidth - amount * 2,
      archHeight: archHeight - amount,
      cornerRadius: cornerRadius - amount,
    );
  }
}
