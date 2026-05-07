import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wedding_invoice/app.dart';

void main() {
  testWidgets('renders root shell', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: WeddingInvoiceApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.textContaining('Invoice'), findsWidgets);
  });
}
