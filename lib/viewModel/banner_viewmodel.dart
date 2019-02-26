import 'base_viewmodel.dart';


class BannerViewModel extends BaseViewModel {

  //完成后回调.
  Function onBannerLoadSuccess;

  BannerViewModel(this.onBannerLoadSuccess);

  @override
  dispose() {
    return super.dispose();
  }

  getBanners() {
    subscription = repository.getBanner()
        .listen((value) {
      if (onBannerLoadSuccess != null) {
        onBannerLoadSuccess(value);
      }
    });
    subscriptions.add(subscription);
  }

}