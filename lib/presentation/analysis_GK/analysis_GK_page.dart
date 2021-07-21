import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/player.dart';
import 'package:test_build/presentation/analysis_GK/analysis_GK_model.dart';

class AnalyseGKRankingPage extends StatelessWidget {
  AnalyseGKRankingPage({this.category});

  final Categorys category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AnalysisGKRankingModel>(
      create: (_) => AnalysisGKRankingModel()..initState(category),
      child: Consumer<AnalysisGKRankingModel>(
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
                            Tab(text: '被シュート'),
                            Tab(text: '失点'),
                            Tab(text: 'セーブ率'),
                          ],
                        ),
                        model.shotList.isNotEmpty
                            ? Expanded(
                                child: TabBarView(
                                  children: [
                                    shotRanking(model.shotList),
                                    scoredRanking(model.scoredList),
                                    saveRateRanking(model.saveRateList),
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

  Widget shotRanking(List<Player> rankingList) {
    return ListView.builder(
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
        final shot = rankingList[index].shot;
        final scored = rankingList[index].scored;
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
                    width: 60,
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
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      shot.toString() + " 本",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      scored.toString() + " 失点",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  shot != 0 && scored != 0
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: scored != 0 && shot != 0
                              ? Text(
                                  (100 - (scored / shot * 100).round())
                                          .toString() +
                                      " %",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              : Text(
                                  "0 %",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "0 %",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget scoredRanking(List<Player> rankingList) {
    return ListView.builder(
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
        final shot = rankingList[index].shot;
        final scored = rankingList[index].scored;
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
                    width: 60,
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
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      scored.toString() + " 失点",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      shot.toString() + " 本",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  shot != 0 && scored != 0
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: scored != 0 && shot != 0
                              ? Text(
                                  (100 - (scored / shot * 100).round())
                                          .toString() +
                                      " %",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              : Text(
                                  "0 %",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "0 %",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget saveRateRanking(List<Player> rankingList) {
    return ListView.builder(
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
        final shot = rankingList[index].shot;
        final scored = rankingList[index].scored;
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
                    width: 60,
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
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: scored != 0 && shot != 0
                        ? Text(
                            (100 - (scored / shot * 100).round()).toString() +
                                " %",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "0 %",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      shot.toString() + " 本",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      scored.toString() + " ゴール",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
