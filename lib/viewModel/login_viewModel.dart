import 'base_viewmodel.dart';

class LoginViewModel extends BaseViewModel {

  @override
  dispose() {
    return super.dispose();
  }

  doLogin(String userName, String password,Function callBackFunction) {
    subscription = repository.doLogin(userName, password)
        .listen((value) {
        callBackFunction(value);
    });
    subscriptions.add(subscription);
  }
}