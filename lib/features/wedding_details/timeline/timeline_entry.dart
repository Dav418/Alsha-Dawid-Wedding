import 'package:flutter/material.dart';

class TimelineEntry {
  const TimelineEntry({
    required this.time,
    required this.title,
    this.details,
    this.icon,
  });

  final String time;
  final String title;
  final String? details;
  final IconData? icon;
}
