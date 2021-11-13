import 'package:flutter/material.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/game.dart';
import 'package:test_build/domain/player.dart';
import 'package:test_build/domain/teams.dart';
import 'package:test_build/repository/teams_repository.dart';

class PlayerStatsModel extends ChangeNotifier {
  Team team;
  Categorys category;
  Game game;
  final _teamsRepository = TeamsRepository.instance;
  List<Player> playerList = [];
  List<Player> gameFPList = [];
  List<Player> gameGKList = [];
  bool selectedFP = false;
  bool selectedGK = false;

  int allShoot = 0;
  int allShot = 0;

  bool hasShownParticipation = false;

  Future initState(Categorys category, Game game) async {
    await initData(category, game);
    await getFP();
    await getGK();
    initFP(category, game);
    initGK(category, game);
    notifyListeners();
  }

  Future initData(Categorys category, Game game) async {
    this.category = category;
    this.game = game;
    team = await _teamsRepository.fetch();
    notifyListeners();
  }

  Future getFP() async {
    gameFPList = await _teamsRepository.getGameFP(
        team: team, category: category, game: game);
    allShoot = 0;
    for (Player player in gameFPList) {
      allShoot = allShoot + player.shoot;
    }
    print('get! FP!');
    notifyListeners();
  }

  Future getGK() async {
    gameGKList = await _teamsRepository.getGameGK(
        team: team, category: category, game: game);
    allShot = 0;
    for (Player player in gameGKList) {
      allShot = allShot + player.shot;
    }
    print('get! GK!');
    notifyListeners();
  }

  void selectFP() {
    selectedFP = true;
    notifyListeners();
  }

  void unSelectFP() {
    selectedFP = false;
    notifyListeners();
  }

  void selectGK() {
    selectedGK = true;
    notifyListeners();
  }

  void unSelectGK() {
    selectedGK = false;
    notifyListeners();
  }

  void changeFPlist() {
    if (hasShownParticipation == true) {
      hasShownParticipation = false;
    } else {
      hasShownParticipation = true;
    }
    notifyListeners();
  }


  //ダイアログに関するもの
  Player player;
  List<String> fpNameList = [];
  List<String> gkNameList = [];
  List<Player> allFPList = [];
  List<Player> allGKList = [];

  String playerName = '選手を選ぶ';
  int shoot = 0;
  int goal = 0;
  int participation = 0;
  int shot = 0;
  int scored = 0;
  int tokutenParticipation = 0;
  int shittenParticipation = 0;
  int shootGK = 0;
  int goalGK = 0;

  Future initGK(Categorys category, Game game) async {
    this.category = category;
    this.game = game;
    team = await _teamsRepository.fetch();
    allGKList = await _teamsRepository.getGK(category);
    gkNameList = allGKList
        .map((player) => '${player.uniformNumber} ${player.playerName}')
        .toList();
    gkNameList.insert(0, '選手を選ぶ');
    print('get GK name');
    notifyListeners();
  }

  Future initFP(Categorys category, Game game) async {
    team = await _teamsRepository.fetch();
    allFPList = await _teamsRepository.getFP(category);
    fpNameList = allFPList
        .map((player) => '${player.uniformNumber} ${player.playerName}')
        .toList();
    fpNameList.insert(0, '選手を選ぶ');
    print('get FP name');
    notifyListeners();
  }

  Future addGameFP() async {
    if (player != null) {
      await _teamsRepository.addGameFP(
          category: category,
          game: game,
          player: player,
          goal: goal,
          shoot: shoot,
          participation: participation,
          tokutenParticipation: tokutenParticipation,
          shittenParticipation: shittenParticipation);
      print('add FP');
    }

    notifyListeners();
  }

  Future addGameGK() async {
    if (player != null) {
      await _teamsRepository.addGameGK(
        category: category,
        game: game,
        player: player,
        scored: scored,
        shot: shot,
        goal: goalGK,
        shoot: shootGK,
        participation: participation,
      );
      print('add GK');
    }

    notifyListeners();
  }

  void incrementShoot() {
    shoot++;
    notifyListeners();
  }

  void decrementShoot() {
    shoot--;
    notifyListeners();
  }

  void incrementGoal() {
    goal++;
    notifyListeners();
  }

  void decrementGoal() {
    goal--;
    notifyListeners();
  }

  void incrementParticipation() {
    participation++;
    notifyListeners();
  }

  void decrementParticipation() {
    participation--;
    notifyListeners();
  }

  void incrementShot() {
    shot++;
    notifyListeners();
  }

  void decrementShot() {
    shot--;
    notifyListeners();
  }

  void incrementShootGK() {
    shootGK++;
    notifyListeners();
  }

  void decrementShootGK() {
    shootGK--;
    notifyListeners();
  }

  void incrementGoalGK() {
    goalGK++;
    notifyListeners();
  }

  void decrementGoalGK() {
    goalGK--;
    notifyListeners();
  }

  void incrementScored() {
    scored++;
    notifyListeners();
  }

  void decrementScored() {
    scored--;
    notifyListeners();
  }

  void incrementTokutenParticipation() {
    tokutenParticipation++;
    notifyListeners();
  }

  void decrementTokutenParticipation() {
    tokutenParticipation--;
    notifyListeners();
  }

  void incrementShittenParticipation() {
    shittenParticipation++;
    notifyListeners();
  }

  void decrementShittenParticipation() {
    shittenParticipation--;
    notifyListeners();
  }

  void initValue() {
    playerName = fpNameList[0];
    shoot = 0;
    goal = 0;
    participation = 0;
    shot = 0;
    scored = 0;
    tokutenParticipation = 0;
    shittenParticipation = 0;
    shootGK = 0;
    goalGK = 0;

    notifyListeners();
  }

  void onSelectedFP(int index) {
    playerName = fpNameList[index];

    if (index != 0) {
      player = allFPList[index - 1];
      print(player.playerName);
    } else {
      player = null;
    }
    print(playerName);
    notifyListeners();
  }

  void onSelectedGK(int index) {
    playerName = gkNameList[index];

    if (index != 0) {
      player = allGKList[index - 1];
      print(player.playerName);
    } else {
      player = null;
    }
    print(playerName);
    notifyListeners();
  }
}
