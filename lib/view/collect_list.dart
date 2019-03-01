import 'package:flutter/material.dart';
import 'package:wanandroid/viewModel/collect_article_viewmodel.dart';
import 'package:wanandroid/entity/home_article_entity.dart';
import 'common_article_list.dart';

class CollectList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _CollectState();

}

class _CollectState extends State<CollectList> {

  CollectArticleViewModel _viewModel = new CollectArticleViewModel();
  final int initPage = 0;
  List<HomeArticleEntity> _list = new List();

  @override
  void initState() {
    _viewModel.getCollectList(initPage);
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("我的收藏"),
        centerTitle: true,
      ),
      body: new StreamBuilder(
          stream: _viewModel.collectController,
          builder: (context, snap) {
            _list = snap.data != null ? snap.data : [];
            return new CommonArticleList(_list,
                _loadData,
                _clearData,
                false,
            );
          }
      ),
    );
  }

  _loadData(int currentPage) {
    _viewModel.getCollectList(currentPage);
  }

  _clearData() {
    _viewModel.clearList();
  }

}