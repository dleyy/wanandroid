import 'dart:async';

import 'base_viewmodel.dart';
import 'package:wanandroid/net/api/ApiRepository.dart';


class BannerViewModel extends BaseViewModel{

  //完成后回调.
  Function onBannerLoadSuccess;

  BannerViewModel(this.onBannerLoadSuccess);

  @override
  dispose() {
    return super.dispose();
  }

  getBanners() {
    StreamSubscription subscription = ApiRepository().getBanner()
    .listen((value){
      if(onBannerLoadSuccess!=null){
        onBannerLoadSuccess(value);
      }
    });
    subscriptions.add(subscription);
  }

}