import 'dart:developer';

import 'package:fast_jo_u/components/progressDialog.dart';
import 'package:fast_jo_u/main.dart';
import 'package:fast_jo_u/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';

class RegistrationScreen extends StatelessWidget {
  static const String idScreen='register';
  TextEditingController nameTextEditingController= TextEditingController();
  TextEditingController emailTextEditingController= TextEditingController();
  TextEditingController phoneTextEditingController= TextEditingController();
  TextEditingController passwordTextEditingController= TextEditingController();
  TextEditingController confirmPasswordTextEditingController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children:  <Widget>[
              const SizedBox(
                height: 50.0,
              ),
              const Image(
                image: AssetImage('images/logo.png'),
                width: 400.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 1.0,
              ),
              //\n||\n Hello Passenger
              const Text('Register as a Passenger',
                style: TextStyle(fontSize: 24.0,fontFamily: 'bolt-regular'),
                textAlign: TextAlign.center,
              ),
              Padding(padding: const EdgeInsets.only(left: 30.0,top: 50.0,right: 30.0,bottom: 0.0),
                child: Column(

                  children:  [
                    const SizedBox(height: 1.0,),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Example',
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),

                    ),
                    const SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Example@e-mail.com',
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),

                    ),
                    const SizedBox(height: 1.0,),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: '07XXXXXXXX',
                        labelText: 'Phone',
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),

                    ),

                    const SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),

                    ),
                    const SizedBox(height: 1.0,),
                    TextField(
                      controller: confirmPasswordTextEditingController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),

                    ),
                    const SizedBox(height: 30.0,),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blue,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {
                          if(nameTextEditingController.text.length<3)
                          {
                            displayToastMsg('Name must be 3 characters or more.', context);
                          }
                          else if(!emailTextEditingController.text.contains('@'))
                          {
                            displayToastMsg('Email address is not valid.', context);
                          }
                          else if( phoneTextEditingController.text.length < 10 || phoneTextEditingController.text.length > 10 )
                          {
                            displayToastMsg('Phone number is not valid.', context);
                          }
                          else if(passwordTextEditingController.text.length < 8)
                          {
                            displayToastMsg('Password must be 8 characters or more.', context);
                          }
                          else if(confirmPasswordTextEditingController.text !=passwordTextEditingController.text )
                          {
                            displayToastMsg('Confirm Password and Password must be the same.', context);
                          }
                          else{
                            registerNewAccount(context );
                          }



                        },
                        child: const Text('Create Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 10.0,),


                  ],
                ),
              ),
              TextButton(onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
              }, child: const Text('Already have an Account? Login here.')),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  registerNewAccount(BuildContext context) async
  {
    showDialog(context: context, builder: (BuildContext context){
      return ProgressDialog(message: 'Authenticating, Please wait...',);
    },
    );
    try {

      final User? firebaseUser = (
          await _firebaseAuth
              .createUserWithEmailAndPassword(
              email: emailTextEditingController.text,
              password: passwordTextEditingController.text).catchError((
              errMsg) {
            displayToastMsg('Error' + errMsg.toString(), context);
          })).user;

      if (firebaseUser != null) { //save user info to database
        // print(userReference.child(firebaseUser!.uid));
        Map userDataMap = {
          'name': nameTextEditingController.text.trim(),
          'email': emailTextEditingController.text.trim(),
          'phone': phoneTextEditingController.text.trim(),
          'userType': 'passenger', //in next app change type to 'driver'
        };
        userReference.child(firebaseUser.uid).set(userDataMap);
        displayToastMsg('Your account has been created', context);
        Navigator.pushNamedAndRemoveUntil(
            context, MainScreen.idScreen, (route) => false);

      }
    }catch (e) {//error occurred - display msg
      Navigator.pop(context);
      displayToastMsg('New user account has not been created!!.',context);
      if (e == 'weak-password') {
        displayToastMsg('The password provided is too weak.',context);
      } else if (e == 'email-already-in-use') {
        displayToastMsg('The account already exists for that email.',context);
      }
    }
  }
}
/*
 on FirebaseAuthException catch (e) { //error occurred - display msg
    if (e.code == 'weak-password') {
      displayToastMsg('The password provided is too weak.',context);
    } else if (e.code == 'email-already-in-use') {
      displayToastMsg('The account already exists for that email.',context);
    }
 */