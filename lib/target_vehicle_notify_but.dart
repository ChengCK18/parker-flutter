import 'package:flutter/material.dart';

class TargetVehicleNotifyBut extends StatefulWidget {
  const TargetVehicleNotifyBut({Key? key}) : super(key: key);

  @override
  State<TargetVehicleNotifyBut> createState() => _TargetVehicleNotifyButState();
}

class _TargetVehicleNotifyButState extends State<TargetVehicleNotifyBut>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Color color1 = Colors.greenAccent;
  Color color2 = Colors.cyan;
  bool buttonOn = true;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 2, end: 20).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.white,
        customBorder: const CircleBorder(),
        onTap: () {
          if (buttonOn) {
            color1 = Colors.black;

            buttonOn = !buttonOn;
          } else {
            color1 = Colors.greenAccent;

            buttonOn = !buttonOn;
          }

          print("Container clicked");
        },
        child: Ink(
          child: IconButton(
              icon: Icon(Icons.notifications, size: 60.0),
              color: Colors.white,
              onPressed: null),
          height: 48,
          width: 160,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  color1,
                  color2,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: color1.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: animation.value,
                  offset: Offset(-8, 0),
                ),
                BoxShadow(
                  color: color2.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: animation.value,
                  offset: Offset(8, 0),
                ),
                BoxShadow(
                  color: color1.withOpacity(0.2),
                  spreadRadius: 16,
                  blurRadius: 32,
                  offset: Offset(-8, 0),
                ),
                BoxShadow(
                  color: color2.withOpacity(0.2),
                  spreadRadius: 16,
                  blurRadius: 32,
                  offset: Offset(8, 0),
                )
              ]),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
