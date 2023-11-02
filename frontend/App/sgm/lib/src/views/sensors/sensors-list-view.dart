// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sgm/src/%20models/sensor/sensor.dart';
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
  late Future<List<Sensor>> data;
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = Sensor().getAll();
    timer = Timer.periodic(Duration(seconds: 4), (Timer t) {
      setState(() {
        data = Sensor().getAll();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mis sensores',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 4 * vw,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      data = Sensor().getAll();
                    });
                  },
                  child: Container(
                    width: 7 * vw,
                    height: 7 * vr,
                    child: Center(
                      child: Icon(
                        Icons.refresh_rounded,
                        size: 7 * vw,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 2.5 * vw),
            FutureBuilder<List<Sensor>>(
              future: data,
              builder: (context, AsyncSnapshot<List<Sensor>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text('Cargando...'),
                  );
                }
                List<Sensor> sensors = snapshot.data!;
                if (sensors.isEmpty) {
                  return Center(
                    child: Text('Vacio'),
                  );
                }
                return Container(
                  height: (30 * vr) * sensors.length,
                  child: ListView.builder(
                    itemCount:
                        sensors.length, // Número de elementos en la lista
                    itemBuilder: (context, index) {
                      Sensor sensor = sensors[index];
                      return GestureDetector(
                        onTap: () => Routes(context).goTo(
                          SensorDetailView(
                            context,
                            sensor_id: sensor.getId,
                          ),
                        ),
                        child: Container(
                          height: 25 * vr,
                          padding: EdgeInsets.symmetric(horizontal: 5 * vw),
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
                                child:
                                    Image.asset('assets/img/sensor-verde.png'),
                              ),
                              SizedBox(width: 5 * vw),
                              Container(
                                width: 41 * vw,
                                height: 8 * vw,
                                child: Row(
                                  children: [
                                    Text(
                                      sensor.getName,
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
                                  color: sensor.getColor(context),
                                ),
                                child: Center(
                                  child: Text(
                                    sensor.getGas.toString(),
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
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
