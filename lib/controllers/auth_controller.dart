import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopdde/global_variables.dart';
import 'package:shopdde/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shopdde/services/manage_http_response.dart';
import 'package:shopdde/views/screens/authentication_screens/login_screen.dart';

import '../views/screens/main_screen.dart';

class AuthController{
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  })async{
    try{
      User user = User(id: '', fullName: fullName, email: email, province: '', city: '', locality: '', password: password, token: '');
        http.Response response = await  http.post(Uri.parse('$uri/api/signup'),
        body:user.toJson() ,//covert the user Object to Json for the request body

    headers: <String, String>{ //set the headers for request
    "Content-Type" : 'application/json; charset=UTF-8', //specify the context type of json

    });

    manageHttpResponse(response: response, context: context, onSuccess: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
      showSnackBar(context, 'Account has been created');
    });
    }catch (e) {
      print("Error: $e");
    }

    }

    ///signin user function

  Future<void> signInUsers({
    required context,
    required String email,
    required String password}) async {
    try{
     http.Response response =  await http.post(
          Uri.parse("$uri/api/signin"),
          body: jsonEncode(
              {
                'email': email, //include the email in the request body
                'password': password, //include the password in the request body
              },
          ),
          headers: <String,String>{ //this will set the header
            'Content-Type': 'application/json; charset=UTF-8',
          });

      //handle the response using the managehttpresponse

      manageHttpResponse(response: response, context: context, onSuccess: () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainScreen()),(route)=>false);
        showSnackBar(context, 'Logged In');
      });

    }catch (e) {
      print("Error: $e");
    }
  }
}
