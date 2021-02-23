import 'dart:developer';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:calcular_preco_venda/utils/ScreenNavigator.dart';
import 'package:calcular_preco_venda/widgets/AdmobWidget.dart';
import 'package:calcular_preco_venda/widgets/NavDrawer.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePageScreen extends StatefulWidget {
  createState() => _ProductListAdmState();
}

class _ProductListAdmState extends State<HomePageScreen>
    with SingleTickerProviderStateMixin {
  String loadingText;

  final loginPageRoute = "/";

  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
          child: Container(
            alignment: Alignment.center,
            child: 
          AdmobWidget().getMediumBanner(),),
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
