// lib/components/sidebar_comp.dart
import 'package:flutter/material.dart';

class SidebarComp extends StatefulWidget {
  final Function(String) onItemSelected;
  final bool isExpanded;

  SidebarComp({required this.onItemSelected, required this.isExpanded});

  @override
  _SidebarCompState createState() => _SidebarCompState();
}

class _SidebarCompState extends State<SidebarComp> {
  late bool _isSidebarExpanded;

  @override
  void initState() {
    super.initState();
    _isSidebarExpanded = widget.isExpanded;
  }

  @override
  void didUpdateWidget(covariant SidebarComp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      setState(() {
        _isSidebarExpanded = widget.isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      width: _isSidebarExpanded ? 250 : 0, 
      child: Drawer(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16), 
              child: AnimatedOpacity(
                opacity: _isSidebarExpanded ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: _isSidebarExpanded ? Text('Acesso Rápido') : null,
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMenuItem(
                    context,
                    'Dashboard',
                    Icons.home,
                    '/dashboard',
                    _isSidebarExpanded,
                  ),
                  _buildMenuItem(
                    context,
                    'Noticias Favoritas',
                    Icons.favorite,
                    '/liked-posts',
                    _isSidebarExpanded,

                  ),
                  // _buildMenuItem(
                  //   context,
                  //   'Second Page',
                  //   Icons.pageview,
                  //   '/second',
                  //   _isSidebarExpanded,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String label, IconData icon, String route, bool isExpanded) {
    return ListTile(
      leading: Icon(icon, size: 24), // Icon size remains constant
      title: AnimatedOpacity(
        opacity: isExpanded ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: isExpanded ? Text(label, overflow: TextOverflow.ellipsis) : null,
      ),
      onTap: () {
        widget.onItemSelected(route);
      },
    );
  }
}
