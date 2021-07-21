import 'package:flutter/material.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/game.dart';
import 'package:test_build/domain/player.dart';
import 'package:test_build/domain/teams.dart';
import 'package:test_build/repository/analysis_repository.dart';
import 'package:test_build/repository/auth_repository.dart';
import 'package:test_build/repository/teams_repository.dart';

class AnalyseWholeModel extends ChangeNotifier {
  int currentIndex = 0;
  final authRepository = AuthRepository.instance;
  Team team;
  Categorys category;
  bool loadingData = false;
  final _teamsRepository = TeamsRepository.instance;
  final _analysisRepository = AnalysisRepository.instance;
  List<Game> gameList;
  int games;
  int win = 0;
  int lose = 0;
  int draw = 0;
  double winRate = 0;
  Player goalKing;

  Player shootKing;
  int allTokuten = 0;
  int allShitten = 0;
  int allShoot = 0;
  int allShot = 0;

  Future initState(Categorys category) async {
    startLoading();
    this.category = category;
    team = await _teamsRepository.fetch();
    gameList = await _teamsRepository.getGame(category);
    games = gameList.length;
    if (gameList.isNotEmpty) {
      await getGoalKing();
      await getShootKing();
      countScore();
    }
    endLoading();

    notifyListeners();
  }

  Future getShootKing() async {
    shootKing = await _analysisRepository.getShootKing(team, category);

    notifyListeners();
  }

  Future getGoalKing() async {
    goalKing = await _analysisRepository.getGoalKing(team, category);
    notifyListeners();
  }

  void countScore() {
    for (Game game in gameList) {
      allTokuten = allTokuten + game.tokuten;
      allShitten = allShitten + game.shitten;
      allShoot = allShoot + game.allShoot;
      allShot = allShot + game.allShot;
      if (game.tokuten < game.shitten) {
        lose++;
      } else if (game.tokuten == game.shitten) {
        draw++;
      } else if (game.tokuten > game.shitten) {
        win++;
      }
    }
    calculateWinRate();
    notifyListeners();
  }

  void calculateWinRate() {
    winRate = win / games * 100.round();
    notifyListeners();
  }

  void onTabTapped(int index) async {
    currentIndex = index;

    notifyListeners();
  }

  void startLoading() {
    loadingData = true;
    notifyListeners();
  }

  void endLoading() {
    loadingData = false;
    notifyListeners();
  }
}
