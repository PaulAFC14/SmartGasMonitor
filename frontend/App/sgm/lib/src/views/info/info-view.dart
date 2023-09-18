// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sgm/src/responsive/responsive-method.dart';
import 'package:sgm/src/widgets/menu.dart';

late double vw;
late double vh;
late double ratio;
late double vr;

class InfoView extends StatefulWidget {
  late BuildContext context;
  InfoView(this.context, {super.key}) {
    //Responsive method
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = (vh / ratio);
  }

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      bottomNavigationBar: Menu(
        context,
        index: 2,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5 * vw),
        child: ListView(
          children: [
            SizedBox(height: 7.5 * vw),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 8 * vw,
                  height: 8 * vr,
                  color: Colors.transparent,
                ),
                Container(
                  width: 10 * vw,
                  height: 10 * vw,
                  child: Image.asset(
                    'assets/img/logo-sgm.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 8 * vw,
                  height: 8 * vr,
                ),
              ],
            ),
            SizedBox(height: 7.5 * vw),
            Text(
              'Preguntas frecuentes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 4.5 * vw,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 5 * vw),
            Container(
              width: 90 * vw,
              padding:
                  EdgeInsets.symmetric(horizontal: 5 * vw, vertical: 8.5 * vw),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 0.5 * vw,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8 * vw,
                    height: 8 * vr,
                    child: Image.asset('assets/img/actuador-verde.png'),
                  ),
                  SizedBox(width: 5 * vw),
                  Container(
                    width: 31 * vw,
                    height: 8 * vw,
                    child: Row(
                      children: [
                        Text(
                          'Estado',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 4 * vw,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5 * vw),
                  Container(
                    width: 30 * vw,
                    height: 8 * vw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8 * vw),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        'ABIERTO',
                        style: TextStyle(
                          fontSize: 4 * vw,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
