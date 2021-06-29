import 'package:easystory/models/bookmark.dart';
import 'package:easystory/providers/bookmarks_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Hello'),
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
                                authorId: widget.bookmark.userId)));
                  },
                  child: const Text('Ver Publicación')),
            ],
          ),
        ],
      ),
    ));
  }
}
