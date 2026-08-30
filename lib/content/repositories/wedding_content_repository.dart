import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../config/hygraph_config.dart';
import '../../models/content/content.dart';

part 'wedding_content_repository.g.dart';

@riverpod
class WeddingContentRepository extends _$WeddingContentRepository {
  @override
  Future<WeddingContent> build() async => loadWeddingContent();
}

Future<WeddingContent> loadWeddingContent() async {
  final response = await http.post(
    Uri.parse(HygraphConfig.endpoint),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'query': HygraphConfig.weddingContentQuery,
    }),
  );

  if (response.statusCode < 200 || response.statusCode >= 300) {
    throw StateError(
      'Hygraph request failed with HTTP ${response.statusCode}.',
    );
  }

  final decoded = jsonDecode(
    utf8.decode(response.bodyBytes),
  );

  if (decoded is! Map<String, dynamic>) {
    throw StateError(
      'Hygraph returned an unexpected response.',
    );
  }

  final errors = decoded['errors'];

  if (errors is List && errors.isNotEmpty) {
    throw StateError(
      'Hygraph returned GraphQL errors: ${jsonEncode(errors)}',
    );
  }

  final data = decoded['data'];

  if (data is! Map<String, dynamic>) {
    throw StateError(
      'Hygraph response did not contain data.',
    );
  }

  final weddings = data['weddings'];

  if (weddings is! List || weddings.isEmpty) {
    throw StateError(
      'No published Wedding entry was found in Hygraph.',
    );
  }

  final wedding = weddings.first;

  if (wedding is! Map<String, dynamic>) {
    throw StateError(
      'Hygraph returned an invalid Wedding entry.',
    );
  }

  return WeddingContent.fromJson(wedding);
}
