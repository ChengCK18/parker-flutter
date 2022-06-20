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
  Color color1 = Colors.grey.shade700;
  Color color2 = Colors.grey.shade500;
  int buttonStatus = 0; //0,not sent, 1 = sending, 2 = sent

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 0, end: 16).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
    controller.repeat(reverse: true);
  }

  IconData getIcon() {
    if (buttonStatus == 0) {
      return Icons.notifications;
    } else if (buttonStatus == 1) {
      return Icons.pending;
    } else {
      return Icons.check;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.white,
        customBorder: const CircleBorder(),
        onTap: () {
          if (buttonStatus == 0) {
            color1 = Colors.yellow.shade700;
            color2 = Colors.yellow.shade600;

            buttonStatus = 1;
          } else if (buttonStatus == 1) {
            color1 = Colors.greenAccent;
            color2 = Colors.cyan;
            buttonStatus = 2;

            Future.delayed(const Duration(milliseconds: 5000), () {
              color1 = Colors.grey.shade700;
              color2 = Colors.grey.shade500;
              buttonStatus = 0;
            });
          }

          print("Container clicked");
        },
        child: Ink(
          child: IconButton(
              icon: Icon(getIcon(), size: 40.0),
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
                  spreadRadius: 2,
                  blurRadius: animation.value,
                  offset: Offset(-8, 0),
                ),
                BoxShadow(
                  color: color2.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: animation.value,
                  offset: Offset(8, 0),
                ),
                BoxShadow(
                  color: color1.withOpacity(0.2),
                  spreadRadius: 6,
                  blurRadius: 32,
                  offset: Offset(-8, 0),
                ),
                BoxShadow(
                  color: color2.withOpacity(0.2),
                  spreadRadius: 6,
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
