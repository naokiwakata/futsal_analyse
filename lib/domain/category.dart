import 'package:cloud_firestore/cloud_firestore.dart';

class Categorys {
  String uid;
  String categoryName;

  Categorys(DocumentSnapshot doc) {
    uid = doc.id;
    categoryName = doc.data()['categoryName'];
  }
}
