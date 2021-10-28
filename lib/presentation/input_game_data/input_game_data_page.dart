import 'package:flutter/material.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/game.dart';
import 'package:test_build/presentation/input_game_data/input_game_data_model.dart';
import 'player_stats_page.dart';
import 'team_stats_page.dart';
import 'package:provider/provider.dart';

class InputGameDataPage extends StatelessWidget {
  InputGameDataPage({this.game, this.category});
  
  final Game game;
  final Categorys category;
  final List<String> _tabNames = [
    "チーム",
    "個人",
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InputGameDataModel>(
      create: (_) => InputGameDataModel()..initState(game,category),
      child: Consumer<InputGameDataModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () async{
                  if (game.firstUpdate!=null && game.firstUpdate) {
                    await _showFinishDialog(context, model);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              title: Text(
                'VS ${game.opponentName} 試合詳細',
                style: TextStyle(fontSize: 20),
              ),
            ),
            body: _topPageBody(context),
            bottomNavigationBar: SizedBox(
              child: BottomNavigationBar(
                selectedItemColor: Colors.redAccent,
                onTap: model.onTabTapped,
                currentIndex: model.currentIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.edit),
                    label: _tabNames[0],
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.group),
                    label: _tabNames[1],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _topPageBody(BuildContext context) {
    final model = Provider.of<InputGameDataModel>(context);
    final currentIndex = model.currentIndex;
    return Stack(
      children: <Widget>[
        _tabPage(
          currentIndex,
          0,
          TeamsStatsPage(
            game: game,
            category: category,
          ),
        ),
        _tabPage(
          currentIndex,
          1,
          PlayerStatsPage(
            game: game,
            category: category,
          ),
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

  _showFinishDialog(BuildContext context, InputGameDataModel model) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('入力を終了しますか？'),
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
                model.finishFirstInput();
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
