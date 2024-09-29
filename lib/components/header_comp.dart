import 'package:flutter/material.dart';
// login service
import 'package:noticia_app/services/login-service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSidebarExpanded = false;

  void _toggleSidebar() {
    setState(() {
      _isSidebarExpanded = !_isSidebarExpanded;
    });
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
      drawer: _isSidebarExpanded ? Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(child: Text('Sidebar')),
            ListTile(title: Text('Item 1')),
            ListTile(title: Text('Item 2')),
          ],
        ),
      ) : null,
      body: Center(child: Text('Main Content')),
    );
  }
}

class HeaderComp extends StatelessWidget {
  final bool isSidebarExpanded;
  final VoidCallback toggleSidebar;

  HeaderComp({
    required this.isSidebarExpanded,
    required this.toggleSidebar,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: toggleSidebar,
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/dashboard');
            },
            // child: Image.asset(
            //   'assets/iemaLogo.png',
            //   height: 40,
            //  Image.network("https://cdn-icons-png.flaticon.com/512/21/21601.png"
            child: Image.network( "https://cdn-icons-png.flaticon.com/512/21/21601.png",
              height: 40,
            ),
          ),
          Spacer(),
          Row(
            children: [
              // IconButton(
              //   icon: Icon(Icons.language),
              //   tooltip: 'Linguagem de sinais',
              //   onPressed: () {
              //     // Handle language button press
              //   },
              // ),
              // IconButton(
              //   icon: Icon(Icons.keyboard),
              //   tooltip: 'Teclado virtual',
              //   onPressed: () {
              //     // Handle virtual keyboard button press
              //   },
              // ),
              // IconButton(
              //   icon: Icon(Icons.accessibility),
              //   tooltip: 'Acessibilidade',
              //   onPressed: () {
              //     // Handle accessibility button press
              //   },
              // ),
              IconButton(
                icon: Icon(Icons.contrast),
                tooltip: 'Modo alto contraste',
                onPressed: () {
                },
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Log-Out',
            onPressed: () {
              try{
                final loginService = Provider.of<LoginService>(context, listen: false);
                loginService.logout();
                
                Navigator.pushReplacementNamed(context, '/login');
              } catch(e){
                print(e);
              }
            },
          ),
        ],
      ),
    );
  }
}

