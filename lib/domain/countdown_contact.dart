import 'package:freezed_annotation/freezed_annotation.dart';

part 'countdown_contact.freezed.dart';

@freezed
class CountdownContact with _$CountdownContact {
  const factory CountdownContact({
    required String name,
    required String phone,
  }) = _CountdownContact;
}
