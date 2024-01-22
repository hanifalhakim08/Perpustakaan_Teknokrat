import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class FirestoreController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final DatabaseReference dbTeklib = FirebaseDatabase.instance.ref();
  
  Future<String> Borrow(
    String userId,
    String bookId,
  ) async{
    var result = "";
    try{
      await dbTeklib.child("borrowings").child(userId).set({
        "borrow_id" : randomAlphaNumeric(15),
        "book_id" : bookId,
        "time_borrow" : "1:week",
        "time_left" : "",
      }).then((value) => result = "Success");
      return result;
    }catch(e){
      print(e);
    }
    return result;
  }
}
