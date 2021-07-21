import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/gameDetail.dart';
import 'package:test_build/domain/teams.dart';
import 'package:test_build/repository/analysis_repository.dart';
import 'package:test_build/repository/teams_repository.dart';

class AnalyseMatchModel extends ChangeNotifier {
  final _teamsRepository = TeamsRepository.instance;
  Team team;
  Categorys category;
  final _analysisRepository = AnalysisRepository.instance;
  List<GameDetail> allGameDetail = [];
  bool loadingData = false;

  //得点区分
  List<ScoreData> tokutenPatternList = [];

  int tsetPlay = 0;
  int tcounter = 0;
  int tindividualSkill = 0;
  int tbreakUp = 0;
  int tother = 0;
  int allTokuten = 0;

  int tsetPlayPer = 0;
  int tcounterPer = 0;
  int tindividualSkillPer = 0;
  int tbreakUpPer = 0;
  int totherPer = 0;

  //失点区分
  List<ScoreData> shittenPetternList = [];

  int setPlay = 0;
  int counter = 0;
  int individualSkill = 0;
  int breakUp = 0;
  int other = 0;
  int allShitten = 0;

  int setPlayPer = 0;
  int counterPer = 0;
  int individualSkillPer = 0;
  int breakUpPer = 0;
  int otherPer = 0;

  //得点時間
  List<ScoreData> tokutenTimeList = [];
  List<ScoreData> shittenTimeList = [];

  int zeroToFive = 0;
  int fiveToTen = 0;
  int tenToFif = 0;
  int fifToTwe = 0;
  int tweToTwef = 0;
  int twefToThir = 0;
  int thirToThief = 0;
  int thiefToFour = 0;

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
    allGameDetail = await _analysisRepository.getAllDetail(team, category);
    print(allGameDetail);
    if (allGameDetail.isNotEmpty) {
      countTokutenPattern();
      countShittenPattern();
      countTokutenTime();
      countShittenTime();
    }
    endLoading();
    notifyListeners();
  }

  void calculateTokutenPercent() {
    tsetPlayPer = (tsetPlay / allTokuten * 100).round();
    tcounterPer = (tcounter / allTokuten * 100).round();
    tindividualSkillPer = (tindividualSkill / allTokuten * 100).round();
    tbreakUpPer = (tbreakUp / allTokuten * 100).round();
    totherPer = (tother / allTokuten * 100).round();
    notifyListeners();
  }

  void countTokutenPattern() {
    //得点パターンをインクリメント
    for (GameDetail game in allGameDetail) {
      if (game.tokutenPattern == 'セットプレー') {
        tsetPlay++;
      } else if (game.tokutenPattern == 'カウンター') {
        tcounter++;
      } else if (game.tokutenPattern == '個人技') {
        tindividualSkill++;
      } else if (game.tokutenPattern == '崩し') {
        tbreakUp++;
      } else if (game.tokutenPattern == 'その他') {
        tother++;
      }
      if (game.rnrs == '得点') {
        allTokuten++;
      }
    }
    calculateTokutenPercent();
    //リストに追加
    final setPlayData = ScoreData('セットプレー\n ${tsetPlay}goal\n $tsetPlayPer%',
        tsetPlay, charts.MaterialPalette.red.shadeDefault);
    final counterData = ScoreData('カウンター\n ${tcounter}goal\n $tcounterPer%',
        tcounter, charts.MaterialPalette.blue.shadeDefault);
    final individualSkillData = ScoreData(
        '個人技\n ${tindividualSkill}goal\n $tindividualSkillPer%',
        tindividualSkill,
        charts.MaterialPalette.green.shadeDefault);
    final breakUpData = ScoreData('崩し\n${tbreakUp}goal\n $tbreakUpPer%',
        tbreakUp, charts.MaterialPalette.lime.shadeDefault);
    final otherData = ScoreData('その他\n ${tother}goal\n $totherPer%', tother,
        charts.MaterialPalette.gray.shadeDefault);
    tokutenPatternList.add(setPlayData);
    tokutenPatternList.add(counterData);
    tokutenPatternList.add(individualSkillData);
    tokutenPatternList.add(breakUpData);
    tokutenPatternList.add(otherData);
    notifyListeners();
  }

  void calculateShittenPercent() {
    setPlayPer = (setPlay / allShitten * 100).round();
    counterPer = (counter / allShitten * 100).round();
    individualSkillPer = (individualSkill / allShitten * 100).round();
    breakUpPer = (breakUp / allShitten * 100).round();
    otherPer = (other / allShitten * 100).round();
    notifyListeners();
  }

  void countShittenPattern() {
    //得点パターンをインクリメント
    for (GameDetail game in allGameDetail) {
      if (game.shittenPattern == 'セットプレー') {
        setPlay++;
      } else if (game.shittenPattern == 'カウンター') {
        counter++;
      } else if (game.shittenPattern == '個人技') {
        individualSkill++;
      } else if (game.shittenPattern == '崩し') {
        breakUp++;
      } else if (game.shittenPattern == 'その他') {
        other++;
      }
      if (game.rnrs == '失点') {
        allShitten++;
      }
    }
    calculateShittenPercent();

    //リストに追加
    final setPlayData = ScoreData('セットプレー\n ${setPlay}goal\n $setPlayPer%',
        setPlay, charts.MaterialPalette.red.shadeDefault);
    final counterData = ScoreData('カウンター\n ${counter}goal\n $counterPer%',
        counter, charts.MaterialPalette.blue.shadeDefault);
    final individualSkillData = ScoreData(
        '個人技\n ${individualSkill}goal\n $individualSkillPer%',
        individualSkill,
        charts.MaterialPalette.green.shadeDefault);
    final breakUpData = ScoreData('崩し\n${breakUp}goal\n $breakUpPer%', breakUp,
        charts.MaterialPalette.lime.shadeDefault);
    final otherData = ScoreData('その他\n ${other}goal\n $otherPer%', other,
        charts.MaterialPalette.gray.shadeDefault);
    shittenPetternList.add(setPlayData);
    shittenPetternList.add(counterData);
    shittenPetternList.add(individualSkillData);
    shittenPetternList.add(breakUpData);
    shittenPetternList.add(otherData);
    notifyListeners();
  }

  void initValue() {
    zeroToFive = 0;
    fiveToTen = 0;
    tenToFif = 0;
    fifToTwe = 0;
    tweToTwef = 0;
    twefToThir = 0;
    thirToThief = 0;
    thiefToFour = 0;
    notifyListeners();
  }

  void countTokutenTime() {
    initValue();
    //得点時間をインクリメント
    for (GameDetail game in allGameDetail) {
      if (game.rnrs == '得点') {
        if (0 <= game.scoreTime && game.scoreTime < 300) {
          zeroToFive++;
        } else if (300 <= game.scoreTime && game.scoreTime < 600) {
          fiveToTen++;
        } else if (600 <= game.scoreTime && game.scoreTime < 900) {
          tenToFif++;
        } else if (900 <= game.scoreTime && game.scoreTime < 1200) {
          fifToTwe++;
        } else if (1200 <= game.scoreTime && game.scoreTime < 1500) {
          tweToTwef++;
        } else if (1500 <= game.scoreTime && game.scoreTime < 1800) {
          twefToThir++;
        } else if (1800 <= game.scoreTime && game.scoreTime < 2100) {
          thirToThief++;
        } else if (2100 <= game.scoreTime && game.scoreTime < 2400) {
          thiefToFour++;
        }
      }
    }
    //リストに追加
    final zeroToFiveData = ScoreData('0~5\n ${zeroToFive}G', zeroToFive,
        charts.MaterialPalette.yellow.shadeDefault);
    tokutenTimeList.add(zeroToFiveData);
    final fiveToTenData = ScoreData('5~10\n ${fiveToTen}G', fiveToTen,
        charts.MaterialPalette.deepOrange.shadeDefault);
    tokutenTimeList.add(fiveToTenData);
    final tenToFifData = ScoreData('10~15\n ${tenToFif}G', tenToFif,
        charts.MaterialPalette.red.shadeDefault);
    tokutenTimeList.add(tenToFifData);
    final fifToTweData = ScoreData('15~20\n ${fifToTwe}G', fifToTwe,
        charts.MaterialPalette.pink.shadeDefault);
    tokutenTimeList.add(fifToTweData);
    final tweToTwefData = ScoreData('20~25\n ${tweToTwef}G', tweToTwef,
        charts.MaterialPalette.teal.shadeDefault);
    tokutenTimeList.add(tweToTwefData);
    final twefToThirData = ScoreData('25~30\n ${twefToThir}G', twefToThir,
        charts.MaterialPalette.cyan.shadeDefault);
    tokutenTimeList.add(twefToThirData);
    final thirToThiefData = ScoreData('30~35\n ${thirToThief}G', thirToThief,
        charts.MaterialPalette.blue.shadeDefault);
    tokutenTimeList.add(thirToThiefData);
    final thiefToFourData = ScoreData('35~40\n ${thiefToFour}G', thiefToFour,
        charts.MaterialPalette.indigo.shadeDefault);
    tokutenTimeList.add(thiefToFourData);
    notifyListeners();
  }

  void countShittenTime() {
    initValue();
    //得点時間をインクリメント
    for (GameDetail game in allGameDetail) {
      if (game.rnrs == '失点') {
        if (0 <= game.scoreTime && game.scoreTime < 300) {
          zeroToFive++;
        } else if (300 <= game.scoreTime && game.scoreTime < 600) {
          fiveToTen++;
        } else if (600 <= game.scoreTime && game.scoreTime < 900) {
          tenToFif++;
        } else if (900 <= game.scoreTime && game.scoreTime < 1200) {
          fifToTwe++;
        } else if (1200 <= game.scoreTime && game.scoreTime < 1500) {
          tweToTwef++;
        } else if (1500 <= game.scoreTime && game.scoreTime < 1800) {
          twefToThir++;
        } else if (1800 <= game.scoreTime && game.scoreTime < 2100) {
          thirToThief++;
        } else if (2100 <= game.scoreTime && game.scoreTime < 2400) {
          thiefToFour++;
        }
      }
    }
    //リストに追加
    final zeroToFiveData = ScoreData('0~5\n ${zeroToFive}G', zeroToFive,
        charts.MaterialPalette.yellow.shadeDefault);
    shittenTimeList.add(zeroToFiveData);
    final fiveToTenData = ScoreData('5~10\n ${fiveToTen}G', fiveToTen,
        charts.MaterialPalette.deepOrange.shadeDefault);
    shittenTimeList.add(fiveToTenData);
    final tenToFifData = ScoreData('10~15\n ${tenToFif}G', tenToFif,
        charts.MaterialPalette.red.shadeDefault);
    shittenTimeList.add(tenToFifData);
    final fifToTweData = ScoreData('15~20\n ${fifToTwe}G', fifToTwe,
        charts.MaterialPalette.pink.shadeDefault);
    shittenTimeList.add(fifToTweData);
    final tweToTwefData = ScoreData('20~25\n ${tweToTwef}G', tweToTwef,
        charts.MaterialPalette.teal.shadeDefault);
    shittenTimeList.add(tweToTwefData);
    final twefToThirData = ScoreData('25~30\n ${twefToThir}G', twefToThir,
        charts.MaterialPalette.cyan.shadeDefault);
    shittenTimeList.add(twefToThirData);
    final thirToThiefData = ScoreData('30~35\n ${thirToThief}G', thirToThief,
        charts.MaterialPalette.blue.shadeDefault);
    shittenTimeList.add(thirToThiefData);
    final thiefToFourData = ScoreData('35~40\n ${thiefToFour}G', thiefToFour,
        charts.MaterialPalette.indigo.shadeDefault);
    shittenTimeList.add(thiefToFourData);
    notifyListeners();
  }
}

class ScoreData {
  String percent;
  int number;
  final charts.Color color;

  ScoreData(this.percent, this.number, this.color);
}
