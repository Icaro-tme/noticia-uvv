// lib/app_routes.dart
import 'package:flutter/material.dart';
import 'package:noticia_app/views/liked-posts-page.dart';
import '../views/dashboard-page.dart';
import '../views/login-page.dart';
import '../views/criar-conta-page.dart';


class AppRoutes {
  static const String home = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/dashboard':
        return MaterialPageRoute(
          builder: (context) => DashboardPage(),
        );
      case '/liked-posts':
      return MaterialPageRoute(
        builder: (context) => LikedPostsPage(),
      );
      case '/login':
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
      case '/criarConta':
        return MaterialPageRoute(
          builder: (context) => CriarContaPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
