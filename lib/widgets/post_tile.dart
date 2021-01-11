import 'package:flutter/material.dart';
import 'package:socalnetwork/widgets/custom_image.dart';
import 'package:socalnetwork/widgets/post.dart';

class PostTile extends StatelessWidget {
  final Post post;

  PostTile(this.post);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("Full screen"),
      child: cachedNetworkImage(post.mediaUrl),
    );
  }
}
