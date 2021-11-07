import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/presentation/analysis_match/analysis_match_model.dart';

class AnalyseMatchPage extends StatelessWidget {
  AnalyseMatchPage({this.category});

  final Categorys category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AnalyseMatchModel>(
      create: (_) => AnalyseMatchModel()..initState(category),
      child: Consumer<AnalyseMatchModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                category.categoryName,
                style: TextStyle(fontSize: 20),
              ),
            ),
            body: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.redAccent,
                    tabs: [
                      Tab(text: '得点区分'),
                      Tab(text: '失点区分'),
                      Tab(text: '得点時間'),
                      Tab(text: '失点時間'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _pieChartTab(
                          model,
                          model.tokutenPatternList,
                          '${model.allTokuten.toString()} GOAL',
                          model.tsetPlay,
                          model.tsetPlayPer,
                          model.tcounter,
                          model.tcounterPer,
                          model.tindividualSkill,
                          model.tindividualSkillPer,
                          model.tbreakUp,
                          model.tbreakUpPer,
                          model.tother,
                          model.totherPer,
                        ),
                        _pieChartTab(
                          model,
                          model.shittenPetternList,
                          '${model.allShitten.toString()} GOAL',
                          model.tsetPlay,
                          model.tsetPlayPer,
                          model.tcounter,
                          model.tcounterPer,
                          model.tindividualSkill,
                          model.tindividualSkillPer,
                          model.tbreakUp,
                          model.tbreakUpPer,
                          model.tother,
                          model.totherPer,
                        ),
                        _barChartTab(
                            model, model.tokutenTimeList, model.allTokuten),
                        _barChartTab(
                            model, model.shittenTimeList, model.allShitten),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _pieChartTab(
      AnalyseMatchModel model,
      List<ScoreData> scoreList,
      String centerChar,
      int setPlay,
      int setPlayPer,
      int counter,
      int counterPer,
      int skill,
      int skillPer,
      int breakUp,
      int breakUpPer,
      int other,
      int otherPer) {
    if (model.loadingData) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.redAccent,
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('セットプレー'),
                  Text(
                    '$setPlay g',
                  ),
                  Text('$setPlayPer%'),
                ],
              ),
              Column(
                children: [
                  Text('カウンター'),
                  Text(
                    '$counter g',
                  ),
                  Text('$counterPer%'),
                ],
              ),
              Column(
                children: [
                  Text('個人技'),
                  Text(
                    '$skill g',
                  ),
                  Text('$skillPer%'),
                ],
              ),
              Column(
                children: [
                  Text('崩し'),
                  Text(
                    '$breakUp g',
                  ),
                  Text('$breakUpPer%'),
                ],
              ),
              Column(
                children: [
                  Text('その他'),
                  Text(
                    '$other g',
                  ),
                  Text('$otherPer%'),
                ],
              ),
            ],
          ),
          _pieChart(model, scoreList, centerChar),
        ],
      );
    }
  }

  Widget _pieChart(
      AnalyseMatchModel model, List<ScoreData> scoreList, String centerChar) {
    if (scoreList.isEmpty) {
      return Center(
        child: Text('データなし'),
      );
    }
    return Expanded(
      child: Stack(
        children: [
          charts.PieChart(
            _createScoreData(scoreList),
            defaultRenderer: new charts.ArcRendererConfig(
              arcWidth: 100,
              arcRendererDecorators: [
                new charts.ArcLabelDecorator(
                    labelPosition: charts.ArcLabelPosition.inside)
              ],
            ),
          ),
          Center(
            child: Text(
              centerChar,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _barChartTab(
      AnalyseMatchModel model, List<ScoreData> scoreList, int goal) {
    if (model.loadingData) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.redAccent,
        ),
      );
    } else {
      return Column(
        children: [
          Container(
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "全 $goalゴール",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _barChart(scoreList),
          SizedBox(
            height: 30,
          ),
        ],
      );
    }
  }

  Widget _barChart(List<ScoreData> scoreList) {
    if (scoreList.isEmpty) {
      return Center(
        child: Text('データなし'),
      );
    }
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Stack(
          children: [
            charts.BarChart(
              _createScoreData(scoreList),
              domainAxis: new charts.OrdinalAxisSpec(
                renderSpec: new charts.SmallTickRendererSpec(
                  labelStyle: new charts.TextStyleSpec(
                      color: charts.MaterialPalette.white),
                  lineStyle: new charts.LineStyleSpec(
                      color: charts.MaterialPalette.white),
                ),
              ),
              primaryMeasureAxis: new charts.NumericAxisSpec(
                renderSpec: new charts.GridlineRendererSpec(
                  labelStyle: new charts.TextStyleSpec(
                      color: charts.MaterialPalette.white),
                  lineStyle: new charts.LineStyleSpec(
                      color: charts.MaterialPalette.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<charts.Series<ScoreData, String>> _createScoreData(
      List<ScoreData> scoreData) {
    return [
      charts.Series<ScoreData, String>(
        id: 'TokutenPattern',
        data: scoreData,
        domainFn: (ScoreData data, _) => data.percent,
        measureFn: (ScoreData data, _) => data.number,
        colorFn: (ScoreData data, _) => data.color,
      )
    ];
  }
}
