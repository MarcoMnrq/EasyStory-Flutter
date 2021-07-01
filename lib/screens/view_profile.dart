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
            return Container(
                padding: EdgeInsets.only(left: 15, top: 20, right: 15),
                child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: ListView(children: [
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 4, color: Colors.white),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1))
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://images.unsplash.com/photo-1621202432974-5e3aac3f5f10?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fGJsb25kZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60'))),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 4, color: Colors.white),
                                      color: Colors.blue),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Text("Nombre " + user.firstName),
                      Text("Apellido " + user.lastName),
                      Text("Email " + user.email),
                      Text("Usuario @" + user.username),
                    ])));
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
