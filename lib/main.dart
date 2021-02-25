import 'package:admob_flutter/admob_flutter.dart';
import 'package:calcular_preco_venda/Router.dart';
import 'package:calcular_preco_venda/screens/HomePageScreen.dart';
import 'package:calcular_preco_venda/screens/LoadingScreen.dart';
import 'package:calcular_preco_venda/services/nosql/Init.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// Import the firebase_core plugin

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize without device test ids. 
  // testDeviceIds: ["ca-app-pub-0943131909791545~3866398254"]
  Admob.initialize();
  await Admob.requestTrackingAuthorization();
  await FirebaseAdMob.instance.initialize(appId: "ca-app-pub-0943131909791545~3866398254");
  runApp(App());
}

class App extends StatelessWidget { 
  // Create the initilization Future outside of `build`:
  final Future _init =  Init.initialize();
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _init,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return somethingWrong();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return homePage();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return LoadingScreen();
      },
    );
  }

  Widget homePage() {
    return new MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      title: 'Markup home',
      debugShowCheckedModeBanner: false,
      home: HomePageScreen(),
      onGenerateRoute: routes(),
    );
  }

  Widget somethingWrong() {
    return MaterialApp(
      title: 'Calcular preço de venda - Markup',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
              "Ocorreu um erro no carregamento, tente fechar e abrir o aplicativo novamente :("),
        ),
      ),
    );
  }
}
