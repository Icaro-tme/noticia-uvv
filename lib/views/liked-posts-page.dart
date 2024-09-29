import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:noticia_app/components/header_comp.dart';
import 'package:noticia_app/components/sidebar_comp.dart';
import 'package:noticia_app/views/widget/post-item.dart';
import 'package:noticia_app/settings.dart';

class LikedPostsPage extends StatefulWidget {
  LikedPostsPage({Key? key}) : super(key: key);

  @override
  _LikedPostsPageState createState() => _LikedPostsPageState();
}

class _LikedPostsPageState extends State<LikedPostsPage> {
  List<dynamic> posts = [];
  final String userId = "66e744b86099e1a101cb4697"; // TESTE USUARIO LOGADO
  Dio dio = Dio();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchLikedPosts();
  }

  Future<void> fetchLikedPosts() async {
    final String url = "${Settings.apiNovaUrl}noticias/$userId/liked";

    try {
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      print("Fetching liked posts from: $url");

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        setState(() {
          posts = response.data;
        });
      } else {
        throw Exception('Failed to load liked posts');
      }
    } catch (e) {
      print("Error fetching liked posts: $e");
    }
  }

  bool _isSidebarExpanded = false;

  void _toggleSidebar() {
    setState(() {
      _isSidebarExpanded = !_isSidebarExpanded;
    });
    if (_isSidebarExpanded) {
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HeaderComp(
          isSidebarExpanded: _isSidebarExpanded,
          toggleSidebar: _toggleSidebar,
        ),
      ),
      drawer: SidebarComp(
        onItemSelected: (route) {
          Navigator.of(context).pushNamed(route);
        },
        isExpanded: _isSidebarExpanded,
      ),
      body: posts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                String imageUrl = post['ImgURL'] ?? '';

                // TODO: IMAGENS DE TESTE
                if (index % 3 == 0) {
                  imageUrl = 'assets/sol.jpg';
                } else if (index % 3 == 1) {
                  imageUrl = 'assets/piza.jpg';
                } else {
                  imageUrl = 'assets/montanha.jpg';
                }

                return PostItem(
                  portalName: post['NomePortal'] ?? "Unknown",
                  imageUrl: imageUrl,
                  title: post['title'] ?? '',
                  url: post['URL'] ?? '',
                  likeCount: post['likeCount'] ?? 0,
                  isLiked: true, 
                  onLikeToggle: () => {},
                );
              },
            ),
    );
  }
}
