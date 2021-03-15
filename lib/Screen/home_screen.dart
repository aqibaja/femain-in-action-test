import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:female_in_action/Screen/add_screen.dart';
import 'package:female_in_action/Screen/feed_screen.dart';
import 'package:female_in_action/Screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  final String uid;
  final String uavatarUrl;
  final String username;
  MyHomePage({this.uid, this.uavatarUrl, this.username});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.uid);
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            FeedScreen(),
            AddScreen(
              uid: widget.uid,
              uavatarUrl: widget.uavatarUrl,
            ),
            ProfileScreen(
              uid: widget.uid,
              username: widget.username,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text('Feed'),
            icon: Icon(Icons.home),
            activeColor: Colors.pink,
          ),
          BottomNavyBarItem(
            title: Text('Add'),
            icon: Icon(Icons.add_box_outlined),
            activeColor: Colors.pink,
          ),
          BottomNavyBarItem(
            title: Text('Profile'),
            icon: Icon(Icons.person),
            activeColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}
