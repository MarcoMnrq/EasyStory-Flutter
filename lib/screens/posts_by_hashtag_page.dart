import 'package:easystory/models/hashtag.dart';
import 'package:easystory/models/post.dart';
import 'package:easystory/screens/view_post_page.dart';
import 'package:easystory/utils/http_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostsByHashtagPage extends StatefulWidget {
  final Hashtag hashtag;

  PostsByHashtagPage({Key? key, required this.hashtag}) : super(key: key);

  @override
  _PostsByHashtagPageState createState() => _PostsByHashtagPageState();
}

class _PostsByHashtagPageState extends State<PostsByHashtagPage> {
  HttpHelper httpHelper = new HttpHelper();

  late Future<List> postsList;

  @override
  void initState() {
    super.initState();
    var hashtagId = widget.hashtag.id.toString();
    postsList = httpHelper.getAllPosts('hashtags/' + hashtagId + '/posts');
  }

  Widget _postCard(Post post) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.book),
              title: Text(post.title),
              subtitle: Text(post.description),
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
                          postId: post.id,
                          authorId: post.userId,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Publicaciones de #' + widget.hashtag.name),
        ),
        body: FutureBuilder<List?>(
          future: postsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    var post = snapshot.data?[index] as Post;
                    return _postCard(post);
                  });
            } else if (snapshot.hasError) {
              Text('${snapshot.error}');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
