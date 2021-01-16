import 'package:flutter/material.dart';
import 'package:socalnetwork/pages/home.dart';
import 'package:socalnetwork/widgets/header.dart';
import 'package:socalnetwork/widgets/post.dart';
import 'package:socalnetwork/widgets/progress.dart';

class PostScreen extends StatelessWidget {
  final String userId;
  final String postId;

  PostScreen({
    this.userId,
    this.postId,
  });
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: postsRef.doc(userId).collection(postId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return linearProgress();
          }
          Post post = Post.fromDocument(snapshot.data);
          return Center(
            child: Scaffold(
              appBar: header(
                context,
                titleText: post.description,
              ),
            ),
          );
        });
  }
}
