import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:Dhali_website/main.dart';

void main() {
  testWidgets('Test empty business problem form ', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('  The open marketplace for AI  '), findsOneWidget);
    expect(find.byKey(const Key("main_page_action_button")), findsOneWidget);

    await tester.tap(find.byKey(const Key("main_page_action_button")));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("tell_us_a_problem_that_your_business_faces")),
        findsOneWidget);

    expect(
        find.byKey(const Key("submit_problem_action_button")), findsOneWidget);

    await tester.tap(find.byKey(const Key("submit_problem_action_button")));
    await tester.pump();
    expect(find.text('Please enter a valid email address'), findsOneWidget);
    expect(find.text('Please enter your problem description'), findsOneWidget);
  });
}
