import 'package:flutter/material.dart';
import 'package:socalnetwork/pages/post_screen.dart';
import 'package:socalnetwork/widgets/custom_image.dart';
import 'package:socalnetwork/widgets/post.dart';

class PostTile extends StatelessWidget {
  final Post post;

  PostTile(this.post);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PostScreen(
            userId: post.ownerId,
            postId: post.postId,
          ),
        ),
      ),
      child: cachedNetworkImage(post.mediaUrl),
    );
  }
}
