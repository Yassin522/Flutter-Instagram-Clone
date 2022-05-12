

import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/resources/auth_methods.dart';
import 'package:flutter_instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:flutter_instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:flutter_instagram_clone/responsive/web_screen_layout.dart';
import 'package:flutter_instagram_clone/screens/home_screen.dart';
import 'package:flutter_instagram_clone/screens/signup_screen.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/utils/util.dart';
import 'package:flutter_instagram_clone/widgets/text_field_input.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final TextEditingController _emailController=TextEditingController();
final TextEditingController _passwordController=TextEditingController();
bool _isLoading=false;

   @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void LoginUser()async{
    setState(() {
      _isLoading=true;
    });
       String res=await AuthMethods().loginUser(
         email: _emailController.text, 
         password: _passwordController.text,
         );
         if(res=="seccess"){
             Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context)=> const ResponsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                       mobileScreenLayout: MobileScreenLayout(),
                    )
              )
          );
         }else{
            showSnackBar(res, context);
         }

     setState(() {
      _isLoading=false;
    });
  }

  void navigatetoSignup(){
     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       body: SafeArea(
          child: Container(
             padding: const EdgeInsets.symmetric(horizontal: 32),
             width: double.infinity,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Flexible(child: Container(), flex: 2,),
                   SvgPicture.asset(
                      'assets/ic_instagram.svg',
                      color:primaryColor,
                      height:64,
                   ),
                   const SizedBox(height: 64),
                  
                  TextFieldInput(
                    textEditingController: _emailController,
                     hintText: 'Enter your email', 
                     textInputType: TextInputType.emailAddress,
                    ),
                   const SizedBox(height: 24),
                     TextFieldInput(
                    textEditingController: _passwordController,
                     hintText: 'Enter your password', 
                     textInputType: TextInputType.emailAddress,
                     isPass: true,
                    ),

                    const SizedBox(height: 24),

                    InkWell(
                      onTap:LoginUser,
                      child: Container(
                         child: _isLoading?
                         const CircularProgressIndicator(color: primaryColor,) 
                         :const Text('log in'),
                         width: double.infinity,
                         alignment: Alignment.center,
                         padding: const EdgeInsets.symmetric(vertical: 12),
                         decoration: const ShapeDecoration(
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.all(
                               Radius.circular(4),
                             ),
                           ),
                             color: blueColor,
                           ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Flexible(child: Container(), flex: 2,),
                    
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Container(
                              child: const Text('Dont have an account?'),
                              padding: const EdgeInsets.symmetric(vertical: 8),

                           ),
                            GestureDetector(
                              onTap: navigatetoSignup,
                              child: Container(
                                child: const Text('Sign up',
                                 style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                 ),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                
                                                       ),
                            ),
                        ],
                    ),
               ], 
             ),
          ),
         
         ),
    );
  }
}