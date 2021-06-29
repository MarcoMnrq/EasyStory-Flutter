import 'package:easystory/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewPostPage extends StatefulWidget {
  final Post post;

  ViewPostPage({Key? key, required this.post}) : super(key: key);

  @override
  _ViewPostPageState createState() => _ViewPostPageState();
}

class _ViewPostPageState extends State<ViewPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Publicación'),
      ),
      body: Container(
          child: Column(
        children: [
          const SizedBox(height: 30),
          Center(
              child: Text(
            widget.post.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ],
      )),
    );
  }
}
