import "package:flutter/material.dart";
import 'package:wanandroid/view/article.dart';
import 'package:wanandroid/view/list_test.dart';
import 'package:wanandroid/view/find.dart';
import 'package:wanandroid/res/constant.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHome();
}

class _MyHome extends State<_MyHomePage> {
  int _currentIndex = 0;
  var _navigationBars = [
    new BottomNavigationBarItem(icon: Icon(Icons.home), title: Text(Strings.home_tab)),
    new BottomNavigationBarItem(
        icon: Icon(Icons.event_note), title: Text(Strings.find_tab)),
    new BottomNavigationBarItem(
        icon: Icon(Icons.cast_connected), title: Text(Strings.mine_tab)),
  ];

  final _pageView = [ArticlePage(), FindPage(), ListTest()];

  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("wanandroid"),
      ),
      body: PageView.builder(
        itemBuilder: (context, index) {
          return _pageView[index];
        },
        itemCount: _pageView.length,
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationBars,
        currentIndex: _currentIndex,
        onTap: _bottomClicked,
      ),
    );
  }

  _bottomClicked(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    });
  }
}
