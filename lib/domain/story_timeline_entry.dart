import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_timeline_entry.freezed.dart';

@freezed
class StoryTimelineEntry with _$StoryTimelineEntry {
  const factory StoryTimelineEntry({
    required String title,
    required String description,
  }) = _StoryTimelineEntry;
}
