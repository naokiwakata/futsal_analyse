import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart';
import 'package:test_build/repository/auth_repository.dart';
import 'package:test_build/repository/teams_repository.dart';

class DummyTopModel extends ChangeNotifier {
  int currentIndex = 0;
  final authRepository = AuthRepository.instance;
  final teamRepository = TeamsRepository.instance;
  var token;

  Future initState() async {
    token = await FCMConfig.messaging.getToken();
    final team = await teamRepository.fetch();
    if(team!=null){
      await FirebaseFirestore.instance.collection('teams').doc(team.uid).update({
        'tokens': FieldValue.arrayUnion([token]),
      });
      print(token);
    }
    notifyListeners();
  }

  void onTabTapped(int index) async {
    currentIndex = index;

    notifyListeners();
  }
}
