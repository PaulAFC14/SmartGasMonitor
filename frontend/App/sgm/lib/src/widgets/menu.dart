// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sgm/src/responsive/responsive-method.dart';
import 'package:sgm/src/routes/routes.dart';

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
            onTap: () => Routes(context),
            child: Container(
              width: 20 * vw,
              height: 20 * vr,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
