import 'package:cloud_firestore/cloud_firestore.dart';

class Team {
  String uid;
  String teamName;

  Team(DocumentSnapshot doc) {
    uid = doc.id;
    teamName = doc.data()['teamName'];
  }
}
