import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalVehicleRegField extends StatefulWidget {
  const PersonalVehicleRegField({Key? key}) : super(key: key);

  @override
  State<PersonalVehicleRegField> createState() =>
      _PersonalVehicleRegFieldState();
}

class _PersonalVehicleRegFieldState extends State<PersonalVehicleRegField> {
  final personalVehicleNumPlateControl = TextEditingController(text: "None");

  CollectionReference vehicle =
      FirebaseFirestore.instance.collection('vehicles');

  Future<void> registerVehicle() async {
    final snapShot = await FirebaseFirestore.instance
        .collection('vehicles')
        .doc("${personalVehicleNumPlateControl.text}") // varuId in your case
        .get();

    if (!snapShot.exists) {
      //Create new document only if there is no existing record of the vehicle
      return vehicle.doc("${personalVehicleNumPlateControl.text}").set({
        'alertNum': 0,
        "listener": ['da user here'],
        "reporter": [],
        "dateAdded": DateTime.now()
      }).then((value) {
        print("Vehicle Added");
        personalVehicleNumPlateControl.clear();
      }).catchError((error) => print("Failed to add Vehicle: $error"));
    } else {
      //Add user to existing vehicle
      var collection = FirebaseFirestore.instance.collection('vehicles');
      collection
          .doc(
              "${personalVehicleNumPlateControl.text}") // <-- Doc ID where data should be updated.
          .update({
            'listener': FieldValue.arrayUnion(['another user here'])
          }) // <-- Updated data
          .then((_) => print('Updated'))
          .catchError((error) => print('Update failed: $error'));
    }
  }

  void queryData() async {
    // Call the user's CollectionReference to add a new user
    final querySnapshot =
        await FirebaseFirestore.instance.collection('vehicles').get();
    print(querySnapshot.docs);
    for (var doc in querySnapshot.docs) {
      // Getting data directly
      Timestamp name = doc.get('dateAdded');

      print(doc.data());
      // Getting data from map
      Map<String, dynamic> data = doc.data();
      int alertNum = data['alertNum'];
      print(alertNum);
    }
  }

  void alertTargetVehicle(String targetNumPlate) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('vehicles')
        .doc("${personalVehicleNumPlateControl.text}") // varuId in your case
        .get();

    if (snapShot.exists) {
      var collection = FirebaseFirestore.instance.collection('vehicles');
      collection
          .doc(
              "${personalVehicleNumPlateControl.text}") // <-- Doc ID where data should be updated.
          .update({
            'listener': FieldValue.arrayUnion(['another user here'])
          }) // <-- Updated data
          .then((_) => print('Updated'))
          .catchError((error) => print('Update failed: $error'));
    } else {
      AlertDialog alert = AlertDialog(
        title: const Text("Woops, error"),
        content: Text("Target Vehicle is not registered on this platform."),
        actions: [
          TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                personalVehicleNumPlateControl.clear();
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
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    personalVehicleNumPlateControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 150,
                child: TextFormField(
                  controller: personalVehicleNumPlateControl,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    filled: true,
                    alignLabelWithHint: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    //[focusedBorder], displayed when [TextField, InputDecorator.isFocused] is true
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),

                    labelText: 'Personal Vehicle',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  registerVehicle();
                },
                child:
                    Icon(Icons.app_registration_rounded, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(12),
                  primary: Colors.cyan, // <-- Button color
                  onPrimary: Colors.white, // <-- Splash color
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  queryData();
                },
                child:
                    Icon(Icons.app_registration_rounded, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(12),
                  primary: Colors.cyan, // <-- Button color
                  onPrimary: Colors.white, // <-- Splash color
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  alertTargetVehicle('dd');
                },
                child:
                    Icon(Icons.app_registration_rounded, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(12),
                  primary: Colors.cyan, // <-- Button color
                  onPrimary: Colors.white, // <-- Splash color
                ),
              )
            ]));
  }
}
