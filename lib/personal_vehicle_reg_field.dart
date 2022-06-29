import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalVehicleRegField extends StatefulWidget {
  const PersonalVehicleRegField({Key? key, required this.userEmail})
      : super(key: key);

  final String userEmail;
  @override
  State<PersonalVehicleRegField> createState() =>
      _PersonalVehicleRegFieldState();
}

class _PersonalVehicleRegFieldState extends State<PersonalVehicleRegField> {
  var personalVehicleNumPlateControl = TextEditingController(text: "None");
  String registeredNumPlate = "";
  int totalAlertReceived = 0;

  CollectionReference vehicle =
      FirebaseFirestore.instance.collection('vehicles');

  void registerVehicle() async {
    if (personalVehicleNumPlateControl.text == registeredNumPlate) {
      //return;
    }

    deregisterFromVehicles().then((value) {
      print("Start of after deregisterFromVehicles");
      final snapShot = FirebaseFirestore.instance
          .collection('vehicles')
          .doc("${personalVehicleNumPlateControl.text}") // varuId in your case
          .get()
          .then((snapShot) {
        if (!snapShot.exists) {
          //Create new document only if there is no existing record of the vehicle
          vehicle.doc("${personalVehicleNumPlateControl.text}").set({
            "listener": [widget.userEmail],
            "reporter": [],
            "dateAdded": DateTime.now()
          }).then((value) {
            print("Added user to newly added vehicle");

            registeredNumPlate = personalVehicleNumPlateControl.text;
          }).catchError((error) => print("Failed to add Vehicle: $error"));
        } else {
          //Add user to existing vehicle
          var collection = FirebaseFirestore.instance.collection('vehicles');
          collection.doc("${personalVehicleNumPlateControl.text}").update({
            'listener': FieldValue.arrayUnion(['${widget.userEmail}'])
          }) // <-- Updated data
              .then((_) {
            print('Added user to existing vehicle');
            setState(() {
              registeredNumPlate = personalVehicleNumPlateControl.text;
            });
          }).catchError((error) =>
                  print('Adding user to existing vehicle failed: $error'));
        }
        listenToRegisteredVecAlert();
      });
    });
  }

  Future<void> deregisterFromVehicles() async {
    //To search for existing vehicle that was registered by user
    //and remove user from it
    print("Before deregisterFromVehicles");
    bool userRegistered = false;
    String userRegisteredVehicle = "";

    final querySnapshot =
        await FirebaseFirestore.instance.collection('vehicles').get();
    for (var doc in querySnapshot.docs) {
      // Getting data directly
      List<dynamic> recUserEmail = doc.get('listener');

      for (var email in recUserEmail) {
        if (email == widget.userEmail) {
          userRegistered = true;
          userRegisteredVehicle = doc.id;
          break;
        }
      }

      if (userRegistered) {
        break;
      }
    }

    if (userRegistered) {
      // remove user from other vehicle list
      var collection = await FirebaseFirestore.instance
          .collection('vehicles')
          .doc("${userRegisteredVehicle}")
          .update({
            'listener': FieldValue.arrayRemove(['${widget.userEmail}'])
          }) // <-- Updated data
          .then((_) => print('Removed user from other vehicle listener list'))
          .catchError((error) => print('Update failed: $error'));

      // remove vehicle if no listener remaining after removal of user
      final docRef = await FirebaseFirestore.instance
          .collection('vehicles')
          .doc("${userRegisteredVehicle}");

      DocumentSnapshot doc = await docRef.get();

      final data = doc.data() as Map<String, dynamic>;
      print(
          "NUMPLATE => ${userRegisteredVehicle} Listener => ${data["listener"]}");

      if (data["listener"].isEmpty) {
        await docRef.delete().then(
              (doc) => print("Document deleted"),
              onError: (e) => print("Error updating document $e"),
            );
        ;
      }
      // ...

    }
    print("After deregisterFromVehicles");
  }

  void removeVecWithoutListener() {}

  void queryData() async {
    final docRef =
        await FirebaseFirestore.instance.collection('vehicles').doc("JJP1334");

    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        if (data["listener"].isEmpty) {
          docRef.delete().then(
                (doc) => print("Document deleted"),
                onError: (e) => print("Error updating document $e"),
              );
          ;
        }
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  void getUserRegisteredVehicle() async {
    bool userRegistered = false;

    final querySnapshot =
        await FirebaseFirestore.instance.collection('vehicles').get();
    for (var doc in querySnapshot.docs) {
      // Getting data directly
      List<dynamic> recUserEmail = doc.get('listener');

      for (var email in recUserEmail) {
        if (email == widget.userEmail) {
          userRegistered = true;

          break;
        }
      }

      if (userRegistered) {
        personalVehicleNumPlateControl.text = doc.id;
        registeredNumPlate = doc.id;
        break;
      }
    }
  }

  void listenToRegisteredVecAlert() async {
    if (registeredNumPlate != "") {
      final docRef = await FirebaseFirestore.instance
          .collection("vehicles")
          .doc(registeredNumPlate);
      docRef.snapshots().listen(
        (event) {
          final data = event.data() as Map<String, dynamic>;
          if (data != null) {
            totalAlertReceived = data["reporter"].length;
            print("totalAlertReceived ${totalAlertReceived}");
          }
        },
        onError: (error) => print("Listen failed: $error"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    getUserRegisteredVehicle();

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
                  style: const TextStyle(color: Colors.white),
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
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(12),
                  primary: Colors.cyan, // <-- Button color
                  onPrimary: Colors.white, // <-- Splash color
                ),
                child: const Icon(Icons.app_registration_rounded,
                    color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  listenToRegisteredVecAlert();
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(12),
                  primary: Colors.cyan, // <-- Button color
                  onPrimary: Colors.white, // <-- Splash color
                ),
                child: const Icon(Icons.app_registration_rounded,
                    color: Colors.white),
              ),
            ]));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    personalVehicleNumPlateControl.dispose();
    super.dispose();
  }
}
