import 'dart:developer';
import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:calcular_preco_venda/services/FirebaseRemoteConfig.dart';
import 'package:calcular_preco_venda/utils/CheckForUpdate.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:calcular_preco_venda/utils/ScreenNavigator.dart';
import 'package:calcular_preco_venda/widgets/AdmobWidget.dart';
import 'package:calcular_preco_venda/widgets/NavDrawer.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageScreen extends StatefulWidget {
  createState() => _ProductListAdmState();
}

class _ProductListAdmState extends State<HomePageScreen>
    with SingleTickerProviderStateMixin {
  String loadingText;
  AdmobReward rewardAd;
  final loginPageRoute = "/";

  Animation<double> _animation;
  AnimationController _animationController;

  int myAdNum;
  String myAdImage;
  String myAdText;
  String myAdUrl;

  bool showMyAd = false;

  getMyAdData() async {
    myAdNum = await FirebaseRemoteConfig().getMyAdNum();

    myAdImage = await FirebaseRemoteConfig().getMyAdImage(myAdNum);
    myAdText = await FirebaseRemoteConfig().getMyAdText(myAdNum);
    myAdUrl = await FirebaseRemoteConfig().getMyLinkAd(myAdNum);
    showMyAd = await FirebaseRemoteConfig().showMyAd();

    print("showMyAd: $showMyAd");

    showMyAd == null ? showMyAd = false : null;

    setState(() {});
    checkVersion();
  }

  checkVersion() async => await CheckForUpdate().hasNewVersion(context);

  @override
  void initState() {
    getMyAdData();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    // rewardAd = AdmobWidget().getRewardBanner(rewardAd);
    // rewardAd.load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print("width: $width");
    return Scaffold(
      drawer: NavDrawer(),
      appBar: new AppBar(
        backgroundColor: MyColors().appBarColor(),
        automaticallyImplyLeading: true,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text("Markup Home"),
        ),
        // actions: [
        //   IconButton(
        //       icon: Icon(
        //         Icons.help,
        //         color: Colors.white,
        //         size: 28,
        //       ),
        //       onPressed: () {}),
        //   IconButton(
        //       icon: Icon(
        //         Icons.refresh,
        //         color: Colors.white,
        //         size: 28,
        //       ),
        //       onPressed: () {
        //         productBloc.getAll();
        //       }),
        // ],
      ),
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
            child: Column(
              children: [
                // FlatButton(
                //     height: 40,
                //     color: Colors.green[100],
                //     child: Center(
                //       child: Text(
                //         'Ajude a manter o aplicativo gratuito, assista a um vídeo :)\nClique aqui',
                //         style: TextStyle(color: Colors.black, fontSize: 12),
                //       ),
                //     ),
                //     onPressed: () async {
                //       if (await rewardAd.isLoaded) {
                //         log("SHOW");
                //         rewardAd.show();
                //       } else {
                //         log("Erro");
                //       }
                //     },
                //   ),
                showMyAd
                    ? FlatButton(
                        child: Card(
                          shadowColor: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width * 0.8,
                              height: height * 0.5,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FadeInImage.assetNetwork(
                                    placeholder: "assets/icons/loading.jpg",
                                    image: myAdImage,
                                    width: width*0.5,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    myAdText,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 18.0),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FlatButton(
                                    child: Text(
                                      "$myAdUrl",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20.0),
                                    ),
                                    onPressed: () {
                                      launch(myAdUrl);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          launch(myAdUrl);
                        },
                      )
                    : Text(""),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  child: AdmobWidget().getMediumBanner(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionBubble(
        backGroundColor: MyColors().appBarColor(),
        // Menu items
        items: <Bubble>[
          // Floating action menu item
          Bubble(
            title: "Produto Simples",
            iconColor: Colors.white,
            bubbleColor: MyColors().buttonColor(),
            icon: Icons.add,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              ScreenNavigator().productListScreen(context);
              _animationController.reverse();
            },
          ),
          // Floating action menu item
          Bubble(
            title: "Produto Completo",
            iconColor: Colors.white,
            bubbleColor: MyColors().buttonColor(),
            icon: Icons.add,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              ScreenNavigator().productComListScreen(context);
              _animationController.reverse();
            },
          ),
          // Fechar
          Bubble(
            title: "Fechar",
            iconColor: Colors.white,
            bubbleColor: MyColors().buttonColor(),
            icon: Icons.close,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),
        ],
        // animation controller
        animation: _animation,
        // On pressed change animation state
        onPress: _animationController.isCompleted
            ? _animationController.reverse
            : _animationController.forward,
        // Floating Action button Icon color
        iconColor: Colors.blue,
        // Flaoting Action button Icon
        animatedIconData: AnimatedIcons.menu_home,
      ),
      // bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
