import 'package:easystory/models/user.dart';
import 'package:easystory/utils/http_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewProfile extends StatefulWidget {
  final int userId;

  ViewProfile({Key? key, required this.userId}) : super(key: key);

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  late Future<User> user;

  HttpHelper httpHelper = new HttpHelper();

  @override
  void initState() {
    super.initState();
    user = httpHelper.getUser(widget.userId.toString());
  }

  Widget _profileBody() {
    return FutureBuilder<User>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var user = snapshot.data!;
            return Text(user.email);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        centerTitle: true,
      ),
      body: Center(child: _profileBody()),
    );
  }
}
