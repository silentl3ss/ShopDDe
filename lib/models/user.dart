import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class User {
  //Define fields
  final String id;
  final String fullName;
  final String email;
  final String province;
  final String city;
  final String locality;
  final String password;

  User(
      {required this.id, required this.fullName, required this.email, required this.province, required this.city, required this.locality, required this.password});

  //Serialization: Covert User object to a Map
  //Map: A Map is a collection of Key-value pairs
  //Why: Coverting to a Map is an intermediate step that makes it easier to serialize
  //the object to formates like Json for storage or transmission

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      'fullName': fullName,
      'email': email,
      'province': province,
      'city': city,
      'locality': locality,
      'password': password,
    };
  }

  //Serialization: Covert Map to a Json String
  //This method directly encodes the data from Map into a JSon string

  //The Json.encode() function coverts a Dart object (such as Map or List)
  //into a Json String reprensentation,making it  suitable for communication
  //between different systems.

  String toJson() => json.encode(toMap());

  //Deserialization: Covert a Map to a User Object
  //purpose - Manipulation and user: Once the data is coverted to a User object
  //it can be easily manipuated and use within the application.
  //For ex: we might want to display the user's fullName, email etc on the UI or we might
 //want to save the data locally.


  //The factory contructor takes a Map(Usually obtained from a Jsonobject)
  //and coverts it into a User object . If a field is not presend in the ,
  //it defaults to an empty string

  //fromMap: This constructor take a Map<String, dynamic> and coverts into a User Object
  //its useful when you already have the data in map format
  factory User.fromMap(Map<String, dynamic>map){
    return  User(
      id: map['_id'] as String? ??"",
      fullName: map['fullName'] as String? ??"",
      email: map['email'] as String? ??"",
      province: map['province'] as String? ??"",
      city: map['city'] as String? ??"",
      locality: map['locality'] as String? ??"",
      password: map['password'] as String? ??"",
    );
  }

  //fromJson: this factory contructor takes Json String, and decodes into a Map<String,dynamic>
  //and then uses fromMap to covert that Map into a User Object.

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);





}






