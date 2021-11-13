import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/game.dart';
import 'package:test_build/domain/gameDetail.dart';
import 'package:test_build/domain/player.dart';
import 'package:test_build/domain/teams.dart';
import 'package:test_build/repository/auth_repository.dart';

/// ログインしているユーザーを操作する
class TeamsRepository {
  static TeamsRepository _instance;

  TeamsRepository._();

  static TeamsRepository get instance {
    if (_instance == null) {
      _instance = TeamsRepository._();
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

  ///ユーザー情報に更新があったらに呼び出す。
  Future<void> _updateLocalCache() async {
    final id = _auth.firebaseUser?.uid;
    if (id == null) {
      return null;
    }
    final doc = await _firestore.collection('teams').doc(id).get();
    if (!doc.exists) {
      print("user not found");
    }
    _teams = Team(doc);
  }

  void deleteLocalCache() {
    _teams = null;
  }

  Future<Team> getTeam({Team team}) async {
    final doc = await _firestore.collection("teams").doc(team.uid).get();
    final _team = Team(doc);
    return _team;
  }

  /// Firestoreにユーザーを登録する
  Future<void> registerTeam(
      {String uid, String displayName, String email, String userID}) async {
    await _firestore.collection('teams').doc(uid).set(
      {
        "teamName": displayName,
        "email": email,
        "createdAt": Timestamp.now(),
        "uid": uid,
      },
    );
  }

  Future<void> updateTeamName({String teamName, Team team}) async {
    _firestore.collection('teams').doc(team.uid).update(
      {
        'teamName': teamName,
      },
    );
    _updateLocalCache();
  }

  Future<List<Categorys>> getCategory() async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(_teams.uid)
        .collection("category")
        .orderBy('createdAt', descending: true)
        .get();
    final teamsList = snapshot.docs.map((doc) => Categorys(doc)).toList();
    return teamsList;
  }

  Future<void> addCategory(String category, Team teams) async {
    _firestore.collection('teams').doc(teams.uid).collection('category').add(
      {
        'categoryName': category,
        'createdAt': Timestamp.now(),
      },
    );
  }

  Future<void> deleteCategory({Team team, Categorys category}) async {
    _firestore
        .collection('teams')
        .doc(team.uid)
        .collection('category')
        .doc(category.uid)
        .delete();
  }

  Future<void> updateCategory(
      {String categoryName, Team team, Categorys category}) async {
    _firestore
        .collection('teams')
        .doc(team.uid)
        .collection('category')
        .doc(category.uid)
        .update(
      {
        'categoryName': categoryName,
      },
    );
  }

  Future<List<Player>> getPlayer(Categorys category) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection("player")
        .orderBy('uniformNumber', descending: false)
        .get();
    final playerList = snapshot.docs.map((doc) => Player(doc)).toList();
    return playerList;
  }

  Future<List<Player>> getGK(Categorys category) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection("player")
        .where('position', isEqualTo: 'GK')
        .orderBy('uniformNumber', descending: false)
        .get();
    final playerList = snapshot.docs.map((doc) => Player(doc)).toList();
    return playerList;
  }

  Future<List<Player>> getFP(Categorys category) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection("player")
        .where('position', isEqualTo: 'FP')
        .orderBy('uniformNumber', descending: false)
        .get();
    final playerList = snapshot.docs.map((doc) => Player(doc)).toList();
    return playerList;
  }

  Future<void> addPlayer(int uniformNumber, String playerName, String position,
      Categorys category) async {
    _firestore
        .collection('teams')
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection('player')
        .add(
      {
        'uniformNumber': uniformNumber,
        'playerName': playerName,
        'position': position,
        'createdAt': Timestamp.now(),
        'shoot': 0,
        'goal': 0,
        'scored': 0,
        'shot': 0,
        'participation': 0,
        'shittenParticipation': 0,
        'tokutenParticipation': 0,
      },
    );
  }

  Future<void> updatePlayer(
      {int uniformNumber,
      String playerName,
      String position,
      Categorys category,
      Player player}) async {
    _firestore
        .collection('teams')
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection('player')
        .doc(player.uid)
        .update(
      {
        'uniformNumber': uniformNumber,
        'playerName': playerName,
        'position': position,
        'createdAt': Timestamp.now(),
      },
    );
  }

  Future<void> deletePlayer(
      {Team team, Categorys category, Player player}) async {
    _firestore
        .collection('teams')
        .doc(team.uid)
        .collection('category')
        .doc(category.uid)
        .collection('player')
        .doc(player.uid)
        .delete();
  }

  Future<List<Game>> getGame(Categorys category) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection("game")
        .orderBy('gameDate', descending: false)
        .get();
    final gameList = snapshot.docs.map((doc) => Game(doc)).toList();
    return gameList;
  }

  Future<void> addGame(
      DateTime gameDate, String opponentName, Categorys category) async {
    _firestore
        .collection('teams')
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection('game')
        .add(
      {
        'gameDate': Timestamp.fromDate(gameDate),
        'opponentName': opponentName,
        'createdAt': Timestamp.now(),
        'tokuten': 0,
        'shitten': 0,
        'allShoot': 0,
        'allShot': 0,
        'teamsUid': _teams.uid,
        'category': category.categoryName,
      },
    );
  }

  Future<void> finishInputGame(Categorys category, Game game) async {
    _firestore
        .collection('teams')
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection('game')
        .doc(game.uid)
        .update(
      {
        'firstUpdate': false,
      },
    );
  }

  Future<void> updateGame(
      {DateTime gameDate,
      String opponentName,
      Categorys category,
      Game game}) async {
    _firestore
        .collection('teams')
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection('game')
        .doc(game.uid)
        .update(
      {
        'gameDate': Timestamp.fromDate(gameDate),
        'opponentName': opponentName,
      },
    );
  }

  Future<void> deleteGame({Team team, Categorys category, Game game}) async {
    _firestore
        .collection('teams')
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection('game')
        .doc(game.uid)
        .delete();
  }

  Future<void> incrementTokuten(
      Categorys category, Game game, String half, int time) async {
    final ref = _firestore
        .collection("teams")
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection("game")
        .doc(game.uid);
    final snapshot = await ref.get();
    if (snapshot.exists) {
      if (half == '前半') {
        await ref.update({
          'firstTokuten': FieldValue.increment(1),
          'tokutenTime': FieldValue.arrayUnion([time]),
        });
      } else {
        await ref.update({
          'secondTokuten': FieldValue.increment(1),
          'tokutenTime': FieldValue.arrayUnion([time]),
        });
      }
    }
  }

  Future<void> incrementShitten(
      Categorys category, Game game, String half, int time) async {
    final ref = _firestore
        .collection("teams")
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection("game")
        .doc(game.uid);
    final snapshot = await ref.get();
    if (snapshot.exists) {
      if (half == '前半') {
        await ref.update({
          'firstShitten': FieldValue.increment(1),
          'shittenTime': FieldValue.arrayUnion([time]),
        });
      } else {
        await ref.update({
          'secondShitten': FieldValue.increment(1),
          'ShittenTime': FieldValue.arrayUnion([time]),
        });
      }
    }
  }

  Future<List<GameDetail>> getGameDetail(Categorys category, Game game) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection("game")
        .doc(game.uid)
        .collection('detail')
        .orderBy('scoreTime', descending: false)
        .get();
    final gameDetailList = snapshot.docs.map((doc) => GameDetail(doc)).toList();
    return gameDetailList;
  }

  Future<void> addTokutenDetail(
      int time,
      String tokutenTime,
      String tokutenPlayer,
      String tokutenPattern,
      Categorys category,
      Game game) async {
    _firestore
        .collection('teams')
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection('game')
        .doc(game.uid)
        .collection('detail')
        .add(
      {
        'rnrs': '得点',
        'scoreTime': time,
        'tokutenTime': tokutenTime,
        'tokutenPlayer': tokutenPlayer,
        'tokutenPattern': tokutenPattern,
        'teamUid': _teams.uid,
        'categoryUid': category.uid,
        'gameUid': game.uid,
      },
    );
  }

  Future<void> addShittenDetail(int time, String shittenTime,
      String shittenPattern, Categorys category, Game game) async {
    _firestore
        .collection('teams')
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection('game')
        .doc(game.uid)
        .collection('detail')
        .add(
      {
        'rnrs': '失点',
        'scoreTime': time,
        'shittenTime': shittenTime,
        'shittenPattern': shittenPattern,
        'teamUid': _teams.uid,
        'categoryUid': category.uid,
        'gameUid': game.uid,
      },
    );
  }

  Future<void> deleteDetail(
      {Team team, Categorys category, Game game, GameDetail gameDetail}) async {
    _firestore
        .collection('teams')
        .doc(team.uid)
        .collection('category')
        .doc(category.uid)
        .collection('game')
        .doc(game.uid)
        .collection('detail')
        .doc(gameDetail.uid)
        .delete();
  }

  Future<void> addGameFP(
      {Categorys category,
      Game game,
      Player player,
      int goal,
      int shoot,
      int participation,
      int tokutenParticipation,
      int shittenParticipation}) async {
    _firestore
        .collection('teams')
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection('game')
        .doc(game.uid)
        .collection('player')
        .doc(player.uid)
        .set(
      {
        'uniformNumber': player.uniformNumber,
        'playerName': player.playerName,
        'position': player.position,
        'shoot': shoot,
        'goal': goal,
        'participation': participation,
        'teamUid': _teams.uid,
        'categoryUid': category.uid,
        'gameUid': game.uid,
        'playerUid': player.uid,
        'tokutenParticipation': tokutenParticipation,
        'shittenParticipation': shittenParticipation
      },
    );
  }

  Future<void> addGameGK({
    Categorys category,
    Game game,
    Player player,
    int scored,
    int shot,
    int participation,
    int shoot,
    int goal,
  }) async {
    _firestore
        .collection('teams')
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection('game')
        .doc(game.uid)
        .collection('player')
        .doc(player.uid)
        .set(
      {
        'uniformNumber': player.uniformNumber,
        'playerName': player.playerName,
        'position': player.position,
        'shot': shot,
        'scored': scored,
        'shoot': shoot,
        'goal': goal,
        'participation': participation,
        'teamUid': _teams.uid,
        'categoryUid': category.uid,
        'gameUid': game.uid,
        'playerUid': player.uid,
      },
    );
  }

  Future<List<Player>> getGamePlayer(Categorys category, Game game) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(_teams.uid)
        .collection('category')
        .doc(category.uid)
        .collection("game")
        .doc(game.uid)
        .collection('player')
        .orderBy('uniformNumber', descending: false)
        .get();
    final playerList = snapshot.docs.map((doc) => Player(doc)).toList();
    return playerList;
  }

  Future<List<Player>> getGameFP(
      {Team team, Categorys category, Game game}) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(team.uid)
        .collection('category')
        .doc(category.uid)
        .collection("game")
        .doc(game.uid)
        .collection('player')
        .where('position', isEqualTo: 'FP')
        .orderBy('uniformNumber', descending: false)
        .get();
    final playerList = snapshot.docs.map((doc) => Player(doc)).toList();
    return playerList;
  }

  Future<List<Player>> getGameGK(
      {Team team, Categorys category, Game game}) async {
    final snapshot = await _firestore
        .collection("teams")
        .doc(team.uid)
        .collection('category')
        .doc(category.uid)
        .collection("game")
        .doc(game.uid)
        .collection('player')
        .where('position', isEqualTo: 'GK')
        .orderBy('uniformNumber', descending: false)
        .get();
    final playerList = snapshot.docs.map((doc) => Player(doc)).toList();
    return playerList;
  }
}
