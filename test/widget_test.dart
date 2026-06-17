import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloomista_app/main.dart';

void main() {
  testWidgets('Login screen loads correctly', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const BloomistaApp());

    // Verify that Login screen shows "Welcome Back!"
    expect(find.text("Welcome Back!"), findsOneWidget);

    // Verify that email and password fields exist
    expect(find.byType(TextFormField), findsNWidgets(2));

    // Verify that Login button exists
    expect(find.text("Login"), findsOneWidget);
  });
}
