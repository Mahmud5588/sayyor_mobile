import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App can be instantiated', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Center(child: Text('Sayyor'))),
      ),
    );

    expect(find.text('Sayyor'), findsOneWidget);
  });
}
