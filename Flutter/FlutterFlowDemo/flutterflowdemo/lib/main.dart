import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'home_page_widget.dart'; // Import your home page widget file

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  navigatorKey: GlobalKey<NavigatorState>(),
  routes: [
    // Add your other routes here if needed
    // Example route for the home page
    // If you want to navigate to this page, use context.go('/')
    // context.go('/details') would go to the '/details' route, etc.
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
