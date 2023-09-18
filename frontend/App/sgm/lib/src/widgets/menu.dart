// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sgm/src/responsive/responsive-method.dart';
import 'package:sgm/src/routes/routes.dart';
import 'package:sgm/src/views/actuator/actuator-detail-view.dart';
import 'package:sgm/src/views/info/info-view.dart';
import 'package:sgm/src/views/sensors/sensors-list-view.dart';

late double vw;
late double vh;
late double ratio;
late double vr;
late int page;

class Menu extends StatefulWidget {
  late BuildContext context;
  Menu(this.context, {super.key, required int index}) {
    //Responsive method
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = (vh / ratio);

    page = index;
  }

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 20 * vr,
      padding: EdgeInsets.symmetric(horizontal: 5 * vw),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            offset: Offset(0, -4),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Routes(context).goTo(SensorsListView(context)),
            child: Container(
              width: 20 * vw,
              height: 20 * vr,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 6 * vw,
                    height: 6 * vr,
                    child: (page == 0)
                        ? Image.asset('assets/img/sensor-verde.png')
                        : Image.asset('assets/img/sensor-gris.png'),
                  ),
                  SizedBox(height: 0.5 * vr),
                  Text(
                    'Sensores',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 2.5 * vw,
                      fontWeight: FontWeight.w400,
                      color: (page == 0)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Routes(context).goTo(ActuatorDetailView(context)),
            child: Container(
              width: 20 * vw,
              height: 20 * vr,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 6 * vw,
                    height: 6 * vr,
                    child: (page == 1)
                        ? Image.asset('assets/img/actuador-verde.png')
                        : Image.asset('assets/img/actuador-gris.png'),
                  ),
                  SizedBox(height: 0.5 * vr),
                  Text(
                    'Actuador',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 2.5 * vw,
                      fontWeight: FontWeight.w400,
                      color: (page == 1)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Routes(context).goTo(InfoView(context)),
            child: Container(
              width: 20 * vw,
              height: 20 * vr,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.clipboard_text,
                    size: 6 * vw,
                    color: (page == 2)
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).unselectedWidgetColor,
                  ),
                  SizedBox(height: 0.5 * vr),
                  Text(
                    'Información',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 2.5 * vw,
                      fontWeight: FontWeight.w400,
                      color: (page == 2)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Routes(context),
            child: Container(
              width: 20 * vw,
              height: 20 * vr,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.profile_circle,
                    size: 6 * vw,
                    color: (page == 3)
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).unselectedWidgetColor,
                  ),
                  SizedBox(height: 0.5 * vr),
                  Text(
                    'Perfil',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 2.5 * vw,
                      fontWeight: FontWeight.w400,
                      color: (page == 3)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
