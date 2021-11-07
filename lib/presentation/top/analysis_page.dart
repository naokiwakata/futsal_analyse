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

  Widget _analyseTile(
      BuildContext context, StatelessWidget transitionPage, String title) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => transitionPage,
                  fullscreenDialog: true),
            );
          },
          child: Row(
            children: [
              Container(
                height: 60,
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }

  List<Widget> analyseList(AnalysisModel model, BuildContext context) {
    final analyseList = model.categoryList
        .map(
          (element) => Column(
            children: [
              _analyseTile(
                  context, AnalyseFPRankingPage(category: category), 'FPランキング'),
              _analyseTile(
                  context, AnalyseGKRankingPage(category: category), 'GKランキング'),
              _analyseTile(
                  context, AnalyseMatchPage(category: category), '得失点分析'),
              _analyseTile(
                  context, AnalyseGoalShootPage(category: category), '各試合分析'),
              _analyseTile(context,
                  AnalyseParticipationPage(category: category), '出場分析'),
              _analyseTile(
                  context, AnalyseWholePage(category: category), '全体分析'),
            ],
          ),
        )
        .toList();
    return analyseList;
  }
}
