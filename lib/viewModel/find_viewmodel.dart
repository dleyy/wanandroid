import 'dart:async';

import 'base_viewmodel.dart';
import 'package:wanandroid/entity/find_entity.dart';
import 'package:wanandroid/net/api/ApiRepository.dart';


class FindViewModel extends BaseViewModel {

  StreamController<List<FindEntity>> _findController;
  List<FindEntity> _findData;

  Stream<List<FindEntity>> get findLists => _findController.stream;

  FindViewModel() {
    _findData = [];
    _findController = new StreamController<List<FindEntity>>();
  }

  //获取分类信息
  getFindData() async {
    StreamSubscription subscription =
    ApiRepository().getHomeFind().listen((lists) {
      if (lists != null) _findData.addAll(lists);
      _findController.sink.add(_findData);
    });
    subscriptions.add(subscription);
  }

  @override
  dispose() {
    super.dispose();
    _findData.clear();
  }

  cleanFindData(){
    _findData.clear();
  }
}