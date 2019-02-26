import 'dart:async';
import 'base_viewmodel.dart';
import 'package:wanandroid/entity/hot_key_entity.dart';

class HotKeyViewModel extends BaseViewModel {

  List<HotKeyEntity> _list;
  StreamController<List<HotKeyEntity>> _hotController;

  Stream<List<HotKeyEntity>> get hotStream=>_hotController.stream;

  HotKeyViewModel() {
    _hotController = new StreamController();
    _list = new List();
  }


  getHotKey() {
    subscription = repository.getHotKey().listen((value) {
      if (value != null) {
        _list.addAll(value);
      }
      _hotController.sink.add(_list);
    });
    subscriptions.add(subscription);
  }

  clear() {
    _list.clear();
  }

  @override
  dispose() {
    _hotController.close();
    return super.dispose();
  }
}