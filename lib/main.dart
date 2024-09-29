import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noticia_app/firebase_options.dart';
import 'package:noticia_app/services/login-service.dart';
import 'package:noticia_app/views/login-page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'components/header_comp.dart';
import 'components/sidebar_comp.dart';
import '/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => LoginService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noticia App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute,
      locale: Locale('pt', 'BR'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('pt', 'BR'), Locale('en', 'US')],
      home: AuthWrapper(), 
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);

    if (loginService.isAuthenticated) {
      return MyHomePage(); 
    } else {

      return LoginPage(); 
    }
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  bool _isSidebarExpanded = false;

  void _toggleSidebar() {
    setState(() {
      _isSidebarExpanded = !_isSidebarExpanded;
    });
  }

  void _onItemSelected(String routeName) {
    _navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HeaderComp(
          isSidebarExpanded: _isSidebarExpanded,
          toggleSidebar: _toggleSidebar,
        ),
      ),
      body: Row(
        children: [
          SidebarComp(
            onItemSelected: _onItemSelected,
            isExpanded: _isSidebarExpanded,
          ),
          Expanded(
            child: Navigator(
              key: _navigatorKey,
              onGenerateRoute: AppRoutes.generateRoute, 
            ),
          ),
        ],
      ),
    );
  }
}
