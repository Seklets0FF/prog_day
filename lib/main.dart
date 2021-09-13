import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'toasts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: _getBody(),
    );
  }
}

_getBody() {
  String txt = '';
  Jiffy jiffy = Jiffy();

  int nowDay = jiffy.dayOfYear;
  bool holiday = false;

  if (nowDay == 256) {
    txt = 'Ура! С праздником! ^-^';
    holiday = true;
  } else if (nowDay < 256) {
    txt = 'Дней до праздника программистов: ${256 - nowDay}';
  } else if (jiffy.isLeapYear) {
    txt = 'Дней до праздника программистов: ${366 - nowDay + 256}';
  } else {
    txt = 'Дней до праздника программистов: ${365 - nowDay + 256}';
  }

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          txt,
          style: const TextStyle(fontSize: 25.0),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: holiday
              ? const Image(image: AssetImage('assets/img/256.gif'))
              : const Image(image: AssetImage('assets/img/!256.gif')),
        ),
        Text(
          holiday ? '' : 'Пока можно посмотреть YouTube:',
          style: const TextStyle(fontSize: 25.0),
        ),
        _getBtn(holiday),
      ],
    ),
  );
}

_getBtn(bool holiday) {
  Random rnd = Random();
  List<String> toasts = Toasts().toasts;

  if (!holiday) {
    return IconButton(
      iconSize: 50.0,
      icon: const FaIcon(
        FontAwesomeIcons.youtube,
        color: Colors.redAccent,
      ),
      onPressed: () => _openMyChannel(),
    );
  }

  return IconButton(
    iconSize: 50.0,
    icon: const FaIcon(
      FontAwesomeIcons.beer,
      color: Colors.yellow,
    ),
    onPressed: () => Get.snackbar('Тост!', toasts[rnd.nextInt(toasts.length)]),
  );
}

_openMyChannel() async {
  String myChannel = 'https://www.youtube.com/c/Sekletsoff';

  if (await canLaunch(myChannel)) {
    await launch(myChannel);
  }
}
