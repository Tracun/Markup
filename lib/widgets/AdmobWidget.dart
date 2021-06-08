import 'dart:developer';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';

class AdmobWidget {
  String idBloco = "ca-app-pub-0943131909791545/6552931294";
  String idBlocoReward = "ca-app-pub-0943131909791545/5302691083";//"ca-app-pub-3940256099942544/5224354917";

  AdmobBanner getBottomBanner() {
    return AdmobBanner(
      adUnitId: idBloco,
      adSize: AdmobBannerSize.BANNER,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        handleEvent(event, args, 'Banner');
      },
    );
  }

  AdmobBanner getBanner(AdmobBannerSize size) {
    return AdmobBanner(
      adUnitId: idBloco,
      adSize: size,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        handleEvent(event, args, 'Banner');
      },
    );
  }

  AdmobBanner getSmartBanner(BuildContext context) {
    return AdmobBanner(
      adUnitId: idBloco,
      adSize: AdmobBannerSize.SMART_BANNER(context),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        handleEvent(event, args, 'Banner');
      },
    );
  }

  AdmobBanner getMediumBanner() {
    return AdmobBanner(
      adUnitId: idBloco,
      adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        handleEvent(event, args, 'Banner');
      },
    );
  }


  AdmobReward getRewardBanner(AdmobReward rewardAd) {
    return AdmobReward(
      adUnitId: idBlocoReward,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        handleEvent(event, args, 'Reward');
      },
    );
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        log('Novo $adType Ad carregado!');
        break;
      case AdmobAdEvent.opened:
        log('Admob $adType Ad aberto!');
        break;
      case AdmobAdEvent.closed:
        log('Admob $adType Ad fechado!');
        break;
      case AdmobAdEvent.failedToLoad:
        log('Admob $adType falhou ao carregar. :(');
        break;
      default:
    }
  }
}
