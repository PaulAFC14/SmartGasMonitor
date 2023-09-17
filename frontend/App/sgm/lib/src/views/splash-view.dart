// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sgm/src/responsive/responsive-method.dart';
import 'package:sgm/src/routes/routes.dart';
import 'package:sgm/src/views/auth/login-view.dart';

late double vw;
late double vh;
late double ratio;
late double vr;

class SplashView extends StatefulWidget {
  late BuildContext context;
  SplashView(this.context, {super.key}){
    //Responsive method
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = (vh / ratio);

  }

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) => Routes(context).goTo(LoginView(context)));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Center(
        child: Container(
          width: 33*vw,
          height: 33*vw,
          child: Image.asset(
            'assets/img/logo-sgm.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}