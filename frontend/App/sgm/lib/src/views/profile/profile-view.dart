// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sgm/src/responsive/responsive-method.dart';
import 'package:sgm/src/routes/routes.dart';
import 'package:sgm/src/views/auth/login-view.dart';
import 'package:sgm/src/widgets/menu.dart';

late double vw;
late double vh;
late double ratio;
late double vr;

class ProfileView extends StatefulWidget {
  late BuildContext context;
  ProfileView(this.context, {super.key}) {
    //Responsive method
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = (vh / ratio);
  }

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late bool toogle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toogle = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      bottomNavigationBar: Menu(
        context,
        index: 3,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5 * vw),
        child: ListView(
          children: [
            SizedBox(height: 7.5 * vw),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 8 * vw,
                  height: 8 * vr,
                  color: Colors.transparent,
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
            Text(
              'Datos de Usuario',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 4.5 * vw,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 5 * vw),
            Container(
              width: 90 * vw,
              padding:
                  EdgeInsets.symmetric(horizontal: 5 * vw, vertical: 5 * vw),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Nombre: ',
                        style: TextStyle(
                          fontSize: 4 * vw,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      Text(
                        'Paul Antonio',
                        style: TextStyle(
                          fontSize: 4 * vw,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5 * vr),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Apellidos: ',
                        style: TextStyle(
                          fontSize: 4 * vw,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      Text(
                        'Flores Castro',
                        style: TextStyle(
                          fontSize: 4 * vw,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5 * vr),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Correo: ',
                        style: TextStyle(
                          fontSize: 4 * vw,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      Text(
                        'correo@example.com',
                        style: TextStyle(
                          fontSize: 4 * vw,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5 * vr),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Teléfono: ',
                        style: TextStyle(
                          fontSize: 4 * vw,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      Text(
                        '612 123 4567',
                        style: TextStyle(
                          fontSize: 4 * vw,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5 * vr),
            GestureDetector(
              onTap: () => Routes(context).goTo(LoginView(context)),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 8 * vw,
                      child: Row(
                        children: [
                          Text(
                            'Cerrar sesión',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 4 * vw,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 8 * vw,
                      height: 8 * vw,
                      color: Colors.transparent,
                      child: Icon(
                        Iconsax.logout_1,
                        size: 8 * vw,
                        color: Theme.of(context).hintColor,
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

  Widget card(bool show) {
    if (show) {
      return GestureDetector(
        onTap: () {
          setState(() {
            toogle = !toogle;
          });
        },
        child: Container(
          width: 90 * vw,
          padding: EdgeInsets.symmetric(horizontal: 5 * vw, vertical: 5 * vw),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 8 * vw,
                    child: Row(
                      children: [
                        Text(
                          '¿Cómo actuar en caso de fuga?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 4 * vw,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 8 * vw,
                    height: 8 * vw,
                    color: Colors.transparent,
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: 8 * vw,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.5 * vr),
              Container(
                width: 80 * vw,
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 3.5 * vw,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).indicatorColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            toogle = !toogle;
          });
        },
        child: Container(
          width: 90 * vw,
          padding: EdgeInsets.symmetric(horizontal: 5 * vw, vertical: 8.5 * vw),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 0.5 * vw,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 8 * vw,
                child: Row(
                  children: [
                    Text(
                      '¿Cómo actuar en caso de fuga?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 4 * vw,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 8 * vw,
                height: 8 * vw,
                color: Colors.transparent,
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 8 * vw,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
