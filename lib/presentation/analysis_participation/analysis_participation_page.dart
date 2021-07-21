import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/player.dart';
import 'package:test_build/presentation/analysis_participation/analysis_participation_model.dart';

class AnalyseParticipationPage extends StatelessWidget {
  AnalyseParticipationPage({this.category});

  final Categorys category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AnalysisParticipationModel>(
      create: (_) => AnalysisParticipationModel()..initState(category),
      child: Consumer<AnalysisParticipationModel>(
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
                            Tab(text: '出場回数'),
                            Tab(text: '得点時'),
                            Tab(text: '失点時'),
                          ],
                        ),
                        model.participationList.isNotEmpty
                            ? Expanded(
                                child: TabBarView(
                                  children: [
                                    participationRanking(
                                        model.participationList),
                                    tokutenParticipationRanking(
                                        model.tokutenParticipationList),
                                    shittenParticipationRanking(
                                        model.shittenParticipationList),
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

  Widget participationRanking(List<Player> rankingList) {
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
          final participation = rankingList[index].participation;
          final tokutenParticipation = rankingList[index].tokutenParticipation;
          final shittenParticipation = rankingList[index].shittenParticipation;
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
                      child: Row(
                        children: [
                          Text(
                            participation.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8),
                            child: Text(
                              '出場',
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
                            tokutenParticipation.toString(),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8),
                            child: Text(
                              '得',
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
                          Row(
                            children: [
                              Text(
                                shittenParticipation.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4, top: 8),
                                child: Text(
                                  '失',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
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

  Widget tokutenParticipationRanking(List<Player> rankingList) {
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
          final participation = rankingList[index].participation;
          final tokutenParticipation = rankingList[index].tokutenParticipation;
          final shittenParticipation = rankingList[index].shittenParticipation;
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
                      child: Row(
                        children: [
                          Text(
                            tokutenParticipation.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8),
                            child: Text(
                              '得点時',
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
                            participation.toString(),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8),
                            child: Text(
                              '出場',
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
                          participation != 0
                              ? Text(
                                  '${(tokutenParticipation / participation * 100).round()}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              : Text(
                                  '0',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8),
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

  Widget shittenParticipationRanking(List<Player> rankingList) {
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
          final participation = rankingList[index].participation;
          final tokutenParticipation = rankingList[index].tokutenParticipation;
          final shittenParticipation = rankingList[index].shittenParticipation;
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
                      child: Row(
                        children: [
                          Text(
                            shittenParticipation.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8),
                            child: Text(
                              '失点時',
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
                            participation.toString(),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8),
                            child: Text(
                              '出場',
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
                          participation != 0
                              ? Text(
                                  '${(shittenParticipation / participation * 100).round()}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              : Text(
                                  '0',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8),
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
}
//Gkのfunctionsとランキング。
