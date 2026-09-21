import 'package:flutter_test/flutter_test.dart';

import 'package:linguatude/main.dart';
import 'package:linguatude/screens/onboarding/onboarding_diagnostic_study_plan_screen.dart';
import 'package:linguatude/screens/onboarding/onboarding_exam_selector_screen.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Sign In screen renders as home', (WidgetTester tester) async {
    await tester.pumpWidget(const LinguatudeApp());
    await tester.pump();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('Study plan preview renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: OnboardingDiagnosticStudyPlanScreen()),
    );
    await tester.pump();

    expect(find.text('Step 6 of 7'), findsOneWidget);
    expect(find.text('Your personalised plan is ready'), findsOneWidget);
    expect(find.text('Your first 3 lessons'), findsOneWidget);
    expect(find.text('Speaking: Part 1'), findsOneWidget);
    expect(find.text('Start Learning'), findsOneWidget);
  });

  testWidgets('Onboarding exam selector renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: OnboardingExamSelectorScreen()),
    );
    await tester.pump();

    expect(find.text('Step 1 of 7'), findsOneWidget);
    expect(find.text("Let's get you ready"), findsOneWidget);
    expect(find.text('IELTS Academic'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });
}
