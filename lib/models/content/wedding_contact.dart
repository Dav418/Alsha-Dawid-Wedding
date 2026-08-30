import 'package:freezed_annotation/freezed_annotation.dart';

part 'wedding_contact.freezed.dart';
part 'wedding_contact.g.dart';

@freezed
class WeddingContact with _$WeddingContact {
  const factory WeddingContact({
    required String email,
  }) = _WeddingContact;

  factory WeddingContact.fromJson(Map<String, dynamic> json) =>
      _$WeddingContactFromJson(json);
}
