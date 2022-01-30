import 'package:fast_jo_u/components/progressDialog.dart';
import 'package:fast_jo_u/screens/login_screen.dart';
import 'package:fast_jo_u/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

void loginAndAuthUser (BuildContext context) async {
  //Implement login functionality.
  showDialog(context: context, builder: (BuildContext context){
    return ProgressDialog(message: 'Authenticating, Please wait...',);
  },
  );
  try {
    final firebaseUser = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailTextEditingController.text, password: passwordTextEditingController.text);
    if (firebaseUser != null) {
      displayToastMsg('Login successfully', context);
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);

    }
  } catch (e) {
    print(e);
    displayToastMsg('An error occurred, can\'t be Sign-in!!.',context);
    Navigator.pop(context);
  }

}