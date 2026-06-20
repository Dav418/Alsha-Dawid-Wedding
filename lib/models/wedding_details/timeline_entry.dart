import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timeline_entry.freezed.dart';

@freezed
class TimelineEntry with _$TimelineEntry {
  const factory TimelineEntry({
    required String time,
    required String title,
    String? details,
    IconData? icon,
    String? pinImageAssetPath,
  }) = _TimelineEntry;
}
