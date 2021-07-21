import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/presentation/analyse_whole/analyse_whole_page.dart';
import 'package:test_build/presentation/analysis_FP/analysis_FP_page.dart';
import 'package:test_build/presentation/analysis_GK/analysis_GK_page.dart';
import 'package:test_build/presentation/analysis_goal_shoot/analysis_goal_shoot_page.dart';
import 'package:test_build/presentation/analysis_match/analysis_match_page.dart';
import 'package:test_build/presentation/analysis_participation/analysis_participation_page.dart';

import 'analysis_model.dart';

class AnalysisPage extends StatelessWidget {
  AnalysisPage({this.category});

  final Categorys category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AnalysisModel>(
      create: (_) => AnalysisModel(),
      child: Scaffold(
        body: Consumer<AnalysisModel>(builder: (context, model, child) {
          return ListView(
            children: analyseList(model, context),
          );
        }),
      ),
    );
  }

  List<Widget> analyseList(AnalysisModel model, BuildContext context) {
    final analyseList = model.categoryList
        .map(
          (element) => Container(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AnalyseFPRankingPage(
                                category: category,
                              ),
                          fullscreenDialog: true),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 60,
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  'FPランキング',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AnalyseGKRankingPage(
                                category: category,
                              ),
                          fullscreenDialog: true),
                    );
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 60,
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    'GKランキング',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AnalyseMatchPage(
                                category: category,
                              ),
                          fullscreenDialog: true),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 60,
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  '得失点分析',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AnalyseGoalShootPage(
                                category: category,
                              ),
                          fullscreenDialog: true),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 60,
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  '各試合分析',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AnalyseParticipationPage(
                                category: category,
                              ),
                          fullscreenDialog: true),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 60,
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  '出場分析',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AnalyseWholePage(
                                category: category,
                              ),
                          fullscreenDialog: true),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 60,
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  '全体分析',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                ),
              ],
            ),
          ),
        )
        .toList();
    return analyseList;
  }
}
