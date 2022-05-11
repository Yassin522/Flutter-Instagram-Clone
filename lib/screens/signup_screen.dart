import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/resources/auth_methods.dart';
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
                   const SizedBox(height: 45),

                   Stack(
                     children: [
                       
                       _image!=null? CircleAvatar(
                         radius: 64,
                         backgroundImage: MemoryImage(_image!),
                       )
 
                       :const CircleAvatar(
                           radius: 64,
                          backgroundImage: NetworkImage('https://www.bing.com/images/search?view=detailV2&ccid=VvvX4Ug%2f&id=6004B5D6FC0BF58B3E1CD6EA5BBB82D86933A747&thid=OIP.VvvX4Ug_y6j3qz2l5aJIMAAAAA&mediaurl=https%3a%2f%2ft4.ftcdn.net%2fjpg%2f00%2f64%2f67%2f63%2f240_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.56fbd7e1483fcba8f7ab3da5e5a24830%3frik%3dR6czadiCu1vq1g%26pid%3dImgRaw%26r%3d0&exph=240&expw=240&q=default+profile+picture&simid=607993599340857076&FORM=IRPRST&ck=536F607540E3259593D8A3B4CCFF8373&selectedIndex=12'),
                          backgroundColor: Colors.white,
                        ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                             onPressed: (){},
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
                   const SizedBox(height: 20),

                  TextFieldInput(
                    textEditingController: _emailController,
                     hintText: 'Enter your email', 
                     textInputType: TextInputType.emailAddress,
                    ),
                   const SizedBox(height: 20),
                     TextFieldInput(
                    textEditingController: _passwordController,
                     hintText: 'Enter your password', 
                     textInputType: TextInputType.emailAddress,
                     isPass: true,
                    ),
                    const SizedBox(height: 20),

                   TextFieldInput(
                    textEditingController: _bioController,
                     hintText: 'Enter your bio', 
                     textInputType: TextInputType.text,
                    ),
                   

                    const SizedBox(height: 20),

                    InkWell(
                      onTap: () async {
                        String res= await AuthMethods().signUpUser(
                        
                        email: _emailController.text,
                         password: _passwordController.text,
                          username: _usernameController.text,
                           bio: _bioController.text,
                           
                           );
                           print(res);
                      },

                      child: Container(
                         child: const Text('Sign up'),
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
                              child: const Text('Dont have an account?'),
                              padding: const EdgeInsets.symmetric(vertical: 8),

                           ),
                            GestureDetector(
                              onTap: (){},
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