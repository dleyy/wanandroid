import 'package:flutter/material.dart';
import 'package:wanandroid/entity/find_entity.dart';
import 'package:wanandroid/viewModel/find_detail_viewmodel.dart';
import 'package:wanandroid/entity/home_article_entity.dart';
import 'common_article_list.dart';


class FindList extends StatefulWidget {

  String title;
  String id;
  List<FindEntity> content;

  FindList(@required this.title, @required this.id, @required this.content);

  @override
  State<StatefulWidget> createState() => _DetailList();

}

class _DetailList extends State<FindList>
    with
        SingleTickerProviderStateMixin {
  TabController _controller;
  var _tabs = <Widget>[];
  var _tabView = <Widget>[];

  @override
  void initState() {
    _controller = new TabController(length: widget.content.length,
        vsync: this);
    for (int i = 0; i < widget.content.length; i++) {
      _tabs.add(new Tab(text: widget.content[i].channelName,));
      _tabView.add(_FindRecycle(widget.content[i].channelId));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(widget.title),
        bottom: TabBar(tabs: _tabs,
          controller: _controller,
          isScrollable: true,
          labelStyle: TextStyle(
            fontSize: 17.0,
          ),),
      ),
      body: new TabBarView(children: _tabView, controller: _controller,),

    );
  }

}

class _FindRecycle extends StatefulWidget {

  String id;

  _FindRecycle(@required this.id);

  @override
  State<StatefulWidget> createState() => _FindContent();

}

class _FindContent extends State<_FindRecycle>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  var _findViewModel = FindDetailViewModel();
  static const int _initPage = 0;
  List<HomeArticleEntity> _list = new List();


  @override
  void dispose() {
    _findViewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _findViewModel.getArticles(_initPage, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: _findViewModel.articles,
      builder: (context, snap) {
        _list = snap.data != null ? snap.data : [];
        return new CommonArticleList(
            _list, _loadData, _clearData);
      },
    );
  }


  _loadData(int currentPage) {
    _findViewModel.getArticles(currentPage, widget.id);
  }

  _clearData() {
    _findViewModel.cleanList();
  }

}