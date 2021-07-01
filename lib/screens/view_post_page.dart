import 'package:easystory/models/bookmark.dart';
import 'package:easystory/models/post.dart';
import 'package:easystory/models/user.dart';
import 'package:easystory/providers/posts_provider.dart';
import 'package:easystory/screens/bookmars_page.dart';
import 'package:easystory/screens/view_profile.dart';
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
  late Future<Bookmark?> bookmark;

  @override
  void initState() {
    super.initState();
    post = postsProvider.getOne('posts/', widget.postId);
    author = postsProvider.getAuthor('users/', widget.authorId);
    bookmark = postsProvider.getBookmark(
        'users/1/posts/' + widget.postId.toString() + '/bookmarks');
  }

  FutureBuilder<User> _getAuthor() {
    return FutureBuilder<User>(
      future: author,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var obj = snapshot.data!;
          // Post body
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewProfile(
                          userId: obj.id,
                        ),
                      ),
                    );
                  },
                  child: Text('Autor: ' + obj.firstName + ' ' + obj.lastName)),
              const SizedBox(height: 30),
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
              _getAuthor(),
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

  Widget _getBookmark() {
    return FutureBuilder<Bookmark?>(
      future: bookmark,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var obj = snapshot.data!;
          return ElevatedButton.icon(
              onPressed: () {
                // Eliminar de bookmark
                postsProvider.deleteBookmark(
                    'users/1/posts/' + widget.postId.toString() + '/bookmarks');
                Navigator.pop(context);
              },
              icon: Icon(Icons.bookmark_added),
              label: Text('Guardado'));
        } else if (snapshot.hasError) {
          return Text("Uy");
        } else {
          return ElevatedButton.icon(
              onPressed: () {
                // Agregar a bookmark
                bookmark = postsProvider.addBookmark(
                    'users/1/posts/' + widget.postId.toString() + '/bookmarks');
                Navigator.pop(context);
              },
              icon: Icon(Icons.bookmark_add),
              label: Text('Guardar'));
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
        actions: [_getBookmark()],
      ),
      body: _getPost(),
    );
  }
}
