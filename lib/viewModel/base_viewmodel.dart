import 'package:rxdart/rxdart.dart';
import 'package:wanandroid/net/api/ApiRepository.dart';
import 'dart:async';

abstract class BaseViewModel{
  CompositeSubscription subscriptions;
  ApiRepository repository;
  StreamSubscription subscription;

  BaseViewModel(){
    repository = new ApiRepository();
    subscriptions = CompositeSubscription();
  }

  dispose(){
    subscriptions.clear();
  }

}