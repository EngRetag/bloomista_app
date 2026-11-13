import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// TODO: Uncomment the line below once Supabase backend is configured
// import 'package:supabase_flutter/supabase_flutter.dart';

// Import all screens
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/create_password_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/thank_you_screen.dart';

// Import CartProvider
import 'package:bloomista_app/cart_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // =========================================================================
  // TODO: Uncomment this block when your Supabase project credentials are ready
  // =========================================================================
  /*
  await Supabase.initialize(
    url: 'https://YOUR_PROJECT_URL.supabase.co',
    anonKey: 'YOUR_ANON_KEY',
  );
  */

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const BloomistaApp(),
    ),
  );
}

// TODO: Uncomment once Supabase.initialize is enabled above
// final supabase = Supabase.instance.client;

class BloomistaApp extends StatelessWidget {
  const BloomistaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloomista App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const LoginScreen(),
      routes: {
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgotPassword': (context) => const ForgotPasswordScreen(),
        '/createPassword': (context) => const CreatePasswordScreen(),
        '/catalog': (context) => const CatalogScreen(),
        '/categories': (context) => const CategoriesScreen(),
        '/product': (context) => const ProductDetailsScreen(),
        '/cart': (context) => const CartScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/thankyou': (context) => const ThankYouScreen(),
        '/checkout': (context) => const ThankYouScreen(),
      },
    );
  }
}