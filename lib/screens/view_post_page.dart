import 'package:easystory/models/post.dart';
import 'package:easystory/models/user.dart';
import 'package:easystory/providers/posts_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewPostPage extends StatefulWidget {
  final int postId;
  final int authorId;

  ViewPostPage({Key? key, required this.postId, required this.authorId})
      : super(key: key);

  @override
  _ViewPostPageState createState() => _ViewPostPageState();
}

class _ViewPostPageState extends State<ViewPostPage> {
  PostsProvider postsProvider = new PostsProvider();

  late Future<Post> post;
  late Future<User> author;

  @override
  void initState() {
    super.initState();
    post = postsProvider.getOne('posts/', widget.postId);
    author = postsProvider.getAuthor('users/', widget.authorId);
  }

  FutureBuilder<Post> _getPost() {
    return FutureBuilder<Post>(
      future: post,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var obj = snapshot.data!;
          // Post body
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text('Título: ' + obj.title),
              const SizedBox(height: 30),
              Text('Descripción: ' + obj.description),
              const SizedBox(height: 30),
              Text('Contenido: ' + obj.content),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Publicación'),
      ),
      body: _getPost(),
    );
  }
}
