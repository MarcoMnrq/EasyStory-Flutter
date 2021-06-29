import 'package:easystory/models/hashtag.dart';
import 'package:easystory/screens/posts_by_hashtag_page.dart';
import 'package:easystory/utils/http_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HashtagsPage extends StatefulWidget {
  @override
  _HashtagsPageState createState() => _HashtagsPageState();
}

class _HashtagsPageState extends State<HashtagsPage> {
  HttpHelper httpHelper = new HttpHelper();

  late Future<List> hashtagList;

  @override
  void initState() {
    super.initState();
    hashtagList = httpHelper.getAllHashtags('hashtags');
  }

  Widget _hashtagCard(Hashtag hashtag) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostsByHashtagPage(
                    hashtag: hashtag,
                  ),
                ),
              );
            },
            child: Text('#' + hashtag.name)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List?>(
      future: hashtagList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                var hashtag = snapshot.data?[index] as Hashtag;
                return _hashtagCard(hashtag);
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
