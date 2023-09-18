// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sgm/src/responsive/responsive-method.dart';
import 'package:sgm/src/routes/routes.dart';
import 'package:sgm/src/views/sensors/sensors-list-view.dart';

late double vw;
late double vh;
late double ratio;
late double vr;

class LoginView extends StatefulWidget {
  late BuildContext context;
  LoginView(this.context, {super.key}) {
    //Responsive method
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = (vh / ratio);
  }

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
            SizedBox(height: 15 * vr),
            Column(
              children: [
                Container(
                  width: 33 * vw,
                  height: 33 * vw,
                  child: Image.asset(
                    'assets/img/logo-sgm.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10 * vr),
            Text(
              'Inicio de sesión',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 4.5 * vw,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 10 * vr),
            Text(
              'Correo electrónico',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 4 * vw,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 2.5 * vr),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
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
                hintText: 'correo@example.com', //Texto predefinido
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
            SizedBox(height: 4 * vr),
            GestureDetector(
              onTap: () => Routes(context), //Enviar a vista de contraseña
              child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 50 * vw),
                child: Text(
                  'Olvidé mi contraseña',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 4 * vw,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).indicatorColor,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
            SizedBox(height: 15 * vr),
            GestureDetector(
              onTap: () => Routes(context).goTo(SensorsListView(context)),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5 * vw),
                height: 15 * vr,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15 * vr),
                ),
                child: Center(
                  child: Text(
                    'Ingresar',
                    style: TextStyle(
                      fontSize: 4 * vw,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).canvasColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5 * vr),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5 * vw),
                height: 15 * vr,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15 * vr),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 1 * vw)),
                child: Center(
                  child: Text(
                    'Registrarse',
                    style: TextStyle(
                      fontSize: 4 * vw,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor,
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
