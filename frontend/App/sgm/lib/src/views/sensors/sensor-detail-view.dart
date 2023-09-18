// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sgm/src/responsive/responsive-method.dart';
import 'package:sgm/src/routes/routes.dart';
import 'package:sgm/src/views/sensors/sensors-list-view.dart';
import 'package:sgm/src/widgets/menu.dart';

late double vw;
late double vh;
late double ratio;
late double vr;

class SensorDetailView extends StatefulWidget {
  late BuildContext context;
  SensorDetailView(this.context, {super.key}) {
    //Responsive method
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = (vh / ratio);
  }

  @override
  State<SensorDetailView> createState() => _SensorDetailViewState();
}

class _SensorDetailViewState extends State<SensorDetailView> {
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
        index: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5 * vw),
        child: ListView(
          children: [
            SizedBox(height: 7.5 * vw),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Routes(context).goTo(SensorsListView(context)),
                  child: Container(
                    width: 8 * vw,
                    height: 8 * vr,
                    color: Colors.transparent,
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 8 * vw,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Cocina',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 4.5 * vw,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                SizedBox(width: 1 * vw),
                GestureDetector(
                  onTap: () => Routes(context).goTo(SensorsListView(context)),
                  child: Container(
                    width: 6 * vw,
                    height: 6 * vr,
                    color: Colors.transparent,
                    child: Icon(
                      Icons.edit,
                      size: 6 * vw,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1 * vw),
            Text(
              'Última lectura: 2023-09-09 20:28:32',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 4 * vw,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).disabledColor,
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
                    child: Image.asset('assets/img/temp.png'),
                  ),
                  SizedBox(width: 5 * vw),
                  Container(
                    width: 41 * vw,
                    height: 8 * vw,
                    child: Row(
                      children: [
                        Text(
                          'Temperatura',
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
                    width: 20 * vw,
                    height: 8 * vw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8 * vw),
                      color: Theme.of(context).dividerColor,
                    ),
                    child: Center(
                      child: Text(
                        '31 C°',
                        style: TextStyle(
                          fontSize: 4 * vw,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5 * vr),
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8 * vw,
                        height: 8 * vr,
                        child: Image.asset('assets/img/sensor-verde.png'),
                      ),
                      SizedBox(width: 5 * vw),
                      Container(
                        width: 66 * vw,
                        height: 8 * vw,
                        child: Row(
                          children: [
                            Text(
                              'Concentración',
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
                    ],
                  ),
                  SizedBox(height: 10 * vr),
                  Text(
                    '10',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10 * vw,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  SizedBox(height: 5 * vr),
                  Container(
                    width: 80 * vw,
                    height: 7.5 * vr,
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(7.5 * vr),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: (80 * vw) * (10 / 100),
                          height: 7.5 * vr,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(7.5 * vr),
                          ),
                        ),
                      ],
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
