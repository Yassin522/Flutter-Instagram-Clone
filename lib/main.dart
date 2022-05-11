import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:flutter_instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:flutter_instagram_clone/responsive/web_screen_layout.dart';
import 'package:flutter_instagram_clone/screens/login_screen.dart';
import 'package:flutter_instagram_clone/screens/signup_screen.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
     await Firebase.initializeApp(
       options: const FirebaseOptions(
         apiKey: 'AIzaSyCkNFhEV0FYl8JIGRLbh8rDE2MIAtTXoco',
          appId: '1:526752616412:web:d853710803e44a9aea8919', 
          messagingSenderId: '526752616412',
           projectId: 'instagram-clone-cd17f',
           storageBucket: 'instagram-clone-cd17f.appspot.com',
           ),
     );
  }
  else{
     await Firebase.initializeApp();
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
         scaffoldBackgroundColor: mobileBackground,
      ),
      home: SignupScreen(),
   
    );
  }
}

