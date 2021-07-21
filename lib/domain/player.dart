import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  String uid;
  String playerName;
  String position;
  int uniformNumber;
  int goal;
  int shoot;
  int participation;
  int shot;
  int scored;
  int tokutenParticipation;
  int shittenParticipation;

  Player(DocumentSnapshot doc) {
    uid = doc.id;
    position = doc.data()['position'];
    playerName = doc.data()['playerName'];
    uniformNumber = doc.data()['uniformNumber'];
    goal = doc.data()['goal'];
    shoot = doc.data()['shoot'];
    participation = doc.data()['participation'];
    shot = doc.data()['shot'];
    scored = doc.data()['scored'];
    tokutenParticipation = doc.data()['tokutenParticipation'];
    shittenParticipation = doc.data()['shittenParticipation'];
  }
}
