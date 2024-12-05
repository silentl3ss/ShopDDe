import 'package:shopdde/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends StateNotifier<User?> {
  //contructore initializing with default User Object
  //purpose : Manage the state of the user object allowing updates
  UserProvider() : super(User(id: '',
      fullName: '',
      email: '',
      province: '',
      city: '',
      locality: '',
      password: '',
      token: ''));

  //Getter method to extract value from an object

  User? get user => state;

  //method to set user state from json
//purpose: updates the user state base on json String representation of user Object


  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

  //Method to clear user state
  void signOut() {
    state = null;
  }
}





//make the data accisible within the application
final userProvider = StateNotifierProvider<UserProvider,User?>((ref)=> UserProvider());