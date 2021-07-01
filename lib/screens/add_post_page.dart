import 'package:easystory/models/post.dart';
import 'package:easystory/providers/posts_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  PostsProvider postsProvider = new PostsProvider();

  Post post = new Post(
      id: 3,
      content: '',
      title: '',
      createdAt: new DateTime(2020),
      updatedAt: new DateTime(2020),
      description: '',
      userId: 3);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            onChanged: (value) => {post.title = value},
            decoration: InputDecoration(hintText: 'Título'),
          ),
          TextField(
            onChanged: (value) => {post.description = value},
            decoration: InputDecoration(hintText: 'Descripción'),
          ),
          TextField(
            onChanged: (value) => {post.content = value},
            decoration: InputDecoration(hintText: 'Contentenido'),
          ),
          ElevatedButton(
            onPressed: () {
              print(post.toJson());
              postsProvider.create('users/1/posts', post.toJson());
            },
            child: Text('Publicar post'),
          ),
        ],
      ),
    );
  }
}
