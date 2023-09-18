// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sgm/src/responsive/responsive-method.dart';

late double vw;
late double vh;
late double ratio;
late double vr;

class ConnectingActuator extends StatefulWidget {
  late BuildContext context;
  ConnectingActuator(this.context, {super.key}) {
    //Responsive method
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = (vh / ratio);
  }

  @override
  State<ConnectingActuator> createState() => _ConnectingActuator();
}

class _ConnectingActuator extends State<ConnectingActuator> {
  late bool invisible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    invisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 34 * vw),
        child: ListView(
          children: [
            SizedBox(height: 70 * vw),
            Container(
              width: 33 * vw,
              height: 33 * vw,
              child: Image.asset(
                'assets/img/logo-sgm.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5 * vw),
            Text(
              'Conectandose a actuador...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 4.5 * vw,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
