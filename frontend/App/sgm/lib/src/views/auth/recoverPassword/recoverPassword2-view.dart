// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sgm/src/responsive/responsive-method.dart';
import 'package:sgm/src/routes/routes.dart';
import 'package:sgm/src/views/auth/recoverPassword/recoverPassword1-view.dart';
import 'package:sgm/src/views/auth/recoverPassword/recoverPassword3-view.dart';

late double vw;
late double vh;
late double ratio;
late double vr;

class RecoverPasswordView2 extends StatefulWidget {
  late BuildContext context;
  RecoverPasswordView2(this.context, {super.key}) {
    //Responsive method
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = (vh / ratio);
  }

  @override
  State<RecoverPasswordView2> createState() => _RecoverPasswordView2();
}

class _RecoverPasswordView2 extends State<RecoverPasswordView2> {
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
        padding: EdgeInsets.symmetric(horizontal: 5 * vw),
        child: ListView(
          children: [
            SizedBox(height: 2.5 * vr),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Routes(context).goTo(RecoverPasswordView1(context)),
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
                Text(
                  'Recuperar contraseña',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 4.5 * vw,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                Container(
                  width: 8 * vw,
                  height: 8 * vr,
                ),
              ],
            ),
            
            SizedBox(height: 10 * vr),
            Text(
              'Código de verificación',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 4 * vw,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 2.5 * vr),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              //Inicio decoración
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 0.75 * vw)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 0.75 * vw)),
                hintText: '123456', //Texto predefinido
                hintStyle: TextStyle(
                  fontSize: 4 * vw,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).indicatorColor,
                ),
              ),
              cursorColor: Theme.of(context).hintColor,
              style: TextStyle(
                fontSize: 4 * vw,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
              ),
              //Fin decoración
            ),
            SizedBox(height: 10 * vr),
            GestureDetector(
              onTap: () => Routes(context).goTo(RecoverPasswordView3(context)),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5 * vw),
                height: 15 * vr,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15 * vr),
                ),
                child: Center(
                  child: Text(
                    'Verificar',
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
        ),
      ),
    );
  }
}