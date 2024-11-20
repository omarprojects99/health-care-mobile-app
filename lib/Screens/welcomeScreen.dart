import 'package:pcal/Screens/registreScreen.dart';
import 'package:pcal/Screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:pcal/Widgets/myButtom.dart';
class welcomeScreen extends StatefulWidget {
  static const screenroute ='welcome-screen';
  const welcomeScreen({super.key});

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children:[ Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[ 
            Container(
                        height: MediaQuery.of(context).size.height / 3.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image:DecorationImage(image: AssetImage("images/logo2.png")) ,
                            gradient: LinearGradient(
                                colors: [Color.fromARGB(246, 236, 41, 106), Color.fromARGB(246, 249, 75, 139)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.elliptical(
                                    MediaQuery.of(context).size.width, 105.0)))
                                    ),
                                    
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            children: [
             
                                    
                        Container(
                child:Image.asset('images/logo.png')
            )],
              ),
          ),
          SizedBox( height: 0 ),
        MyBotton(
          color: Color.fromARGB(246, 236, 41, 106),
          textColor:Color.fromARGB(255, 255, 255, 255) ,
          title: 'Sign in',
          onPressed: (){
            Navigator.pushNamed(context, signinscreen.screenroute);
          },
        ),
            SizedBox( height: 10 ),
      
        MyBotton(
          color: Color.fromARGB(255, 255, 255, 255),
          textColor:Color.fromARGB(255, 0, 0, 0) ,
          title: 'Register',
          onPressed: (){
                      Navigator.pushNamed(context,Registerscreen.screenroute);
      
          },
        ),]
          ),
      ]),
    );
  }
}

