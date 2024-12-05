import 'package:flutter/material.dart';
import 'package:shopdde/controllers/auth_controller.dart';


class AccountScreen extends StatelessWidget {
   AccountScreen({super.key});
  final AuthController _authController = AuthController();

  @override
  Widget build (BuildContext context){
    return Center(
      child: ElevatedButton(
          onPressed: () async{
        await _authController.signOutUSer(context: context);
      }, child: Text('Signout ')));



  }
}

