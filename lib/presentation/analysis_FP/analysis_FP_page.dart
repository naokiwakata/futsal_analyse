import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/player.dart';
import 'package:test_build/presentation/analysis_FP/analysis_FP_model.dart';

class AnalyseFPRankingPage extends StatelessWidget {
  AnalyseFPRankingPage({this.category});

  final Categorys category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AnalysisFPRankingModel>(
      create: (_) => AnalysisFPRankingModel()..initState(category),
      child: Consumer<AnalysisFPRankingModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                category.categoryName,
                style: TextStyle(fontSize: 20),
              ),
            ),
            body: !model.loadingData
                ? DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          indicatorColor: Colors.redAccent,
                          tabs: [
                            Tab(text: 'シュート'),
                            Tab(text: 'ゴール'),
                            Tab(text: '決定率'),
                          ],
                        ),
                        model.shootList.isNotEmpty
                            ? Expanded(
                                child: TabBarView(
                                  children: [
                                    shootRanking(model.shootList),
                                    goalRanking(model.goalList),
                                    goalRateRanking(model.goalRateList),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: Container(
                                  width: double.infinity,
                                  child: Center(
                                    child: Text('データなし'),
                                  ),
                                ),
                              )
                      ],
                    ),
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

  Widget shootRanking(List<Player> rankingList) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: rankingList.length + 1,
        itemBuilder: (context, index) {
          //最後のユーザーの後は線引くだけ
          final isNoUser = index == rankingList.length;
          if (isNoUser) {
            return Container(
              decoration: BoxDecoration(
                border: const Border(
                  top: const BorderSide(color: Colors.blueGrey, width: 0.2),
                ),
              ),
            );
          }
          final playerName = rankingList[index].playerName;
          final uniformNumber = rankingList[index].uniformNumber;
          final shoot = rankingList[index].shoot;
          final goal = rankingList[index].goal;
          final rankingNumber = index + 1;
          return Container(
            decoration: BoxDecoration(
              border: const Border(
                top: const BorderSide(color: Colors.black, width: 0.2),
              ),
            ),
            padding: EdgeInsets.all(2),
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      width: 64,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            rankingNumber.toString(),
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        uniformNumber.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        playerName,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            shoot.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8),
                            child: Text(
                              '本',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            goal.toString(),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8),
                            child: Text(
                              'ゴール',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    goal != 0 && shoot != 0
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text(
                                  (goal / shoot * 100).round().toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, top: 8),
                                  child: Text(
                                    '％',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text(
                                  "0",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, top: 8),
                                  child: Text(
                                    '％',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget goalRanking(List<Player> rankingList) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: rankingList.length + 1,
        itemBuilder: (context, index) {
          //最後のユーザーの後は線引くだけ
          final isNoUser = index == rankingList.length;
          if (isNoUser) {
            return Container(
              decoration: BoxDecoration(
                border: const Border(
                  top: const BorderSide(color: Colors.blueGrey, width: 0.2),
                ),
              ),
            );
          }
          final playerName = rankingList[index].playerName;
          final uniformNumber = rankingList[index].uniformNumber;
          final shoot = rankingList[index].shoot;
          final goal = rankingList[index].goal;
          final rankingNumber = index + 1;
          return Container(
            decoration: BoxDecoration(
              border: const Border(
                top: const BorderSide(color: Colors.black, width: 0.2),
              ),
            ),
            padding: EdgeInsets.all(2),
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      width: 64,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            rankingNumber.toString(),
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        uniformNumber.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        playerName,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            goal.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8),
                            child: Text(
                              'ゴール',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            shoot.toString(),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8),
                            child: Text(
                              '本',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    goal != 0 && shoot != 0
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text(
                                  (goal / shoot * 100).round().toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, top: 8),
                                  child: Text(
                                    '％',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text(
                                  "0",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, top: 8),
                                  child: Text(
                                    '%',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget goalRateRanking(List<Player> rankingList) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: rankingList.length + 1,
        itemBuilder: (context, index) {
          //最後のユーザーの後は線引くだけ
          final isNoUser = index == rankingList.length;
          if (isNoUser) {
            return Container(
              decoration: BoxDecoration(
                border: const Border(
                  top: const BorderSide(color: Colors.blueGrey, width: 0.2),
                ),
              ),
            );
          }
          final playerName = rankingList[index].playerName;
          final uniformNumber = rankingList[index].uniformNumber;
          final shoot = rankingList[index].shoot;
          final goal = rankingList[index].goal;
          final rankingNumber = index + 1;
          return Container(
            decoration: BoxDecoration(
              border: const Border(
                top: const BorderSide(color: Colors.black, width: 0.2),
              ),
            ),
            padding: EdgeInsets.all(2),
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      width: 64,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            rankingNumber.toString(),
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        uniformNumber.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        playerName,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    goal != 0 && shoot != 0
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text(
                                  (goal / shoot * 100).round().toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, top: 8),
                                  child: Text(
                                    '%',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, top: 8),
                                  child: Text(
                                    '%',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            shoot.toString(),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8),
                            child: Text(
                              '本',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            goal.toString(),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8),
                            child: Text(
                              'ゴール',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
