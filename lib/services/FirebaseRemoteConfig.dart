import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfig {

  Future<String> getMyAdImage(int adNum) async {
    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();

      return remoteConfig.getString('myAdImage$adNum');
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      log("$exception");
      return null;
    } catch (exception) {
      log('Unable to fetch remote config. Cached or default values will be '
          'used');
      return null;
    }
  }

  Future<int> getMyAdNum() async {
    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();

      return remoteConfig.getInt('myAdNum');
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      log("$exception");
      return 0;
    } catch (exception) {
      log('Unable to fetch remote config. Cached or default values will be '
          'used');
      return 0;
    }
  }

  Future<String> getMyAdText(int adNum) async {
    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();

      return remoteConfig.getString('myAdText$adNum');
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      log("$exception");
      return null;
    } catch (exception) {
      log('Unable to fetch remote config. Cached or default values will be '
          'used');
      return null;
    }
  }

  Future<String> getMyLinkAd(int adNum) async {
    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();

      return remoteConfig.getString('myAdLink$adNum');
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      log("$exception");
      return null;
    } catch (exception) {
      log('Unable to fetch remote config. Cached or default values will be '
          'used');
      return null;
    }
  }

  Future<bool> showMyAd() async {
    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();

      return remoteConfig.getBool('showMyAd');
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      log("$exception");
      return null;
    } catch (exception) {
      log('Unable to fetch remote config. Cached or default values will be '
          'used');
      return null;
    }
  }

  Future<double> getVersion() async {
    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      remoteConfig.getString('lasted_version_app');

      return double.parse(remoteConfig
          .getString('lasted_version_app')
          .trim()
          .replaceAll(".", ""));
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      log("$exception");
      return null;
    } catch (exception) {
      log('Unable to fetch remote config. Cached or default values will be '
          'used');
      return null;
    }
  }
}
