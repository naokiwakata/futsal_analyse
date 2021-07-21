import 'package:cloud_firestore/cloud_firestore.dart';

class Game {
  String uid;
  String opponentName;
  Timestamp gameDate;
  int tokuten;
  int shitten;
  int allShoot;
  int allShot;

  Game(DocumentSnapshot doc) {
    uid = doc.id;
    opponentName = doc.data()['opponentName'];
    gameDate = doc.data()['gameDate'];
    tokuten = doc.data()['tokuten'];
    shitten = doc.data()['shitten'];
    allShoot = doc.data()['allShoot'];
    allShot = doc.data()['allShot'];
  }
}
