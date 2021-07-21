import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/presentation/analysis_goal_shoot/analysis_goal_shoot_model.dart';

class AnalyseGoalShootPage extends StatelessWidget {
  AnalyseGoalShootPage({this.category});

  final Categorys category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AnalyseGoalShootModel>(
      create: (_) => AnalyseGoalShootModel()..initState(category),
      child: Consumer<AnalyseGoalShootModel>(
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
                      Tab(text: '得点数'),
                      Tab(text: '失点数'),
                      Tab(text: 'シュート'),
                      Tab(
                        text: '被シュート',
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _tokutenTab(model),
                        _shittenTab(model),
                        _shootTab(model),
                        _shotTab(model),
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

  Widget _tokutenTab(AnalyseGoalShootModel model) {
    return Scaffold(
      body: !model.loadingData
          ? Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        '全 ${model.allTokuten.toString()}ゴール',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            model.avgTokuten.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '点　/1試合',
                            style: TextStyle(
                              fontSize: 15,
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
                    child: model.tokutenList.isNotEmpty
                        ? Stack(
                            children: [
                              charts.BarChart(
                                _createScoreData(
                                    model.tokutenList,
                                    charts.MaterialPalette.deepOrange
                                        .shadeDefault),
                                domainAxis: new charts.OrdinalAxisSpec(
                                  renderSpec: new charts.SmallTickRendererSpec(
                                    labelStyle: new charts.TextStyleSpec(
                                      color: charts.MaterialPalette.white,
                                    ),
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

  Widget _shittenTab(AnalyseGoalShootModel model) {
    return Scaffold(
      body: !model.loadingData
          ? Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        '全 ${model.allShitten.toString()}失点',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            model.avgShitten.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '点　/1試合',
                            style: TextStyle(
                              fontSize: 15,
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
                    child: model.shittenList.isNotEmpty
                        ? Stack(
                            children: [
                              charts.BarChart(
                                _createScoreData(model.shittenList,
                                    charts.MaterialPalette.blue.shadeDefault),
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

  Widget _shootTab(AnalyseGoalShootModel model) {
    return Scaffold(
      body: !model.loadingData
          ? Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        '全 ${model.allShoot.toString()}本',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            model.avgShoot.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '点　/1試合',
                            style: TextStyle(
                              fontSize: 15,
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
                    child: model.shootList.isNotEmpty
                        ? Stack(
                            children: [
                              charts.BarChart(
                                _createScoreData(model.shootList,
                                    charts.MaterialPalette.pink.shadeDefault),
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

  Widget _shotTab(AnalyseGoalShootModel model) {
    return Scaffold(
      body: !model.loadingData
          ? Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        '全 ${model.allShot.toString()}本',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            model.avgShot.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '点　/1試合',
                            style: TextStyle(
                              fontSize: 15,
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
                    child: model.shotList.isNotEmpty
                        ? Stack(
                            children: [
                              charts.BarChart(
                                _createScoreData(model.shotList,
                                    charts.MaterialPalette.cyan.shadeDefault),
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

  List<charts.Series<GameData, String>> _createScoreData(
      List<GameData> scoreData, charts.Color color) {
    return [
      charts.Series<GameData, String>(
        id: 'TokutenPattern',
        data: scoreData,
        colorFn: (_, __) => color,
        domainFn: (GameData data, _) => data.opponentName,
        measureFn: (GameData data, _) => data.number,
      )
    ];
  }
}
