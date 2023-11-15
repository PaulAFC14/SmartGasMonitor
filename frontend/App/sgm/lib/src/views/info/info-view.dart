// ignore_for_file: must_be_immutable

import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sgm/src/responsive/responsive-method.dart';
import 'package:sgm/src/widgets/menu.dart';

late double vw;
late double vh;
late double ratio;
late double vr;

class InfoView extends StatefulWidget {
  late BuildContext context;
  InfoView(this.context, {super.key}) {
    //Responsive method
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = (vh / ratio);
  }

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  late bool toogle;

  List<String> info = [
    'Cuando compre gas, asegúrese que los tanques se encuentren en buen estado. Deben ser entregados con maneral y pintados. Si estas condiciones no se cumplen, exija su cambio.',
    'Conserve su nota de compra. Con ella podrá realizar aclaraciones, reclamos y cambio del tanque en mal estado, o para presentar su queja por alguna otra irregularidad con la empresa o autoridad correspondiente.',
    'El repartidor deberá conectar los tanques en su domicilio ya que cuenta con la herramienta adecuada para ello. Recuerde: el tanque debe tener maneral para que lo pueda abrir o cerrar correctamente. Verifique que no existan fugas en su tanque o si recibe aplicando agua jabonosa en las conexiones a su domicilio. Si al abrir la válvula correspondiente el gas produce burbujas en alguna conexión o tubería, esta se encuentra averiada o mal conectada.',
    'Cuide y verifique el buen estado de la tubería de cobre y sus conexiones; no deben estar dobladas, trozadas, trasroscadas, ya que esto podría provocar una fuga. Cuando detecte alguna, comuníquese a la empresa que le vende el gas o a la Unidad Municipal de protección Civil y Bomberos para que se tomen las medidas correctivas de emergencia.',
    'Los tanques deben de ser colocados a una distancia mínima de 3 metros de flamas, interruptores y contactos eléctricos, ventanas, sótanos, motores eléctricos o de combustión interna. NO ENCIENDA FUEGO CERCA DE LOS TANQUES O INSTALACIONES DE GAS.',
    'Es conveniente que sus instalaciones, estufa, calefactor de agua y otros accesorios que utilicen gas , sean revisados periódica mente por un técnico especializado en Gas L.P. En caso fuga, un plomero experimentado debe reparar sus instalaciones. NUNCA INTENTE REPARAR LAS FUGAS USTED MISMO, NI CON PLOMEROS INEXPERTOS. NO ENCIENDA FUEGO CERCA DE LOS TANQUES O INSTALACIONES DE GAS.',
    'El calefactor de agua debe estar instalado en el exterior de su vivienda. Los gases que emiten son tóxicos, agotan el oxígeno y pueden causar la muerte.',
    'Sus tanques de gas deben estar a la intemperie, en pisos firmes y nivelados que no guarden humedad, de preferencia en áreas sombreadas, en lugares de fácil acceso, evitando que al cambiarlos se realicen maniobras peligrosas.',
    'Sus aparatos de consumo de Gas L.P. deben ser encendidos por gente responsable. Mantenga encendidos los pilotos de su estufa o calefactor de agua para evitar flamazos o quemaduras. Si sus aparatos no cuentan con piloto, siempre encienda primero el cerillo, acérquelo al quemador y después abra la llave del gas',
  ];

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
        index: 2,
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
            Container(
              width: 90 * vw,
              height: 150 * vr,
              child: Swiper(
                itemBuilder: (context, index) {
                  return Container(
                    width: 90 * vw,
                    height: 100 * vr,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 25 * vw),
                          height: 40 * vr,
                          child: Center(
                            child: Image.asset(
                              'assets/img/info/${index + 1}.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(height: 5 * vw),
                        Text(
                          info[index],
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 4 * vw,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).hintColor,
                            height: 2,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: info.length,
                scrollDirection: Axis.horizontal,
                pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.grey, // Color cuando no está activo
                    activeColor: Theme.of(context)
                        .primaryColor, // Color cuando está activo
                  ),
                ),
                control: SwiperControl(),
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
