import 'dart:developer';

import 'package:calcular_preco_venda/services/FirebaseRemoteConfig.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CheckForUpdate {
  final String APP_STORE_URL =
      "https://play.google.com/store/apps/details?id=com.wb.tracun.markup";

  Future<void> hasNewVersion(BuildContext context) async {
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion =
        double.parse(info.version.trim().replaceAll(".", ""));

    final newVersion = await FirebaseRemoteConfig().getVersion();

    log("newVersion: $newVersion - currentVersion: $currentVersion");

    if (newVersion != null && newVersion > currentVersion) {
      Messages().showYesNoDialog(
          context,
          "Nova atualização disponível",
          "Há uma nova versão disponível, atualize assim que possível.",
          null, () {
        // Atualizar
        _launchURL(APP_STORE_URL);
        Navigator.pop(context);
      }, () {
        // Mais tarde
        Navigator.pop(context);
      }, yesButtonText: "Atualizar agora", noButtonText: "Mais tarde");
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
