import 'package:easystory/models/bookmark.dart';
import 'package:easystory/models/post.dart';
import 'package:easystory/providers/bookmarks_provider.dart';
import 'package:easystory/providers/posts_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'view_post_page.dart';

class BookmarksPage extends StatefulWidget {
  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  late Future<List?> itemsList;
  final bookmarksProvider = new BookmarksProvider();

  @override
  Widget build(BuildContext context) {
    return _bookmarksList();
  }

  Widget _bookmarksList() {
    return FutureBuilder<List?>(
      future: bookmarksProvider.getAll('bookmarks'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return BookmarkRow(snapshot.data?[index]);
              });
        } else if (snapshot.hasError) {
          Text('${snapshot.error}');
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class BookmarkRow extends StatefulWidget {
  final Bookmark bookmark;
  BookmarkRow(this.bookmark);

  @override
  _BookmarkRowState createState() => _BookmarkRowState();
}

class _BookmarkRowState extends State<BookmarkRow> {
  late Future<Post> post;

  PostsProvider postsProvider = new PostsProvider();

  @override
  void initState() {
    super.initState();
    post = postsProvider.getOne('posts/', widget.bookmark.postId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Post>(
      future: post,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var obj = snapshot.data!;
          return Center(
              child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.book),
                  title: Text(obj.title),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewPostPage(
                                        postId: widget.bookmark.postId,
                                        authorId: widget.bookmark.userId,
                                      ))); //ACA
                        },
                        child: const Text('Ver Publicación')),
                  ],
                ),
              ],
            ),
          ));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}
