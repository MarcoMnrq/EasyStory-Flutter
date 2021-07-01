import 'package:easystory/models/post.dart';
import 'package:easystory/providers/posts_provider.dart';
import 'package:easystory/screens/view_post_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late Future<List> itemsList;
  final postsProvider = new PostsProvider();
  List searchResult = [];
  List resultTemporal = [];
  String title = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Titulo"),
              onChanged: (value) async {
                title = value;
                print(title);
                setState(() {});
              },
            ),
            Flexible(child: _postsList(title)),
          ],
        ),
      ),
    );
  }

  Widget _postsList(String value) {
    return FutureBuilder<List>(
      future: postsProvider.getAll('posts'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final resultTemporal = snapshot.data;
          if (value == "") {
            return _postResult(resultTemporal!);
          } else {
            searchResult.clear();
            for (var i = 0; i < resultTemporal!.length; i++) {
              String data = resultTemporal[i].title;
              if (data.toLowerCase().contains(value.toLowerCase())) {
                searchResult.add(resultTemporal[i]);
              }
            }
            return _postResult(searchResult);
          }
        } else if (snapshot.hasError) {
          Text('${snapshot.error}');
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _postResult(List result) {
    return ListView.builder(
        itemCount: result.length,
        itemBuilder: (BuildContext context, int index) {
          return PostRow(result[index]);
        });
  }
}

class PostRow extends StatefulWidget {
  final Post post;
  PostRow(this.post);

  @override
  _PostRowState createState() => _PostRowState();
}

class _PostRowState extends State<PostRow> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.book),
              title: Text(widget.post.title),
              subtitle: Text(widget.post.description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('VER PUBLICACIÓN'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewPostPage(
                          postId: widget.post.id,
                          authorId: widget.post.userId,
                        ),
                      ),
                    );
                  },
                ),
                TextButton(
                    onPressed: () {
                      deletePost(context, widget.post.id);
                    },
                    child: const Text('Eliminar')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void deletePost(BuildContext context, int id) async {
  final postsProvider = new PostsProvider();
  late Future<Post> post = postsProvider.getOne('posts', id);
  print(await post);
}
