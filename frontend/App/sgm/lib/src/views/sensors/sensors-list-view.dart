// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sgm/src/responsive/responsive-method.dart';
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
      body: ListView(),
    );
  }
}
