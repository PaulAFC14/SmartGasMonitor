// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sgm/src/responsive/responsive-method.dart';
import 'package:sgm/src/routes/routes.dart';
import 'package:sgm/src/views/auth/login-view.dart';
import 'package:sgm/src/views/auth/recoverPassword/recoverPassword2-view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sgm/src/views/loadingScreens/sendingCredentials-view.dart';

late double vw;
late double vh;
late double ratio;
late double vr;

class BondingSensor extends StatefulWidget {
  late BuildContext context;
  BondingSensor(this.context, {super.key}) {
    //Responsive method
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = (vh / ratio);
  }

  @override
  State<BondingSensor> createState() => _BondingSensor();
}

class _BondingSensor extends State<BondingSensor> {
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
                  onTap: () => Routes(context).goTo(LoginView(context)),
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
                  'Vincular sensor',
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
              'Ingresa las credenciales de tu conexión a Wifi para que el sensor pueda conectarse a tu red.',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 4 * vw,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 10 * vr),
            Text(
              'Red',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 4 * vw,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 2.5 * vr),
            TextFormField(
              keyboardType: TextInputType.text,
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
                hintText: 'MiRed', //Texto predefinido
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

            SizedBox(height: 5 * vr),
            Text(
              'Contraseña',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 4 * vw,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 2.5 * vr),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              obscureText: invisible,

              //Inicio decoración
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      invisible = !invisible;
                    });
                  },
                  icon: Icon((invisible) ? Iconsax.eye : Iconsax.eye_slash,
                      color: Theme.of(context).indicatorColor),
                ),
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
                hintText: '********', //Texto predefinido
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
              onTap: () => Routes(context).goTo(SendingCredentials(context)),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5 * vw),
                height: 15 * vr,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15 * vr),
                ),
                child: Center(
                  child: Text(
                    'Enviar',
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
