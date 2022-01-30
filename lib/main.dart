import 'package:fast_jo_u/screens/login_screen.dart';
import 'package:fast_jo_u/screens/registeration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fast_jo_u/screens/main_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference userReference=FirebaseDatabase.instance.ref().child('users');//old command '.reference().'
class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Jo',
      theme: ThemeData(
        fontFamily: 'bolt-regular',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: MainScreen.idScreen ,
      routes: {
        RegistrationScreen.idScreen : (context) =>RegistrationScreen(),

        LoginScreen.idScreen : (context) =>LoginScreen(),

        MainScreen.idScreen : (context) =>MainScreen(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}

/*The Firebase Android BoM (Bill of Materials) enables you to manage all your Firebase library versions
by specifying only one version — the BoM's version.

When you use the Firebase BoM in your app, the BoM automatically pulls in the
individual library versions mapped to BoM's version. All the individual library versions will be compatible.
When you update the BoM's version in your app, all the Firebase libraries that you use in your app
will update to the versions mapped to that BoM version.*/
