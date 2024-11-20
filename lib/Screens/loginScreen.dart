import 'package:pcal/Widgets/myButtom.dart';
import 'package:pcal/Screens/registreScreen.dart';
import 'package:pcal/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/gestures.dart';
import 'package:pcal/Widgets/widgets.dart';



class signinscreen extends StatefulWidget {
    static const screenroute ='signin-screen';

  const signinscreen({super.key});

  @override
  State<signinscreen> createState() => _signinscreenState();
}

class _signinscreenState extends State<signinscreen> {
  final _authf = FirebaseAuth.instance;
  late  String email;
  late  String password;
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
                        child: const Text("Login now to see what they are talking!",
                        style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400)),
                      ),
                     Container(
                      height: 200,
                      width: 200,
                child:Image.asset('images/logo.png')
            ),
                      SizedBox(height: 10,),
                      
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
                      
                      
                      SizedBox(height: 20,),
                      
                       MyBotton(color: Color.fromARGB(246, 236, 41, 106),
                       textColor:Color.fromARGB(255, 255, 255, 255) , title: 'Sign In', onPressed:()async{
                setState(() {
                  showSpinner=true;
                });
                try {
                  final user= await _authf.signInWithEmailAndPassword(email: email, password: password);
                   // ignore: unnecessary_null_comparison
                   if (user!=Null) {
                  Navigator.pushNamed(context, MainScreen.screenroute);
                  setState(() {
                    showSpinner=false;
                  });
                }
                  
                } catch (e) {
                  print(e);
                }
               }),
                      SizedBox(height: 10,),
                      Center(
                        child: Text.rich(TextSpan(
                          
                           text: "Don't have an account? ",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "Register here",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              decoration: TextDecoration.underline),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              nextScreen(context, const Registerscreen());
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