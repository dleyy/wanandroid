import 'package:flutter/material.dart';
import 'dart:async';

class CycleView extends StatefulWidget {

  //图片集合
  List<CycleImageEntity> cycleImages = new List();
  //点击事件回调
  Function onPageClicked;
  //是否自动滚动
  bool autoScroll;
  
  CycleView(@required this.cycleImages,
      {this.onPageClicked, this.autoScroll})
      :assert(cycleImages != null);

  @override
  State<StatefulWidget> createState() => _Cycle();

}

class _Cycle extends State<CycleView> with SingleTickerProviderStateMixin {
  
  Duration _scrollDuration = const Duration(microseconds: 20);

  TabController _tabController;
  PageController _pageController;
  List<Widget> _pages = new List();
  Timer _timer;
  var _duration = const Duration(seconds: 2);
  int _currentIndex = 0;

  @override
  void initState() {
    if (widget.autoScroll) {
      _timer = Timer.periodic(_duration, _timerCallback);
    }
    _pageController = new PageController();
    _tabController = new TabController(length: widget.cycleImages.length,
        vsync: this);

    for (int i = 0; i < widget.cycleImages.length; i++) {
      _pages.add(new GestureDetector(child: Image.network
        (widget.cycleImages[i].imageUrl, fit: BoxFit.fill,),
          onTap: () => _onPageClicked(i)));
    }

    //为pageView的头部添加最后一个widget、尾部加上第一个widget。
    if (widget.cycleImages.length > 1) {
      _pages.insert(0, new GestureDetector(child: Image.network
        (widget.cycleImages[widget.cycleImages.length - 1].imageUrl,
        fit: BoxFit.fill,),
          onTap: () => _onPageClicked(widget.cycleImages.length - 1)));

      _pages.add(new GestureDetector(child: Image.network
        (widget.cycleImages[0].imageUrl, fit: BoxFit.fill,),
          onTap: () => _onPageClicked(0)));
    }
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        PageView(
          children: _pages,
          controller: _pageController,
          onPageChanged: _onPageChanged,
        ),
        Align(
          alignment: Alignment(0.0, 1.0),
          child: TabPageSelector(
            color: Colors.white,
            selectedColor: Colors.grey,
            controller: _tabController,
          ),
        ),
      ],
    );
  }

  void _onPageClicked(int index) {
    if (widget.onPageClicked != null) {
      widget.onPageClicked(index);
    }
  }

  void _onPageChanged(int index) {
    if (widget.cycleImages.length == 1) {
      return;
    }
    if (index == 0) {
      _tabController.animateTo(_tabController.length - 1);
      //widget.cycleImages.length-1+1
      _pageController.jumpToPage(widget.cycleImages.length);
    } else if (index == _tabController.length + 1) {
      _tabController.animateTo(0);
      _pageController.jumpToPage(1);
    } else {
      _tabController.animateTo(index - 1);
    }
  }

  void _timerCallback(Timer timer) {
    if (widget.cycleImages.length > 1) {
      _currentIndex++;
      _pageController.animateToPage(
          _currentIndex % widget.cycleImages.length,
          duration: _scrollDuration,
          curve: Curves.fastOutSlowIn);
    }
  }
}

class CycleImageEntity {
  String cycleContent;
  String imageUrl;
}