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
                      Tab(text: '被シュート'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _graphTab(
                          model,
                          model.tokutenList,
                          '全${model.allTokuten}ゴール',
                          model.avgTokuten.toStringAsFixed(1),
                          charts.MaterialPalette.deepOrange.shadeDefault,
                        ),
                        _graphTab(
                          model,
                          model.shittenList,
                          '全${model.allShitten}失点',
                          model.avgShitten.toStringAsFixed(1),
                          charts.MaterialPalette.blue.shadeDefault,
                        ),
                        _graphTab(
                          model,
                          model.shootList,
                          '全${model.allShoot}本',
                          model.avgShoot.toStringAsFixed(1),
                          charts.MaterialPalette.pink.shadeDefault,
                        ),
                        _graphTab(
                          model,
                          model.shotList,
                          '全${model.allShot}本',
                          model.avgShot.toStringAsFixed(1),
                          charts.MaterialPalette.cyan.shadeDefault,
                        ),
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

  Widget _graphTab(AnalyseGoalShootModel model, List<GameData> gameList,
      String allPoint, String avg, charts.Color color) {
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
          Column(
            children: [
              Text(
                allPoint,
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
                    avg,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '　/1試合',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          _graph(
            gameList,
            color,
          ),
          SizedBox(
            height: 30,
          ),
        ],
      );
    }
  }

  Widget _graph(List<GameData> gameList, charts.Color color) {
    if (gameList.isEmpty) {
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
              _createScoreData(
                gameList,
                color,
              ),
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
        domainFn: (GameData data, _) => data.opponentName.substring(0, 3),
        measureFn: (GameData data, _) => data.number,
      )
    ];
  }
}
