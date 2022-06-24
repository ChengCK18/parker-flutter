import 'package:flutter/material.dart';
import 'package:parker/login_page.dart';
import 'package:parker/personal_vehicle_reg_field.dart';
import 'package:parker/target_vehicle_notify_field.dart';
import 'package:parker/personal_vehicle_stats_but.dart';
import 'package:parker/target_vehicle_notify_but.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: const TextTheme(
            bodyText1: TextStyle(), //TBD
            bodyText2: TextStyle(), //TBD
          ).apply(
            bodyColor: Colors.white,
            displayColor: Colors.blue,
          ),
          scaffoldBackgroundColor: const Color(0xff10002b)),
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String vecPlateNum = "None";

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF240046),
        title: Text(widget.title,
            style:
                const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.all(1),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[Text('Personal (Online)')],
                        ),
                      ])),
            ),
            const Expanded(flex: 2, child: PersonalVehicleStatsBut()),
            const Expanded(flex: 2, child: PersonalVehicleRegField()),
            const SizedBox(height: 10),
            Expanded(
                flex: 1,
                child: Container(
                    margin:
                        const EdgeInsets.only(left: 25.0, right: 25.0, top: 0),
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.cyan, width: 2))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.only(top: 0),
                                  child: const Text('Notify Target Vehicle'))
                            ],
                          ),
                        ]))),
            const Expanded(flex: 2, child: TargetVehicleNotifyBut()),
            const Expanded(flex: 2, child: TargetVehicleNotifyField())
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
