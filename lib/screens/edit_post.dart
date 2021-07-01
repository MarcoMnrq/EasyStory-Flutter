import 'package:easystory/models/post.dart';
import 'package:easystory/providers/posts_provider.dart';
import 'package:flutter/material.dart';

class EditPostPage extends StatefulWidget {
  final int postId;

  EditPostPage({Key? key, required this.postId}) : super(key: key);

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  PostsProvider postsProvider = new PostsProvider();
  late Future<Post> previousPage =
      postsProvider.getOne('posts/', widget.postId);
  Post post = new Post(
      id: 1,
      content: '',
      title: '',
      createdAt: new DateTime(2020),
      updatedAt: new DateTime(2020),
      description: '',
      userId: 3);

  FutureBuilder<Post> _getEditPost() {
    return FutureBuilder<Post>(
        future: previousPage,
        builder: (context, snapshot) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  onChanged: (value) => {post.title = value},
                  decoration: InputDecoration(hintText: 'Titulo'),
                ),
                TextField(
                  onChanged: (value) => {post.description = value},
                  decoration: InputDecoration(hintText: 'Description'),
                ),
                TextField(
                  onChanged: (value) => {post.content = value},
                  decoration: InputDecoration(hintText: 'Contenido'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print(post.toJson());
                    postsProvider.update(
                        'users/1/posts/' + widget.postId.toString(),
                        post.toJson());
                  },
                  child: Text('Actualizar post'),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Post'),
      ),
      body: _getEditPost(),
    );
  }
}
