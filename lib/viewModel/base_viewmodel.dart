import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel{
  CompositeSubscription subscriptions = CompositeSubscription();

  dispose(){
    subscriptions.clear();
  }

}