import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_build/presentation/dummyTop/dummy_top_model.dart';
import 'package:test_build/presentation/lobby/lobby_page.dart';
import 'package:test_build/presentation/profile_setting/profile_setting_page.dart';
import 'package:test_build/presentation/register_team/register_team_page.dart';
import 'package:test_build/presentation/strategy_board/strategy_board_page.dart';

class DummyTopPage extends StatelessWidget {
  final List<String> _tabNames = ["試合", "選手", "分析", "作戦ボード"];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DummyTopModel>(
      create: (_) => DummyTopModel()..initState(),
      child: Consumer<DummyTopModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'カテゴリー未選択',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
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
                    if (model.authRepository.isLogin) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RegisterCategoryPage(),
                            fullscreenDialog: true),
                      );
                    } else {
                      showLoginDialog(context);
                    }
                  },
                ),
              ],
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

  Widget _topPageBody(BuildContext context, DummyTopModel model) {
    final currentIndex = model.currentIndex;

    return Stack(
      children: <Widget>[
        _tabPage(
          currentIndex,
          0,
          _inputGamePage(context, model),
        ),
        _tabPage(
          currentIndex,
          2,
          _analysePage(context, model),
        ),
        _tabPage(
          currentIndex,
          1,
          _playerPage(context, model),
        ),
        _tabPage(
          currentIndex,
          3,
          StrategyBoardPage(),
        ),
      ],
    );
  }

  showCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('カテゴリーを選択しよう'),
          actions: <Widget>[
            TextButton(
              child: Text('キャンセル'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterCategoryPage(),
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _inputGamePage(BuildContext context, DummyTopModel model) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Text('カテゴリーが未選択です'),
        ),
        floatingActionButton: Column(
          verticalDirection: VerticalDirection.up, // childrenの先頭を下に配置
          children: [
            FloatingActionButton.extended(
              backgroundColor: Colors.redAccent,
              label: Text(
                '試合追加',
                style: TextStyle(color: Colors.white),
              ),
              heroTag: 'hero1',
              onPressed: () async {
                if (model.authRepository.isLogin) {
                  showCategoryDialog(context);
                } else {
                  showLoginDialog(context);
                }
              },
              icon: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _playerPage(BuildContext context, DummyTopModel model) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Text('カテゴリーが未選択です'),
        ),
        floatingActionButton: Column(
          verticalDirection: VerticalDirection.up, // childrenの先頭を下に配置
          children: [
            FloatingActionButton.extended(
              backgroundColor: Colors.redAccent,
              label: Text(
                '選手追加',
                style: TextStyle(color: Colors.white),
              ),
              heroTag: 'hero3',
              onPressed: () async {
                if (model.authRepository.isLogin) {
                  showCategoryDialog(context);
                } else {
                  showLoginDialog(context);
                }
              },
              icon: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _analysePage(BuildContext context, DummyTopModel model) {
    Widget _analyseTile(
        BuildContext context, DummyTopModel model, String title) {
      return Column(
        children: [
          InkWell(
            onTap: () {
              if (model.authRepository.isLogin) {
                showCategoryDialog(context);
              } else {
                showLoginDialog(context);
              }
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

    return Container(
      child: Column(
        children: [
          _analyseTile(context, model, 'FPランキング'),
          _analyseTile(context, model, 'GKランキング'),
          _analyseTile(context, model, '得失点分析'),
          _analyseTile(context, model, '各試合分析'),
          _analyseTile(context, model, '出場分析'),
          _analyseTile(context, model, '全体分析'),
        ],
      ),
    );
  }

  Widget _tabPage(int currentIndex, int tabIndex, StatelessWidget page) {
    return Visibility(
      visible: currentIndex == tabIndex,
      maintainState: true,
      child: page,
    );
  }

  showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('ログインが必要です'),
          actions: <Widget>[
            TextButton(
              child: Text('キャンセル'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LobbyPage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
