import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/game.dart';
import 'package:test_build/domain/gameDetail.dart';
import 'package:test_build/domain/player.dart';
import 'package:test_build/domain/teams.dart';
import 'package:test_build/repository/auth_repository.dart';

class AnalysisRepository {
  static AnalysisRepository _instance;

  AnalysisRepository._();

  static AnalysisRepository get instance {
    if (_instance == null) {
      _instance = AnalysisRepository._();
    }
    return _instance;
  }

  final _firestore = FirebaseFirestore.instance;
  final _auth = AuthRepository.instance;

  Team _teams;

  Future<Team> fetch() async {
    if (_teams == null) {
      final id = _auth.firebaseUser?.uid;
      if (id == null) {
        return null;
      }
      final doc = await _firestore.collection('teams').doc(id).get();
      if (!doc.exists) {
        print("team not found");
      }
      _teams = Team(doc);
    }
    return _teams;
  }

  Future<List<GameDetail>> getAllDetail(Team team, Categorys category) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(team.uid)
        .collection('category')
        .doc(category.uid)
        .collection("game")
        .get();
    final gameList = snapshot.docs.map((doc) => Game(doc)).toList();

    List<GameDetail> allGameDetail = [];
    for (Game game in gameList) {
      final snapshot = await _firestore
          .collection("teams")
          .doc(team.uid)
          .collection('category')
          .doc(category.uid)
          .collection("game")
          .doc(game.uid)
          .collection('detail')
          .orderBy('scoreTime', descending: false)
          .get();
      final gameDetailList =
          snapshot.docs.map((doc) => GameDetail(doc)).toList();
      for (GameDetail gameDetail in gameDetailList) {
        allGameDetail.add(gameDetail);
      }
    }
    return allGameDetail;
  }

  Future<List<Player>> getShootRankingPlayer(
      Team team, Categorys category) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(team.uid)
        .collection('category')
        .doc(category.uid)
        .collection("player")
        .orderBy('shoot', descending: true)
        .get();
    final playerList = snapshot.docs.map((doc) => Player(doc)).toList();
    return playerList;
  }

  Future<Player> getShootKing(Team team, Categorys category) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(team.uid)
        .collection('category')
        .doc(category.uid)
        .collection("player")
        .orderBy('shoot', descending: true)
        .limit(1)
        .get();
    final playerList = snapshot.docs.map((doc) => Player(doc)).toList();
    final shootKing = playerList.first;
    return shootKing;
  }

  Future<List<Player>> getGoalRankingPlayer(
      Team team, Categorys category) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(team.uid)
        .collection('category')
        .doc(category.uid)
        .collection("player")
        .orderBy('goal', descending: true)
        .get();
    final playerList = snapshot.docs.map((doc) => Player(doc)).toList();
    return playerList;
  }

  Future<Player> getGoalKing(Team team, Categorys category) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(team.uid)
        .collection('category')
        .doc(category.uid)
        .collection("player")
        .orderBy('goal', descending: true)
        .limit(1)
        .get();
    final playerList = snapshot.docs.map((doc) => Player(doc)).toList();
    final goalKing = playerList.first;
    return goalKing;
  }

  Future<List<Player>> getGKPlayer(Team team, Categorys category) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(team.uid)
        .collection('category')
        .doc(category.uid)
        .collection("player")
        .where('position', isEqualTo: 'GK')
        .get();
    final playerList = snapshot.docs.map((doc) => Player(doc)).toList();
    return playerList;
  }

  Future<List<Player>> getShotRankingPlayer(
      Team team, Categorys category) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(team.uid)
        .collection('category')
        .doc(category.uid)
        .collection("player")
        .where('position', isEqualTo: 'GK')
        .orderBy('shot', descending: true)
        .get();
    final playerList = snapshot.docs.map((doc) => Player(doc)).toList();
    return playerList;
  }

  Future<List<Player>> getScoredRankingPlayer(
      Team team, Categorys category) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(team.uid)
        .collection('category')
        .doc(category.uid)
        .collection("player")
        .where('position', isEqualTo: 'GK')
        .orderBy('scored', descending: true)
        .get();
    final playerList = snapshot.docs.map((doc) => Player(doc)).toList();
    return playerList;
  }
}
