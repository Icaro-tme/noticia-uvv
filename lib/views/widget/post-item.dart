import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final String portalName;
  final String imageUrl;
  final String title;
  final String url;
  final int likeCount;
  final bool isLiked;
  final VoidCallback onLikeToggle;

  PostItem({
    required this.portalName,
    required this.imageUrl,
    required this.title,
    required this.url,
    required this.likeCount,
    required this.isLiked,
    required this.onLikeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.network(
                  imageUrl,
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Text(
                portalName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity, 
            height: 200, 
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover, 
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/sol.jpg', fit: BoxFit.cover); 
              },
            ),
          ),
          SizedBox(height: 10),
          Text(title),
          SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
                onPressed: onLikeToggle,
              ),
              Text('$likeCount curtidas'),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
