import 'package:coin_dcx_assignment/style/Style.dart';
import 'package:coin_dcx_assignment/ui_classes/currency_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WelcomeScreenManageState();
  }
}

class WelcomeScreenManageState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WelcomeScreenState();
  }
}

class _WelcomeScreenState extends State<WelcomeScreenManageState>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => navigateToNextPage());
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
    Scaffold(
      backgroundColor: Colors.purple[200],
      body: Center(
        child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/coindcx_logo.png",
                  height: 400.0,
                  width: 400.0,
                ),
                Text(
                  "Welcome to CoinDCX Markets",
                  style: Style.welcomeText,
                )
              ],
            )

      ),
    );
  }

  void navigateToNextPage(){
    // thread delayed for 3 sec
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(context,
          PageTransition(
            child: CurrencyList(),
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 500),
          ));
    });
  }
}