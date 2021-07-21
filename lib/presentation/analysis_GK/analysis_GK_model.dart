import 'package:flutter/material.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/game.dart';
import 'package:test_build/domain/player.dart';
import 'package:test_build/domain/teams.dart';
import 'package:test_build/repository/analysis_repository.dart';
import 'package:test_build/repository/teams_repository.dart';

class AnalysisGKRankingModel extends ChangeNotifier {
  final _teamsRepository = TeamsRepository.instance;
  List<Game> gameList = [];
  int games = 0;
  List<Player> shotList = [];
  List<Player> scoredList = [];
  List<Player> saveRateList = [];
  Team team;
  Categorys category;
  String uniformNumber = "";
  String playerName = "";
  final _analysisRepository = AnalysisRepository.instance;
  bool loadingData = false;
  String ranking = 'shoot';

  Future initState(Categorys category) async {
    startLoading();
    this.category = category;
    team = await _teamsRepository.fetch();
    gameList = await _teamsRepository.getGame(category);
    games = gameList.length;
    print(team.uid);
    await getShotRanking();
    getScoredRanking();
    getSaveRateRanking();
    endLoading();

    notifyListeners();
  }

  Future getShotRanking() async {
    startLoading();
    shotList = await _analysisRepository.getShotRankingPlayer(team, category);
    ranking = 'shot';
    print(ranking);
    endLoading();
    notifyListeners();
  }

  Future getScoredRanking() async {
    startLoading();
    scoredList =
        await _analysisRepository.getScoredRankingPlayer(team, category);
    ranking = 'scored';
    print(ranking);
    endLoading();
    notifyListeners();
  }

  Future getSaveRateRanking() async {
    startLoading();
    saveRateList =
        await _analysisRepository.getShotRankingPlayer(team, category);
    saveRateList.sort(
      (b, a) => (a.shot != 0 ? a.scored / a.shot * 100 : 0).round().compareTo(
            (b.shot != 0 ? b.scored / b.shot * 100 : 0).round(),
          ),
    );
    ranking = 'saveRate';
    print(ranking);
    endLoading();

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
