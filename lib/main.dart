import 'package:easystory/screens/add_post.dart';
import 'package:easystory/screens/home_page.dart';
import 'package:easystory/screens/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EasyStory',
      initialRoute: 'login',
      theme: ThemeData(
          primaryColor: Colors.blue,
          textTheme: TextTheme(button: TextStyle(color: Colors.black54)),
          brightness: Brightness.light,
          accentColor: Colors.blue),
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'post': (BuildContext context) => AddPost(),
      },
    );
  }
}
