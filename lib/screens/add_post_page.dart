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
  final TextEditingController _controller = TextEditingController();
  Future<Post>? _futurePost;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Enter Title'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _futurePost = postsProvider.create(_controller.text);
              });
            },
            child: Text('Create Data'),
          ),
        ],
      ),
    );
  }
}
