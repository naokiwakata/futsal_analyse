import 'package:flutter/material.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/game.dart';
import 'package:test_build/domain/player.dart';
import 'package:test_build/domain/teams.dart';
import 'package:test_build/repository/analysis_repository.dart';
import 'package:test_build/repository/teams_repository.dart';

class AnalysisParticipationModel extends ChangeNotifier {
  final _teamsRepository = TeamsRepository.instance;
  List<Game> gameList = [];
  int games = 0;
  Team team;
  Categorys category;
  String uniformNumber = "";
  String playerName = "";
  final _analysisRepository = AnalysisRepository.instance;
  List<Player> allPlayerList = [];
  List<Player> shittenParticipationList = [];
  List<Player> participationList = [];
  List<Player> tokutenParticipationList = [];
  bool loadingData = false;
  String ranking = 'shoot';

  Future initState(Categorys category) async {
    startLoading();
    this.category = category;
    team = await _teamsRepository.fetch();
    gameList = await _teamsRepository.getGame(category);
    games = gameList.length;
    await getParticipationRanking();
    getTokutenParticipationRank();
    getShittenParticipationRank();
    endLoading();

    notifyListeners();
  }

  Future getParticipationRanking() async {
    participationList =
        await _analysisRepository.getShootRankingPlayer(team, category);
    participationList
        .sort((b, a) => (a.participation).compareTo(b.participation));
    notifyListeners();
  }

  Future getTokutenParticipationRank() async {
    tokutenParticipationList =
        await _analysisRepository.getShootRankingPlayer(team, category);
    tokutenParticipationList.sort(
        (b, a) => (a.tokutenParticipation).compareTo(b.tokutenParticipation));
    notifyListeners();
  }

  Future getShittenParticipationRank() async {
    shittenParticipationList =
        await _analysisRepository.getShootRankingPlayer(team, category);
    shittenParticipationList.sort(
        (b, a) => (a.shittenParticipation).compareTo(b.shittenParticipation));

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
