import 'package:alisha_dawid_wedding_website/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders root shell', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: WeddingWebsiteApp(),
      ),
    );
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.textContaining('Alisha'), findsWidgets);
  });
}
