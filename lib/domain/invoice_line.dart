import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_line.freezed.dart';

@freezed
abstract class InvoiceLine with _$InvoiceLine {
  const factory InvoiceLine({
    required String description,
    @Default(0.0) double amount,
  }) = _InvoiceLine;
}
