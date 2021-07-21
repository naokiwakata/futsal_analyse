import 'package:flutter/material.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/player.dart';
import 'package:test_build/domain/teams.dart';
import 'package:test_build/repository/teams_repository.dart';
import 'package:test_build/service/service/dialog_helper.dart';

class PlayerListModel extends ChangeNotifier {
  final _teamsRepository = TeamsRepository.instance;
  List<Player> playerList = [];
  Team team;
  Categorys category;
  String uniformNumber = "";
  String playerName = "";
  String position = 'FP';
  List<String> positionList = ['FP', 'GK'];
  bool loadingData = false;
  bool isEnable = true;

  Future initState(Categorys category) async {
    startLoading();
    this.category = category;
    team = await _teamsRepository.fetch();
    print(team.uid);
    playerList = await _teamsRepository.getPlayer(category);
    print(playerList);
    initValue();
    endLoading();
    notifyListeners();
  }

  Future getPlayer() async {
    playerList = await _teamsRepository.getPlayer(category);

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

  void initValue() {
    position = 'FP';
    playerName = '';
    uniformNumber = '';
    notifyListeners();
  }

  void onSelectedPosition(int index) {
    position = positionList[index];
    notifyListeners();
  }

  void clearTextField() {
    uniformNumber = null;
    playerName = '';
    notifyListeners();
  }

  Future addPlayer(BuildContext context) async {
    try {
      final number = int.parse(uniformNumber);
      await _teamsRepository.addPlayer(number, playerName, position, category);
    } catch (e) {
      showAlertDialog(context, '数字を入力してください');
    }
    notifyListeners();
  }

  Future deletePlayer(Player player) async {
    await _teamsRepository.deletePlayer(
        team: team, category: category, player: player);
    notifyListeners();
  }

  Future updatePlayer(Player player, BuildContext context) async {
    try {
      final number = int.parse(uniformNumber);
      await _teamsRepository.updatePlayer(
          uniformNumber: number,
          playerName: playerName,
          position: position,
          category: category,
          player: player);
    } catch (e) {
      showAlertDialog(context, '数字を入力してください');
    }
    notifyListeners();
  }

  void enablePush() {
    isEnable = true;
    notifyListeners();
  }

  void disablePush() {
    isEnable = false;
    notifyListeners();
  }
}
