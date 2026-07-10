import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:zionsongsfinal/main.dart';

void main() {
  testWidgets('Zion Songs smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(MyApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
