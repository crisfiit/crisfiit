import 'package:flutter_test/flutter_test.dart';
import 'package:crisfiit/main.dart';

void main() {
  testWidgets('Crisfiit starts without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const CrisfiitApp());

    expect(tester.takeException(), isNull);
  });
}