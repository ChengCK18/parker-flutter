import 'package:flutter/material.dart';
import 'package:parker/personal_vehicle_reg_field.dart';
import 'package:parker/target_vehicle_notify_field.dart';
import 'package:parker/personal_vehicle_stats_but.dart';
import 'package:parker/target_vehicle_notify_but.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
      home: const MyHomePage(title: 'App Name'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF240046),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[Text('Personal (Online)')],
                          ),
                        ]))),
            Expanded(flex: 2, child: PersonalVehicleStatsBut()),
            Expanded(flex: 1, child: PersonalVehicleRegField()),
            Expanded(
                flex: 1,
                child: Container(
                    margin:
                        const EdgeInsets.only(left: 25.0, right: 25.0, top: 10),
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
                                  margin: const EdgeInsets.only(top: 10),
                                  child: const Text('Notify Target Vehicle'))
                            ],
                          ),
                        ]))),
            Expanded(flex: 2, child: TargetVehicleNotifyBut()),
            Expanded(flex: 1, child: TargetVehicleNotifyField())
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
