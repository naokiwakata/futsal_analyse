import 'package:flutter/material.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/game.dart';
import 'package:test_build/domain/teams.dart';
import 'package:test_build/repository/teams_repository.dart';

class AnalyseGoalShootModel extends ChangeNotifier {
  final _teamsRepository = TeamsRepository.instance;
  Team team;
  Categorys category;
  bool loadingData = false;
  List<Game> gameList = [];
  int allTokuten = 0;
  int allShitten = 0;
  int allShoot = 0;
  int allShot = 0;
  int gameNumber = 0;

  double avgTokuten = 0;
  double avgShitten = 0;
  double avgShoot = 0;
  double avgShot = 0;

  List<GameData> tokutenList = [];
  List<GameData> shittenList = [];
  List<GameData> shootList = [];
  List<GameData> shotList = [];

  void startLoading() {
    loadingData = true;
    notifyListeners();
  }

  void endLoading() {
    loadingData = false;
    notifyListeners();
  }

  Future initState(Categorys category) async {
    startLoading();
    this.category = category;
    team = await _teamsRepository.fetch();
    print(team.uid);
    gameList = await _teamsRepository.getGame(category);
    print(gameList);
    if (gameList.isNotEmpty) {
      countScore();
      calculateAvg();
    }
    endLoading();
    notifyListeners();
  }

  void countScore() {
    for (Game game in gameList) {
      gameNumber++;
      allTokuten = allTokuten + game.tokuten;
      allShitten = allShitten + game.shitten;
      allShoot = allShoot + game.allShoot;
      allShot = allShot + game.allShot;
      final tokutenData = GameData(game.opponentName, game.tokuten);
      tokutenList.add(tokutenData);
      final shittenData = GameData(game.opponentName, game.shitten);
      shittenList.add(shittenData);
      final shootData = GameData(game.opponentName, game.allShoot);
      shootList.add(shootData);
      final shotData = GameData(game.opponentName, game.allShot);
      shotList.add(shotData);
    }
    notifyListeners();
  }

  int baseNumber = 10;

  void calculateAvg() {
    avgTokuten = ((allTokuten / gameNumber) * baseNumber.ceil()) / baseNumber;
    avgShitten = ((allShitten / gameNumber) * baseNumber.ceil()) / baseNumber;
    avgShoot = ((allShoot / gameNumber) * baseNumber.ceil()) / baseNumber;
    avgShot = ((allShot / gameNumber) * baseNumber.ceil()) / baseNumber;
    notifyListeners();
  }
}

class GameData {
  String opponentName;
  int number;

  GameData(this.opponentName, this.number);
}
