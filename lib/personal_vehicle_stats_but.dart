import 'package:flutter/material.dart';

class PersonalVehicleStatsBut extends StatefulWidget {
  const PersonalVehicleStatsBut(
      {Key? key,
      required this.personalVecAlertReceived,
      required this.personalOnline,
      required this.updatePersonalOnline})
      : super(key: key);

  final int personalVecAlertReceived;
  final bool personalOnline;
  final Function updatePersonalOnline;
  @override
  State<PersonalVehicleStatsBut> createState() =>
      _PersonalVehicleStatsButState();
}

class _PersonalVehicleStatsButState extends State<PersonalVehicleStatsBut>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Color color1 = Colors.greenAccent;
  Color color2 = Colors.cyan;

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
    if (widget.personalOnline) {
      color1 = Colors.greenAccent;
      color2 = Colors.cyan;
    } else {
      color1 = Colors.grey.shade700;
      color2 = Colors.grey.shade500;
    }

    if (widget.personalOnline && widget.personalVecAlertReceived > 0) {
      color1 = Colors.redAccent;
      color2 = Colors.red;
    }

    return InkWell(
        splashColor: Colors.white,
        customBorder: const CircleBorder(),
        onTap: () {
          widget.updatePersonalOnline();
          if (widget.personalOnline) {
            color1 = Colors.greenAccent;
            color2 = Colors.cyan;
          } else {
            color1 = Colors.grey.shade700;
            color2 = Colors.grey.shade500;
          }
          //
        },
        child: Ink(
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
                  offset: const Offset(-8, 0),
                ),
                BoxShadow(
                  color: color2.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: animation.value,
                  offset: const Offset(8, 0),
                ),
                BoxShadow(
                  color: color1.withOpacity(0.2),
                  spreadRadius: 16,
                  blurRadius: 32,
                  offset: const Offset(-8, 0),
                ),
                BoxShadow(
                  color: color2.withOpacity(0.2),
                  spreadRadius: 16,
                  blurRadius: 32,
                  offset: const Offset(8, 0),
                )
              ]),
          child: const IconButton(
              icon: Icon(Icons.car_crash, size: 40.0),
              color: Colors.white,
              onPressed: null),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
