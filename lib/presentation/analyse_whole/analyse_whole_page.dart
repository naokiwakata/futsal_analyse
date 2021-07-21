import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/presentation/analyse_whole/analyse_whole_model.dart';

class AnalyseWholePage extends StatelessWidget {
  AnalyseWholePage({this.category});

  final Categorys category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AnalyseWholeModel>(
      create: (_) => AnalyseWholeModel()..initState(category),
      child: Consumer<AnalyseWholeModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                category.categoryName,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            body: !model.loadingData
                ? model.gameList.isNotEmpty
                    ? Container(
                        height: 500,
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text('全試合'),
                                    ),
                                    Container(
                                      child: Text(
                                        model.games.toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 0,
                              thickness: 2,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text('戦績'),
                                    ),
                                    Container(
                                      child: Text(
                                        '${model.win.toString()} 勝　${model.draw.toString()} 分　${model.lose.toString()} 敗',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 0,
                              thickness: 2,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text('勝率'),
                                    ),
                                    Container(
                                      child: Text(
                                        '${model.winRate.toStringAsFixed(1)} %',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 0,
                              thickness: 2,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text('総得点'),
                                    ),
                                    model.games != 0
                                        ? Container(
                                            child: Text(
                                              '${model.allTokuten.toString()} 点 (${(model.allTokuten / model.games).toStringAsFixed(1)}点/1試合)',
                                            ),
                                          )
                                        : Text(
                                            '0 点',
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 0,
                              thickness: 2,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text('総失点'),
                                    ),
                                    model.games != 0
                                        ? Container(
                                            child: Text(
                                              '${model.allShitten.toString()} 点 (${(model.allShitten / model.games).toStringAsFixed(1)}点/1試合)',
                                            ),
                                          )
                                        : Text(
                                            '0 点',
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 0,
                              thickness: 2,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text('シュート'),
                                    ),
                                    model.games != 0
                                        ? Container(
                                            child: Text(
                                              '${model.allShoot.toString()} 本 (${(model.allShoot / model.games).toStringAsFixed(1)}本/1試合)',
                                            ),
                                          )
                                        : Text(
                                            '0 本',
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 0,
                              thickness: 2,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text('被シュート'),
                                    ),
                                    model.games != 0
                                        ? Container(
                                            child: Text(
                                              '${model.allShot.toString()} 本 (${(model.allShot / model.games).toStringAsFixed(1)}本/1試合)',
                                            ),
                                          )
                                        : Text(
                                            '0 本',
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 0,
                              thickness: 2,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text('得点王'),
                                    ),
                                    Container(
                                      child: Text(
                                          'No.${model.goalKing.uniformNumber} ${model.goalKing.playerName}  ${model.goalKing.goal.toString()}G'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 0,
                              thickness: 2,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text('シュート王'),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            'No.${model.shootKing.uniformNumber} ${model.shootKing.playerName}  ${model.shootKing.shoot.toString()}本'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 0,
                              thickness: 2,
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Text('データなし'),
                      )
                : Center(
                    child: CircularProgressIndicator(
                      color: Colors.redAccent,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
