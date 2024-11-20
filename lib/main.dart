import 'package:flutter/material.dart';
import 'package:pcal/calculatePer.dart';
import 'package:pcal/mainScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pcal/menstriel.dart';
import 'package:pcal/Screens/welcomeScreen.dart';
import 'package:pcal/Screens/registreScreen.dart';
import 'package:pcal/Screens/loginScreen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Period Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: _auth.currentUser!=null ? MainScreen.screenroute:welcomeScreen.screenroute,
      routes: {
        welcomeScreen.screenroute:(context)=> welcomeScreen(),
        signinscreen.screenroute:(context)=> signinscreen(), 
        Registerscreen.screenroute:(context)=> Registerscreen(),
        MainScreen.screenroute:(context)=> MainScreen(),
        CalculatePer.screenroute:(context)=>CalculatePer(),
        MenstrualFormScreen.screenroute:(context)=>MenstrualFormScreen(),
        

      }
    );
  }
}

