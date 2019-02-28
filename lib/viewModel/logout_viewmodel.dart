import 'base_viewmodel.dart';

class LogoutViewModel extends BaseViewModel{

  logout(){
    subscription = repository.doLogout().listen((result){
      return result;
    });
    subscriptions.add(subscription);
  }


}