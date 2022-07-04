import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailInputControl = TextEditingController();
  final passwordInputControl = TextEditingController();
  final passwordConfirmInputControl = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void showAlert(success, [errorMessage]) {
    if (success) {
      AlertDialog alert = AlertDialog(
        title: const Text("Sign Up Successful!"),
        content: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              const TextSpan(text: 'Account has been created with '),
              TextSpan(
                  text: '${emailInputControl.text}.',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const TextSpan(
                  text: '\nYou can now login with the registered email.'),
            ],
          ),
        ),
        actions: [
          TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
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
    } else {
      AlertDialog alert = AlertDialog(
        title: const Text("Woops, error"),
        content: Text(errorMessage),
        actions: [
          TextButton(
              child: Text("OK"),
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

  void verifySignUp() async {
    // Verification steps for user's input when signing up an account
    if (passwordInputControl.text != passwordConfirmInputControl.text) {
      showAlert(false, "Password mismatched");
      return;
    }
    if (emailInputControl.text == "") {
      showAlert(false, "Missing Email");
      return;
    }
    if (passwordInputControl.text == "") {
      showAlert(false, "Missing Password");
      return;
    }
    if (passwordConfirmInputControl.text == "") {
      showAlert(false, "Missing Reenter Password");
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailInputControl.text, password: passwordInputControl.text);

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      showAlert(true);
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";

      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          errorMessage = "Email already used. Go to login page.";
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          errorMessage = "Wrong email/password combination.";
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          errorMessage = "No user found with this email.";
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
              "Sign Up failed. Please entry fields are entered. ${e.code}";
          break;
      }
      showAlert(false, errorMessage);
    } catch (e) {
      print(e);
    }
  }

  void returnToLogin() {
    Navigator.pop(context);
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
                    "Sign Up",
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextFormField(
                    maxLength: 30,
                    obscureText: true,
                    controller: passwordConfirmInputControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          passwordConfirmInputControl.clear();
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

                      labelText: 'Reenter Password',
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      verifySignUp();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    child: const Text(
                      "Create an account",
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
                    returnToLogin();
                  },
                  child: const Text('Already have an account? Login'),
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
    passwordConfirmInputControl.dispose();
    super.dispose();
  }
}
