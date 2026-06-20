import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../config/wedding_content_config.dart';
import '../../models/content/wedding_content.dart';

part 'wedding_content_repository.g.dart';

@riverpod
class WeddingContentRepository extends _$WeddingContentRepository {
  @override
  Future<WeddingContent> build() async => loadWeddingContent();
}

Future<WeddingContent> loadWeddingContent() async {
  if (!isWeddingContentConfigured) {
    throw StateError(
      'WEDDING_CONTENT_JSON was not provided. '
      'Copy wedding_content.json.example to wedding_content.json, run '
      'python3 scripts/merge_dart_defines.py, then launch with '
      '--dart-define-from-file=dart_defines.json',
    );
  }

  final json = jsonDecode(weddingContentJson) as Map<String, dynamic>;
  return WeddingContent.fromJson(json);
}
