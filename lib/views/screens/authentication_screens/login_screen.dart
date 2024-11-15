import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopdde/views/screens/authentication_screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Center(
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
            
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login Your Account",
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: const Color(0xFF0d120E),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'To have a best experience',
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: const Color(0xFF0d120E),
                      fontSize: 14,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/logingraphic.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Email',
                        style: GoogleFonts.getFont(
                          'Nunito Sans',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'enter your email';
                        }else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        labelText: 'Enter your email',
                        labelStyle: GoogleFonts.getFont(
                          "Nunito Sans",
                          fontSize: 14,
                          letterSpacing: 0.1,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/icons/email.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Password',
                        style: GoogleFonts.getFont(
                          'Nunito Sans',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                  // Remove the extra SizedBox here
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'enter your password';
                        }else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        labelText: 'Enter your password',
                        labelStyle: GoogleFonts.getFont(
                          "Nunito Sans",
                          fontSize: 14,
                          letterSpacing: 0.1,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/icons/password.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        suffixIcon: const Icon(Icons.visibility),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        print('pass');
                      }else{
                        print('failed');
                      }
                    },
                    child: Container(
                      width: 259,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF102DE1),
                            Color(0xCC0D6EFF),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: GoogleFonts.getFont(
                            'Nunito Sans',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
            
                  SizedBox(height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Need an Account?',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
            
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return RegisterScreen();
            
            
                        }));
                      },
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.roboto(
                          color: Color(0xFF103DE5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],)
            
            
            
            
            
            
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
