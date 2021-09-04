import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/presentation/player_list/player_list_page.dart';
import 'package:test_build/presentation/profile_setting/profile_setting_page.dart';
import 'package:test_build/presentation/register_team/register_team_page.dart';
import 'package:test_build/presentation/strategy_board/strategy_board_page.dart';
import 'package:test_build/presentation/top/analysis_page.dart';
import 'package:test_build/presentation/top/input_page.dart';
import 'package:test_build/presentation/top/top_model.dart';

class TopPage extends StatelessWidget {
  TopPage({this.category});

  final Categorys category;

  final List<String> _tabNames = ["試合", "選手", "分析", "作戦ボード"];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TopModel>(
      create: (_) => TopModel()..initState(category),
      child: Consumer<TopModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.settings,
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ProfileSettingPage(),
                    ),
                  );
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RegisterCategoryPage(),
                          fullscreenDialog: true),
                    );
                  },
                ),
              ],
              centerTitle: true,
              title: Text(
                category.categoryName,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            body: _topPageBody(context, model),
            bottomNavigationBar: SizedBox(
              child: BottomNavigationBar(
                selectedItemColor: Colors.redAccent,
                onTap: model.onTabTapped,
                currentIndex: model.currentIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.edit,
                    ),
                    label: _tabNames[0],
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.group),
                    label: _tabNames[1],
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.auto_graph),
                    label: _tabNames[2],
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard),
                    label: _tabNames[3],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _topPageBody(BuildContext context, TopModel model) {
    final currentIndex = model.currentIndex;
    return Stack(
      children: <Widget>[
        _tabPage(
          currentIndex,
          0,
          InputPage(
            category: category,
          ),
        ),
        _tabPage(
          currentIndex,
          1,
          PlayerListPage(
            category: category,
          ),
        ),
        _tabPage(
          currentIndex,
          2,
          AnalysisPage(
            category: category,
          ),
        ),
        _tabPage(
          currentIndex,
          3,
          StrategyBoardPage(),
        ),
      ],
    );
  }

  Widget _tabPage(int currentIndex, int tabIndex, StatelessWidget page) {
    return Visibility(
      visible: currentIndex == tabIndex,
      maintainState: true,
      child: page,
    );
  }
}
