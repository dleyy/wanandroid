import 'base_viewmodel.dart';
import 'package:wanandroid/entity/login_entity.dart';

class RegisterViewModel extends BaseViewModel{

  doRegister(String userName,String password,
      successCallback,errorCallback){
    subscription = repository.doRegister(userName, password)
        .listen((value){
      if(value is UserEntity){
        successCallback(value);
      }else{
        errorCallback(value as String);
      }
    });
    subscriptions.add(subscription);
  }
}