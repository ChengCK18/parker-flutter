import 'package:flutter/material.dart';
import 'package:parker/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailInputControl = TextEditingController(text: "");
  final passwordInputControl = TextEditingController(text: "");
  bool dispTac = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  void showAlert(success, [errorMessage]) {
    if (!success) {
      AlertDialog alert = AlertDialog(
        title: const Text("Woops, error"),
        content: Text(errorMessage),
        actions: [
          TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
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

  Future<bool> loginVerification() async {
    if (emailInputControl.text == "") {
      showAlert(false, "Email field cannot be empty");
      return false;
    }
    if (passwordInputControl.text == "") {
      showAlert(false, "Password field cannot be empty");
      return false;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailInputControl.text,
              password: passwordInputControl.text);

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null && !user.emailVerified) {
          AlertDialog alert = AlertDialog(
            title: const Text("Woops, error"),
            content: const Text("Email is not verified"),
            actions: [
              TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
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
      });

      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";
      switch (e.code) {
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          errorMessage = "Wrong email/password combination.";
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          errorMessage = "Wrong email/password combination.";
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          errorMessage = "User disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          errorMessage = "Too many requests to log into this account.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          errorMessage = "Server error, please try again later.";
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          errorMessage = "Email address is invalid.";
          break;
        case "weak-password":
          errorMessage = 'The password provided is too weak.';
          break;
        default:
          errorMessage =
              "Login failed. Please entry fields are entered. ${e.code}";
          break;
      }
      showAlert(false, errorMessage);
    }
    return false;
  }

  void signUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "App Name",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextFormField(
                    maxLength: 30,
                    controller: emailInputControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          emailInputControl.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                      filled: true,
                      alignLabelWithHint: true,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                      //[focusedBorder], displayed when [TextField, InputDecorator.isFocused] is true
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),

                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextFormField(
                    maxLength: 30,
                    obscureText: true,
                    controller: passwordInputControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          passwordInputControl.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                      filled: true,
                      alignLabelWithHint: true,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                      //[focusedBorder], displayed when [TextField, InputDecorator.isFocused] is true
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),

                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // loginVerification().then((loggedIn) {
                      //   if (loggedIn) {
                      //     String userEmail = emailInputControl.text;
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) =>
                      //               MyHomePage(title: "Welcome, ${userEmail}")),
                      //     );
                      //     emailInputControl.clear();
                      //     passwordInputControl.clear();
                      //   }
                      // });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(title: "Welcome lolk")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                Center(
                    child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    signUp();
                  },
                  child: const Text('Don\'t have an account? Sign up'),
                ))
              ],
            ),
          )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailInputControl.dispose();
    passwordInputControl.dispose();
    super.dispose();
  }
}
