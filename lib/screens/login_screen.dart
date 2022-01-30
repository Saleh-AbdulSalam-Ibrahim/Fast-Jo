import 'package:fast_jo_u/components/progressDialog.dart';
import 'package:fast_jo_u/components/roundButton.dart';
import 'package:fast_jo_u/methods/login.dart';
import 'package:fast_jo_u/screens/registeration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';
TextEditingController emailTextEditingController= TextEditingController();
TextEditingController passwordTextEditingController= TextEditingController();
class LoginScreen extends StatelessWidget {
  static const String idScreen='login';


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
                image: AssetImage('images/flash.png'),
                width: 400.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 1.0,
              ),
              //\n||\n Hello Passenger
              const Text('Login as a Passenger',
                style: TextStyle(fontSize: 24.0,fontFamily: 'bolt-regular'),
                textAlign: TextAlign.center,
              ),
              Padding(padding: const EdgeInsets.only(left: 30.0,top: 150.0,right: 30.0,bottom: 0.0),
                child: Column(

                  children: [
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

                    const SizedBox(height: 15.0,),
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
                    // ElevatedButton(
                    //   style: ButtonStyle(),
                    //
                    //   onPressed: () {},
                    //   child: const Text('Enabled'),
                    // ),
                    const SizedBox(height: 70.0,),
                //
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blue,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {
                          if(!emailTextEditingController.text.contains('@'))
                          {
                            displayToastMsg('Email address is not valid.', context);
                          }else if(passwordTextEditingController.text.isEmpty)
                          {
                            displayToastMsg('Please enter the password.', context);
                          }else{
                            loginAndAuthUser(context);
                          }

                        },
                        child: const Text("Login",
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
                Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => true);
              }, child: const Text('Do not have an Account? Register here.')),
            ],
          ),
        ),
      ),
    );
  }


}

// void loginAndAuthUser(BuildContext context) async{
//   final User? firebaseUser = (
//       await _firebaseAuth
//           .signInWithEmailAndPassword(
//           email: emailTextEditingController.text,
//           password: passwordTextEditingController.text).catchError((errMsg){
//           displayToastMsg('Error' + errMsg.toString(), context);
//       })).user;
//
//   if(firebaseUser!=null) {
//      // print(userReference.child(firebaseUser.uid));
//
//     userReference.child(firebaseUser.uid).once().then((value) => (DataSnapshot snap){
//       if(snap.value!=null)
//         {
//           displayToastMsg('Login successfully', context);
//           Navigator.pushNamedAndRemoveUntil(
//               context, MainScreen.idScreen, (route) => false);
//         }
//       else
//         {
//           _firebaseAuth.signOut();
//           displayToastMsg('No record exist, Please create new Account.', context);
//         }
//     });
//
//   }
//   else{//error occurred - display msg
//     displayToastMsg('An error occurred, can\'t be Sign-in!!.',context);
//   }
//
// }
//RoundedButton(colour: Colors.blueAccent,title: 'Login',onPressedf:   () {
// if(!emailTextEditingController.text.contains('@'))
// {
// displayToastMsg('Email address is not valid.', context);
// }else if(passwordTextEditingController.text.isEmpty)
// {
// displayToastMsg('Please enter the password.', context);
// }else{
// loginAndAuthUser(context);
// }
//
// },),