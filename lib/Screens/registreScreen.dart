import 'package:pcal/Widgets/myButtom.dart';
import 'mainScreen.dart';
import 'loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/gestures.dart';
import 'package:pcal/Widgets/widgets.dart';


class Registerscreen extends StatefulWidget {
      static const screenroute ='register-screen';

  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final _auth = FirebaseAuth.instance;
  late String email ;
  late String password  ,confirmPassword;
  bool showSpinner=false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child:  ListView(
        children:[ Container(
          child: Stack(
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
                padding: const EdgeInsets.only(top: 70.0),
                child: Column(
                  children: [
                    
                 Padding(
                padding: const EdgeInsets.all(8.0),
                child:  Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 60,),
                      
                      const SizedBox(height: 150),
                      Center(
                        child: const Text("Create ur account now to chat and explore!",
                        style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400)),
                      ),
                      Container(
                      height: 200,
                      width: 200,
                child:Image.asset('images/logo1.png')
            ),
                      
                      SizedBox(height: 10,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: textInputDecoration.copyWith(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email, color:  Color.fromARGB(246, 236, 41, 106),)
                        ),
                        onChanged: (value) {
                            email= value;
                          },
                          //tchouf validation mta3 email
                          validator: (value) {
                                      return RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value!)
                                          ? null
                                          : "Please enter a valid email";
                                    },
                          
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock, color: Color.fromARGB(246, 236, 41, 106),)
                        ),
                        validator: (value) {
                           if (value!.length < 6) {
                                        return "Password must be at least 6 characters";
                                      } else {
                                        return null;
                                      }
                        },
                        onChanged: (value) {
                            password= value;
                          },
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                          labelText: "Confirm Password",
                          prefixIcon: Icon(Icons.lock, color: Color.fromARGB(246, 236, 41, 106),)
                        ),
                        validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Confirm Password';
                                    }
                                    return null;
                                  },
                        onChanged: (value) {
                            confirmPassword= value;
                          },
                      ),
                      
                      SizedBox(height: 20,),
                      
                       MyBotton(color: Color.fromARGB(246, 236, 41, 106), 
                       textColor:Color.fromARGB(255, 255, 255, 255) ,
                       title: 'Register', onPressed:()async{
                
                 try {
                  
                  if ( password==confirmPassword) {
                    setState(() {
                  showSpinner=true;
                });
                    // ignore: unused_local_variable
                   final newUser =await _auth.createUserWithEmailAndPassword(email: email,
                 password: password);
                 // ignore: use_build_context_synchronously
                 Navigator.pushNamed(context, MainScreen.screenroute)
             ;
             setState(() {
               showSpinner=false;
             });
                  }else{
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              " Wrong ! Confirm your password ",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
                  }
                   
                 }on FirebaseAuthException catch (e) {
                     if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0),
              )));
        }
      
               }}),
                      SizedBox(height: 10,),
                      Center(
                        child: Text.rich(TextSpan(
                          
                           text: "Do you have an account? ",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "Login now",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              decoration: TextDecoration.underline),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              nextScreen(context, const signinscreen());
                                            }),
                                    ]
                        )),
                      ),
                    ],
                  ),
                ),
              ),]
            ),
          ),
        ])),
      ])));
    
  }
}