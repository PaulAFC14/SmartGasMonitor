// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:sgm/src/%20models/sensor/sensor.dart';
import 'package:sgm/src/responsive/responsive-method.dart';
import 'package:sgm/src/routes/routes.dart';
import 'package:sgm/src/views/sensors/sensors-list-view.dart';
import 'package:sgm/src/widgets/menu.dart';

late double vw;
late double vh;
late double ratio;
late double vr;
late int id;

class SensorDetailView extends StatefulWidget {
  late BuildContext context;
  SensorDetailView(this.context, {super.key, required int sensor_id}) {
    //Responsive method
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = (vh / ratio);

    id = sensor_id;
  }

  @override
  State<SensorDetailView> createState() => _SensorDetailViewState();
}

class _SensorDetailViewState extends State<SensorDetailView> {
  late Future<Sensor> data;
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = Sensor().getById(id);
    timer = Timer.periodic(Duration(seconds: 4), (Timer t) {
      setState(() {
        data = Sensor().getById(id);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
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
        child: FutureBuilder<Sensor>(
          future: data,
          builder: (context, AsyncSnapshot<Sensor> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('Cargando...'),
              );
            }
            Sensor sensor = snapshot.data!;
            return ListView(
              children: [
                SizedBox(height: 7.5 * vw),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          Routes(context).goTo(SensorsListView(context)),
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
                      sensor.getName,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 4.5 * vw,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    SizedBox(width: 1 * vw),
                    GestureDetector(
                      onTap: () => Routes(context),
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
                  'Última lectura: ${sensor.updated_at}',
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
                            '${sensor.getTemperature} C°',
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
                        sensor.getGas.toString(),
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
                              width: (79 * vw) * (sensor.getGas / 100),
                              height: 7.5 * vr,
                              decoration: BoxDecoration(
                                color: sensor.getColor(context),
                                borderRadius: BorderRadius.circular(7.5 * vr),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 7.5 * vr),
                (sensor.getGas < 61)
                    ? Container()
                    : GestureDetector(
                        onTap: () async {
                          const number = '911'; //set the number here

                          await FlutterPhoneDirectCaller.callNumber(number);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5 * vw),
                          height: 15 * vr,
                          decoration: BoxDecoration(
                            color: Theme.of(context).secondaryHeaderColor,
                            borderRadius: BorderRadius.circular(15 * vr),
                          ),
                          child: Center(
                            child: Text(
                              'Llamar al 911',
                              style: TextStyle(
                                fontSize: 4 * vw,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).canvasColor,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
