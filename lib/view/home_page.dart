import "package:flutter/material.dart";
import 'package:wanandroid/view/article.dart';
import 'package:wanandroid/view/list_test.dart';
import 'package:wanandroid/view/find.dart';
import 'package:wanandroid/res/constant.dart';
import 'search.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
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
    new BottomNavigationBarItem(
        icon: Icon(Icons.home), title: Text(Strings.home_tab),
        backgroundColor: Colors.black),
    new BottomNavigationBarItem(
        icon: Icon(Icons.event_note), title: Text(Strings.find_tab),
        backgroundColor: Colors.black),
    new BottomNavigationBarItem(
        icon: Icon(Icons.person), title: Text(Strings.mine_tab),
        backgroundColor: Colors.black),
  ];

  final _pageView = [ArticlePage(), FindPage(), AnimatedListSample()];

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
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),
              onPressed: () => _openSearch())
        ],
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
        fixedColor: Colors.blue,
        onTap: _bottomClicked,
      ),
    );
  }

  _openSearch() {
    Navigator.of(context).push(new MaterialPageRoute
      (builder: (context) => SearchPage()));
  }

  _bottomClicked(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    });
  }
}
