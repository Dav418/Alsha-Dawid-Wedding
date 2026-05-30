import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/wedding_content.dart';

part 'wedding_content_repository.g.dart';

@riverpod
class WeddingContentRepository extends _$WeddingContentRepository {
  static const assetPath = 'assets/content/wedding_content.json';

  @override
  Future<WeddingContent> build() async {
    final jsonString = await rootBundle.loadString(assetPath);
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return WeddingContent.fromJson(json);
  }
}
