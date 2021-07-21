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
                        _tokutenPatternTab(model),
                        _shittenPatternTab(model),
                        _tokutenTimeTab(
                            model, model.tokutenTimeList, model.allTokuten),
                        _tokutenTimeTab(
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

  Widget _tokutenPatternTab(AnalyseMatchModel model) {
    return Scaffold(
      body: !model.loadingData
          ? Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text('セットプレー'),
                            Text(
                              '${model.tsetPlay.toString()} g',
                            ),
                            Text('${model.tsetPlayPer}%'),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text('カウンター'),
                          Text(
                            '${model.tcounter.toString()} g',
                          ),
                          Text('${model.tcounterPer}%'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('個人技'),
                          Text(
                            '${model.tindividualSkill.toString()} g',
                          ),
                          Text('${model.tindividualSkillPer}%'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('崩し'),
                          Text(
                            '${model.tbreakUp.toString()} g',
                          ),
                          Text('${model.tbreakUpPer}%'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('その他'),
                          Text(
                            '${model.tother.toString()} g',
                          ),
                          Text('${model.totherPer}%'),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: model.tokutenPatternList.isNotEmpty
                        ? Stack(
                            children: [
                              charts.PieChart(
                                _createScoreData(model.tokutenPatternList),
                                defaultRenderer: new charts.ArcRendererConfig(
                                  arcWidth: 100,
                                  arcRendererDecorators: [
                                    new charts.ArcLabelDecorator(
                                        labelPosition:
                                            charts.ArcLabelPosition.inside)
                                  ],
                                ),
                              ),
                              Center(
                                child: Text(
                                  '${model.allTokuten.toString()} GOAL',
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Text('データなし'),
                          ),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            ),
    );
  }

  Widget _shittenPatternTab(AnalyseMatchModel model) {
    return Scaffold(
      body: !model.loadingData
          ? Column(
              children: [
                Container(
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Text('セットプレー'),
                                  Text(
                                    '${model.setPlay.toString()} g',
                                  ),
                                  Text('${model.setPlayPer}%'),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text('カウンター'),
                                Text(
                                  '${model.counter.toString()} g',
                                ),
                                Text('${model.counterPer}%'),
                              ],
                            ),
                            Column(
                              children: [
                                Text('個人技'),
                                Text(
                                  '${model.individualSkill.toString()} g',
                                ),
                                Text('${model.individualSkillPer}%'),
                              ],
                            ),
                            Column(
                              children: [
                                Text('崩し'),
                                Text(
                                  '${model.breakUp.toString()} g',
                                ),
                                Text('${model.breakUpPer}%'),
                              ],
                            ),
                            Column(
                              children: [
                                Text('その他'),
                                Text(
                                  '${model.other.toString()} g',
                                ),
                                Text('${model.otherPer}%'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: model.shittenPetternList.isNotEmpty
                        ? Stack(
                            children: [
                              charts.PieChart(
                                _createScoreData(model.shittenPetternList),
                                defaultRenderer: new charts.ArcRendererConfig(
                                  arcWidth: 100,
                                  arcRendererDecorators: [
                                    new charts.ArcLabelDecorator(
                                        labelPosition:
                                            charts.ArcLabelPosition.inside)
                                  ],
                                ),
                              ),
                              Center(
                                child: Text(
                                  '${model.allShitten.toString()} GOAL',
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Text('データなし'),
                          ),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            ),
    );
  }

  Widget _tokutenTimeTab(
      AnalyseMatchModel model, List<ScoreData> list, int goal) {
    return Scaffold(
      body: !model.loadingData
          ? Column(
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
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: list.isNotEmpty
                        ? charts.BarChart(
                            _createScoreData(list),
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
                          )
                        : Center(
                            child: Text('データなし'),
                          ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
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
