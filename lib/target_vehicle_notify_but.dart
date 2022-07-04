import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TargetVehicleNotifyBut extends StatefulWidget {
  const TargetVehicleNotifyBut(
      {Key? key,
      required this.userEmail,
      required this.targetVehicleNumPlateControl,
      required this.personalVecNumPlate})
      : super(key: key);

  final String userEmail;
  final String personalVecNumPlate;
  final TextEditingController targetVehicleNumPlateControl;

  @override
  State<TargetVehicleNotifyBut> createState() => _TargetVehicleNotifyButState();
}

class _TargetVehicleNotifyButState extends State<TargetVehicleNotifyBut>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Color color1 = Colors.greenAccent;
  Color color2 = Colors.cyan;

  IconData buttonStatus =
      Icons.notifications; //0,not sent, 1 = sending, 2 = sent

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

  void displayAlert(errorMsg) {
    //A function to display error message using popup dialog to user
    color1 = Colors.redAccent;
    color2 = Colors.red;
    buttonStatus = Icons.error;

    AlertDialog alert = AlertDialog(
      title: const Text("Woops, error"),
      content: Text(errorMsg),
      actions: [
        TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              widget.targetVehicleNumPlateControl.clear();
            }),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> alertTargetVehicle() async {
    // To transmit alert to target vehicle after verification steps
    if (widget.targetVehicleNumPlateControl.text ==
        widget.personalVecNumPlate) {
      displayAlert(
          "Target Vehicle cannot be the same as your registered vehicle");
      return;
    }
    if (widget.targetVehicleNumPlateControl.text == "") {
      displayAlert("Please enter a vehicle number plate to send alert to");
    }

    if (widget.targetVehicleNumPlateControl.text != "") {
      buttonStatus = Icons.pending;
      color1 = Colors.yellow.shade700;
      color2 = Colors.yellow.shade600;
      final snapShot = await FirebaseFirestore.instance
          .collection('vehicles')
          .doc(widget.targetVehicleNumPlateControl.text)
          .get();

      if (snapShot.exists) {
        var collection = FirebaseFirestore.instance.collection('vehicles');
        collection.doc(widget.targetVehicleNumPlateControl.text).update({
          'reporter': FieldValue.arrayUnion([widget.userEmail])
        }).then((_) {
          color1 = Colors.greenAccent;
          color2 = Colors.cyan;
          buttonStatus = Icons.check;
        }).catchError((error) => print('Update failed: $error'));
      } else {
        displayAlert("Target Vehicle is not registered on this platform.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.white,
        customBorder: const CircleBorder(),
        onTap: () {
          alertTargetVehicle().then((_) {
            Future.delayed(const Duration(milliseconds: 5000), () {
              color1 = Colors.greenAccent;
              color2 = Colors.cyan;
              buttonStatus = Icons.notifications;
            });
          });
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
          child: IconButton(
              icon: Icon(buttonStatus, size: 40.0),
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
