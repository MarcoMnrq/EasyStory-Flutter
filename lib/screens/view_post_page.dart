import 'package:easystory/models/bookmark.dart';
import 'package:easystory/models/post.dart';
import 'package:easystory/models/user.dart';
import 'package:easystory/providers/posts_provider.dart';
import 'package:easystory/screens/edit_post.dart';
import 'package:easystory/screens/feed_page.dart';
import 'package:easystory/screens/home_page.dart';
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

  Widget _deletePost() {
    return FutureBuilder<Post>(
        future: post,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        postsProvider.deletePost(
                            'users/1/posts/' + widget.postId.toString());
                        Navigator.pop(context);
                      },
                      child: Text('Borrar post'))
                ]);
          } else {
            return Text("Uy");
          }
        });
  }

  Widget _editPost() {
    return FutureBuilder<Post>(
        future: post,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditPostPage(postId: widget.postId),
                      ),
                    );
                  },
                  child: const Text('Editar Post'))
            ],
          );
        });
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
              _deletePost(),
              _editPost(),
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
          return ElevatedButton.icon(
              onPressed: () {
                // Eliminar de bookmark
                postsProvider.deleteBookmark(
                    'users/1/posts/' + widget.postId.toString() + '/bookmarks');
                Navigator.pop(context);
              },
              icon: Icon(Icons.bookmark_border_sharp),
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
              icon: Icon(Icons.bookmark_border_sharp),
              label: Text('Guardar'));
        }
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
