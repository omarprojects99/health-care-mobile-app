import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:pcal/Widgets/myButtom.dart';
import 'package:pcal/calculatePer.dart';
import 'package:pcal/menstriel.dart';
import 'package:pcal/Screens/welcomeScreen.dart';
class MainScreen extends StatefulWidget {
  static const screenroute ='main-screen';
  
  const MainScreen({super.key});

  @override
  
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late User SigninUser;
  final _auth=FirebaseAuth.instance;
  final Color myColor = Color.fromARGB(255, 243, 73, 73);
  @override
   void getCurrentUser (){
    try {
      final user = _auth.currentUser;
    if (user!=null) {
      SigninUser=user;
    }
    } catch (e) {
      print(e);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(5),
    children: [
      const UserAccountsDrawerHeader(
        
        accountEmail: Text(""),
        accountName: Text("hi mariem"),
        decoration: BoxDecoration(
          image:DecorationImage(image: AssetImage("images/logo.png")),
          color: Colors.transparent,
        ),
        
      ),
      ListTile(
        title: const Text('ChatBot'),
        onTap: () {
          Navigator.pushNamed(context,welcomeScreen.screenroute);
        },
      ),
      ListTile(
        title: const Text('Sign out'),
        
        onTap: () {
          _auth.signOut();
               Navigator.pushNamed(context,welcomeScreen.screenroute);
        },
      ),
     
    ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        
      ),
      body: Container(
        decoration: BoxDecoration(
          color: myColor,
          borderRadius: BorderRadius.circular(20)
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: ListView(children:[ Column( 
          children: [
            Container(
              
              decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        padding: const EdgeInsets.all(25),
        //margin: const EdgeInsets.symmetric(horizontal: 20),
              child:Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Expanded(
      child: Column(
        children: [
          Text("When is your last period:"),
          SizedBox(height: 10),
          MyBotton(
            color: Color.fromARGB(246, 236, 41, 106),
            textColor: Color.fromARGB(255, 255, 255, 255),
            title: 'Add your last period',
            onPressed: () {
              Navigator.pushNamed(context,MenstrualFormScreen.screenroute);
            },
          ),
        ],
      ),
    ),
    Expanded(
      child: Container(
        height: 150,
        width: 150,
        child: Image.asset('images/logo1.png'),
      ),
    ),
  ],
),

            ),
            Container(
              
              decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        padding: const EdgeInsets.all(25),
        //margin: const EdgeInsets.symmetric(horizontal: 20),
              child:Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Expanded(
      child: Column(
        children: [
          Text("Do you want to know something:"),
          SizedBox(height: 10),
          MyBotton(
            color: Color.fromARGB(246, 236, 41, 106),
            textColor: Color.fromARGB(255, 255, 255, 255),
            title: 'Chat with Me :)',
            onPressed: () {
              Navigator.pushNamed(context,MenstrualFormScreen.screenroute);
            },
          ),
        ],
      ),
    ),
    Expanded(
      child: Container(
        height: 150,
        width: 150,
        child: Image.asset('images/logo.png'),
      ),
    ),
  ],
),

            ),
            
          ],
        ) ,
      ])
      ),
    );
  }
}