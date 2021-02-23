import 'dart:developer';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

class AdmobWidget {
  AdmobBanner getBottomBanner() {
    return AdmobBanner(
      adUnitId: "ca-app-pub-0943131909791545/6358352079",
      adSize: AdmobBannerSize.BANNER,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        handleEvent(event, args, 'Banner');
      },
    );
  }

  AdmobBanner getBanner(AdmobBannerSize size) {
    return AdmobBanner(
      adUnitId: "ca-app-pub-0943131909791545/6358352079",
      adSize: size,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        handleEvent(event, args, 'Banner');
      },
    );
  }

  AdmobBanner getSmartBanner(BuildContext context) {
    return AdmobBanner(
      adUnitId: "ca-app-pub-0943131909791545/6358352079",
      adSize: AdmobBannerSize.SMART_BANNER(context),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        handleEvent(event, args, 'Banner');
      },
    );
  }

  AdmobBanner getMediumBanner() {
    return AdmobBanner(
      adUnitId: "ca-app-pub-0943131909791545/6358352079",
      adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        handleEvent(event, args, 'Banner');
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
