import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:bloomista_app/main.dart';
import 'package:bloomista_app/cart_provider.dart';

void main() {
  testWidgets('Login screen loads correctly', (WidgetTester tester) async {
    // Wrap BloomistaApp with CartProvider so all screens can access cart state
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
        child: const BloomistaApp(),
      ),
    );

    // Verify that the welcome message is displayed
    expect(find.text("Welcome Back!"), findsOneWidget);

    // Verify that email and password fields exist
    expect(find.byType(TextFormField), findsNWidgets(2));

    // Verify that the Login button exists (targeted specifically since "Login" also appears in the AppBar)
    expect(find.widgetWithText(ElevatedButton, "Login"), findsOneWidget);

    // Verify that the Sign Up navigation link exists
    expect(find.text("Don't have an account? Sign Up"), findsOneWidget);
  });
}