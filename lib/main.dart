import 'package:flutter/material.dart';
import 'package:parker/register_vec.dart';
import 'package:parker/request_vec.dart';
import 'toggle_personal_vehicle.dart';
import 'register_vec.dart';
import 'alert_target_vehicle.dart';

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
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
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
  int _counter = 0;
  String vecPlateNum = "None";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF240046),
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
            Expanded(flex: 2, child: TogglePersonalVehicle()),
            Expanded(flex: 1, child: RegisterVec()),
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
                                  child: const Text('Alert Target Vehicle'))
                            ],
                          ),
                        ]))),
            Expanded(flex: 2, child: AlertTargetVehicle()),
            Expanded(flex: 1, child: RequestVec())
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
