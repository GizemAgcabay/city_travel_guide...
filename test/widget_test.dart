import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staj_proje/main.dart';

void main() {
  testWidgets('Uygulama başlatılır', (WidgetTester tester) async {
    await tester.pumpWidget(const BeautyBagApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
