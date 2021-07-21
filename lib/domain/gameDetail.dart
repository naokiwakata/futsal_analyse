import 'package:cloud_firestore/cloud_firestore.dart';

class GameDetail {
  String uid;
  String rnrs;
  String tokutenPattern;
  String shittenPattern;
  String tokutenTime;
  String shittenTime;
  String tokutenPlayer;
  int scoreTime;

  GameDetail(DocumentSnapshot doc) {
    uid = doc.id;
    rnrs = doc.data()['rnrs'];
    tokutenPattern = doc.data()['tokutenPattern'];
    shittenPattern = doc.data()['shittenPattern'];
    tokutenTime = doc.data()['tokutenTime'];
    shittenTime = doc.data()['shittenTime'];
    tokutenPlayer = doc.data()['tokutenPlayer'];
    scoreTime = doc.data()['scoreTime'];
  }
}
