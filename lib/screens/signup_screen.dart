import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/resources/auth_methods.dart';
import 'package:flutter_instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:flutter_instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:flutter_instagram_clone/responsive/web_screen_layout.dart';
import 'package:flutter_instagram_clone/screens/login_screen.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/utils/util.dart';
import 'package:flutter_instagram_clone/widgets/text_field_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
final TextEditingController _emailController=TextEditingController();
final TextEditingController _passwordController=TextEditingController();
final TextEditingController _bioController=TextEditingController();
final TextEditingController _usernameController=TextEditingController();
Uint8List? _image;
bool _isLoading=false;


   @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async{
    Uint8List im =await pickImage(ImageSource.gallery);
    setState(() {
       _image=im;
    });
  }

  void signUpUser()async {
    setState(() {
      _isLoading=true;
    });

     print('eeeeeeeeeeeeeeeeeee');

      String res= await AuthMethods().signUpUser(
                        
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
       bio: _bioController.text,
       file: _image!,
      );
     
      print(res);
      print('oooooooooooooooo');

    setState(() {
      _isLoading=false;
    });
        
        if(res!='success'){
           showSnackBar(res, context);
        }
        else{
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context)=> const ResponsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                       mobileScreenLayout: MobileScreenLayout(),
                    )
              )
          );

        }
    }

void navigatetoLogin(){
     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
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
                // Flexible(child: Container(), flex: 1,),
                   SvgPicture.asset(
                      'assets/ic_instagram.svg',
                      color:primaryColor,
                      height:64,
                   ),
                   const SizedBox(height: 37),

                   Stack(
                     children: [
                       
                       _image!=null? CircleAvatar(
                         radius: 64,
                         backgroundImage: MemoryImage(_image!),
                       )
 
                       :const CircleAvatar(
                           radius: 64,
                          backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.VvvX4Ug_y6j3qz2l5aJIMAAAAA?w=151&h=169&c=7&r=0&o=5&pid=1.7'),
                          backgroundColor: Colors.white,
                        ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                             onPressed: selectImage,
                             icon: const Icon(Icons.add_a_photo),
                          ), 
                          
                          ),
                     ],
                   ),
                  
                  const SizedBox(height: 20),

                   TextFieldInput(
                    textEditingController: _usernameController,
                     hintText: 'Enter your username', 
                     textInputType: TextInputType.text,
                    ),
                   const SizedBox(height: 15),

                  TextFieldInput(
                    textEditingController: _emailController,
                     hintText: 'Enter your email', 
                     textInputType: TextInputType.emailAddress,
                    ),
                   const SizedBox(height: 15),
                     TextFieldInput(
                    textEditingController: _passwordController,
                     hintText: 'Enter your password', 
                     textInputType: TextInputType.emailAddress,
                     isPass: true,
                    ),
                    const SizedBox(height: 15),

                   TextFieldInput(
                    textEditingController: _bioController,
                     hintText: 'Enter your bio', 
                     textInputType: TextInputType.text,
                    ),
                   

                    const SizedBox(height: 15),

                    InkWell(
                      onTap: signUpUser, 

                      child:  Container(
                         child: _isLoading? 
                          const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                            
                          )
                          :const Text('Sign up'),
                         width: double.infinity,
                         alignment: Alignment.center,
                         padding: const EdgeInsets.symmetric(vertical: 12),
                         decoration: const ShapeDecoration(
                           shape: RoundedRectangleBorder(
                             borderRadius : BorderRadius.all(
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
                              child: const Text('have an account?'),
                              padding: const EdgeInsets.symmetric(vertical: 8),

                           ),
                            GestureDetector(
                              onTap: navigatetoLogin,
                              child: Container(
                                child: const Text('Login',
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