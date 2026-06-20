import 'package:freezed_annotation/freezed_annotation.dart';

part 'polaroid_layout.freezed.dart';

@freezed
class PolaroidLayout with _$PolaroidLayout {
  const factory PolaroidLayout({
    required double top,
    required double left,
    required double rotation,
  }) = _PolaroidLayout;
}
