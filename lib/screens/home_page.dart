import 'package:easystory/screens/add_post_page.dart';
import 'package:easystory/screens/bookmars_page.dart';
import 'package:easystory/screens/feed_page.dart';
import 'package:easystory/screens/hashtags_page.dart';
import 'package:easystory/screens/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _pages = [
    FeedPage(),
    HashtagsPage(),
    AddPostPage(),
    BookmarksPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('EasyStory'),
      ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.tag), label: 'Hashtags'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Redactar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'Guardado'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'Perfil'),
        ],
        currentIndex: _selectedIndex,
        onTap: _changeNavigation,
      ),
    );
  }

  void _changeNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
