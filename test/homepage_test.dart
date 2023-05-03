import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:Dhali_website/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'homepage_test.mocks.dart';

@GenerateMocks([FirebaseAnalytics])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  var analytics = MockFirebaseAnalytics();

  testWidgets('Test empty business problem form ', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(analytics: analytics));

    expect(
        find.text(
            '  Dhali levels the playing field by providing an\nopen marketplace that offers cutting-edge AI solutions  '),
        findsOneWidget);
    expect(find.byKey(const Key("add-email-button")), findsOneWidget);
    expect(find.text('Email address'), findsOneWidget);

    await tester.tap(find.byKey(const Key("add-email-button")));
    await tester.pump();
    expect(find.text('Please enter a valid email address'), findsOneWidget);
  });
}
