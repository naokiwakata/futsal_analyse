import 'package:flutter/material.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/game.dart';
import 'package:test_build/domain/player.dart';
import 'package:test_build/domain/teams.dart';
import 'package:test_build/repository/analysis_repository.dart';
import 'package:test_build/repository/teams_repository.dart';

class AnalysisFPRankingModel extends ChangeNotifier {
  final _teamsRepository = TeamsRepository.instance;
  List<Game> gameList = [];
  int games = 0;
  Team team;
  Categorys category;
  String uniformNumber = "";
  String playerName = "";
  final _analysisRepository = AnalysisRepository.instance;
  List<Player> allPlayerList = [];
  List<Player> goalRateList = [];
  List<Player> shootList = [];
  List<Player> goalList = [];
  bool loadingData = false;
  String ranking = 'shoot';

  Future initState(Categorys category) async {
    startLoading();
    this.category = category;
    team = await _teamsRepository.fetch();
    gameList = await _teamsRepository.getGame(category);
    games = gameList.length;
    await getShootRanking();
    getGoalRanking();
    getGoalRateRanking();
    endLoading();

    notifyListeners();
  }

  Future getShootRanking() async {
    shootList = await _analysisRepository.getShootRankingPlayer(team, category);

    notifyListeners();
  }

  Future getGoalRanking() async {
    goalList = await _analysisRepository.getGoalRankingPlayer(team, category);
     notifyListeners();
  }

  Future getGoalRateRanking() async {
    goalRateList =
        await _analysisRepository.getShootRankingPlayer(team, category);
    goalRateList.sort(
      (b, a) => (a.shoot != 0 ? a.goal / a.shoot * 100 : 0).round().compareTo(
            (b.shoot != 0 ? b.goal / b.shoot * 100 : 0).round(),
          ),
    );
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
