import 'package:flutter/material.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/game.dart';
import 'package:test_build/domain/gameDetail.dart';
import 'package:test_build/domain/player.dart';
import 'package:test_build/domain/teams.dart';
import 'package:test_build/repository/teams_repository.dart';

class InputGameDataModel extends ChangeNotifier {
  bool loadingData = false;
  int currentIndex = 0;
  Team team;
  Categorys category;
  Game game;
  String teamName;
  final _teamsRepository = TeamsRepository.instance;
  String minute;
  String second;
  String goalPlayer;
  List<Player> playerList = [];
  List<String> playerNameList = [];
  List<GameDetail> gameDetailList = [];
  String tokutenPattern;
  String shittenPattern;
  String half;
  int firstTokuten = 0;
  int firstShitten = 0;
  int secondTokuten = 0;
  int secondShitten = 0;
  final List<String> halfs = ['前半', '後半'];
  final List<String> minutes = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
  ];
  final List<String> seconds = [
    '00',
    '10',
    '20',
    '30',
    '40',
    '50',
  ];
  final List<String> tokutenPatternList = [
    '得点パターンを選ぶ',
    'セットプレー',
    'カウンター',
    '個人技',
    '崩し',
    'その他',
  ];
  final List<String> shittenPatternList = [
    '失点パターンを選ぶ',
    'セットプレー',
    'カウンター',
    '個人技',
    '崩し',
    'その他',
  ];
  Future initGameDetailState(Categorys category, Game game) async {
    startLoading();
    this.game = game;
    this.category = category;
    team = await _teamsRepository.fetch();
    await getTeam();
    teamName = team.teamName;
    playerList = await _teamsRepository.getPlayer(category);
    await getGameDetail();
    playerNameList = playerList
        .map((player) => '${player.uniformNumber} ${player.playerName}')
        .toList();
    playerNameList.insert(0, '選手を選ぶ');
    initValue();
    endLoading();
    notifyListeners();
  }

  Future getTeam() async {
    team = await _teamsRepository.getTeam(team: team);
    print(team.teamName);
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

  void initScore() {
    firstTokuten = 0;
    firstShitten = 0;
    secondTokuten = 0;
    secondShitten = 0;
    notifyListeners();
  }

  //前半後半の得点を分けて表示させる
  Future getGameDetail() async {
    initScore();
    gameDetailList = await _teamsRepository.getGameDetail(category, game);
    gameDetailList.forEach(
      (gameDetail) => {
        if (gameDetail.rnrs == '得点')
          {
            if (gameDetail.scoreTime <= 1200)
              {
                firstTokuten++,
              }
            else if (gameDetail.scoreTime > 1200)
              {
                secondTokuten++,
              }
          }
        else if (gameDetail.rnrs == '失点')
          {
            if (gameDetail.scoreTime <= 1200)
              {
                firstShitten++,
              }
            else if (gameDetail.scoreTime > 1200)
              {
                secondShitten++,
              }
          }
      },
    );
    notifyListeners();
  }

  void initValue() async {
    half = halfs[0];
    minute = minutes[0];
    second = seconds[0];
    goalPlayer = playerNameList[0];
    tokutenPattern = tokutenPatternList[0];
    shittenPattern = shittenPatternList[0];
    await _teamsRepository.getGameDetail(category, game);
    print('init team');
    notifyListeners();
  }

  int calculateTime(String strMinute, String strSecond) {
    if (half == '前半') {
      final minute = int.parse(strMinute);
      final second = int.parse(strSecond);
      final time = minute * 60 + second;
      return time;
    } else {
      final minute = int.parse(strMinute);
      final second = int.parse(strSecond);
      final time = 20 * 60 + minute * 60 + second;
      return time;
    }
  }

  Future addTokuetenDetail() async {
    final tokutenTime = '$half $minute : $second';
    final time = calculateTime(minute, second);
    print(tokutenTime);
    print(goalPlayer);
    print(tokutenPattern);
    await _teamsRepository.addTokutenDetail(
        time, tokutenTime, goalPlayer, tokutenPattern, category, game);
    notifyListeners();
  }

  Future addShittenDetail() async {
    final shittenTime = '$half $minute : $second';
    final time = calculateTime(minute, second);
    print(shittenTime);
    print(shittenPattern);
    await _teamsRepository.addShittenDetail(
        time, shittenTime, shittenPattern, category, game);
    notifyListeners();
  }

  Future deleteDetail(GameDetail gameDetail) async {
    await _teamsRepository.deleteDetail(
        team: team, category: category, game: game, gameDetail: gameDetail);
    notifyListeners();
  }

  void onSelectedHalf(int index) {
    half = halfs[index];
    notifyListeners();
  }

  void onSelectedMinutes(int index) {
    minute = minutes[index];
    notifyListeners();
  }

  void onSelectedSeconds(int index) {
    second = seconds[index];
    notifyListeners();
  }

  void onSelectedTokutenPattern(int index) {
    tokutenPattern = tokutenPatternList[index];
    notifyListeners();
  }

  void onSelectedShittenPattern(int index) {
    shittenPattern = shittenPatternList[index];
    notifyListeners();
  }

  void onSelectedPlayers(int index) {
    goalPlayer =
        "${playerList[index - 1].uniformNumber} ${playerList[index - 1].playerName}";
    notifyListeners();
  }

  void onTabTapped(int index) async {
    currentIndex = index;

    notifyListeners();
  }
}
