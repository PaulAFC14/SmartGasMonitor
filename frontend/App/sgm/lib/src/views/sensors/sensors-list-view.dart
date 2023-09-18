// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sgm/src/responsive/responsive-method.dart';
import 'package:sgm/src/routes/routes.dart';
import 'package:sgm/src/views/sensors/sensor-detail-view.dart';
import 'package:sgm/src/widgets/menu.dart';

late double vw;
late double vh;
late double ratio;
late double vr;

class SensorsListView extends StatefulWidget {
  late BuildContext context;
  SensorsListView(this.context, {super.key}) {
    //Responsive method
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = (vh / ratio);
  }

  @override
  State<SensorsListView> createState() => _SensorsListViewState();
}

class _SensorsListViewState extends State<SensorsListView> {
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
      floatingActionButton: GestureDetector(
        onTap: () => Routes(context),
        child: Container(
          width: 50 * vw,
          height: 15 * vr,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(
              15 * vr,
            ),
          ),
          child: Center(
            child: Text(
              'Agregar sensor',
              style: TextStyle(
                fontSize: 4 * vw,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).canvasColor,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5 * vw),
        child: ListView(
          children: [
            SizedBox(height: 7.5 * vw),
            Column(
              children: [
                Container(
                  width: 10 * vw,
                  height: 10 * vw,
                  child: Image.asset(
                    'assets/img/logo-sgm.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 7.5 * vw),
            Text(
              'Mis sensores',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 4 * vw,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 2.5 * vw),
            GestureDetector(
              onTap: () => Routes(context).goTo(SensorDetailView(context)),
              child: Container(
                width: 90 * vw,
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * vw, vertical: 8.5 * vw),
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
                      child: Image.asset('assets/img/sensor-verde.png'),
                    ),
                    SizedBox(width: 5 * vw),
                    Container(
                      width: 41 * vw,
                      height: 8 * vw,
                      child: Row(
                        children: [
                          Text(
                            'Cocina',
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
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          '10',
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
            ),
          ],
        ),
      ),
    );
  }
}
