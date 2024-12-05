import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopdde/global_variables.dart';
import 'package:shopdde/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shopdde/provider/user_provider.dart';
import 'package:shopdde/services/manage_http_response.dart';
import 'package:shopdde/views/screens/authentication_screens/login_screen.dart';

import '../views/screens/main_screen.dart';

final providerContainer = ProviderContainer();

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(id: '',
          fullName: fullName,
          email: email,
          province: '',
          city: '',
          locality: '',
          password: password,
          token: '');
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          //covert the user Object to Json for the request body

          headers: <String, String>{
            //set the headers for request
            "Content-Type": 'application/json; charset=UTF-8',
            //specify the context type of json

          });

      manageHttpResponse(response: response, context: context, onSuccess: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        showSnackBar(context, 'Account has been created');
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  ///signin user function

  Future<void> signInUsers({
    required context,
    required String email,
    required String password}) async {
    try {
      http.Response response = await http.post(
          Uri.parse("$uri/api/signin"),
          body: jsonEncode(
            {
              'email': email, //include the email in the request body
              'password': password, //include the password in the request body
            },
          ),
          headers: <String, String>{ //this will set the header
            'Content-Type': 'application/json; charset=UTF-8',
          });

      //handle the response using the managehttpresponse

      manageHttpResponse(
          response: response, context: context, onSuccess: () async {
        //Access sharedPreferences for token and user data storage

        SharedPreferences preferences = await SharedPreferences.getInstance();

        //Exact the authentication token from the response body
        String token = jsonDecode(response.body)['token'];

        //STORE the authentication token securely in sharedPreferences

        await preferences.setString('auth_token', token);

        //Encode the user data received from the backend as json
        final userJson = jsonEncode(jsonDecode(response.body)['user']);

        //update the application state with the user data using Riverpod
        providerContainer.read(userProvider.notifier).setUser(userJson);

        //store the data in sharedPreferences for future use

        await preferences.setString('user', userJson);

        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => MainScreen()), (
            route) => false);
        showSnackBar(context, 'Logged In');
      });
    } catch (e) {

    }
  }

  // SignOut
  Future<void> signOutUSer({required context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //clear the token and user from SharedPreferenace
      await preferences.remove('auth_token');
      await preferences.remove('user');
      //clear the user state
      providerContainer.read(userProvider.notifier).signOut();

      //navigate the user back to the login screen

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }), (route) => false);

      showSnackBar(context, 'signout successfully');
    } catch (e) {
      showSnackBar(context, "error signing out");
    }
  }
}





