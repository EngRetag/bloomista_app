import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Import all screens
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
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

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://YOUR_PROJECT_URL.supabase.co',
    anonKey: 'YOUR_ANON_KEY',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const BloomistaApp(),
    ),
  );
}

final supabase = Supabase.instance.client;

// Root application widget
class BloomistaApp extends StatelessWidget {
  const BloomistaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner

      // Application title
      title: 'Bloomista App',

      // Global theme settings
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),

      // Initial screen when the app starts
      home: const LoginScreen(), // Start with Login screen

      // Named routes for navigation between screens
      routes: {
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/catalog': (context) => const CatalogScreen(),
        '/categories': (context) => const CategoriesScreen(),
        '/product': (context) => const ProductDetailsScreen(),
        '/cart': (context) => const CartScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/thankyou': (context) => const ThankYouScreen(),
      },
    );
  }
}
