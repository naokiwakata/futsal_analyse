import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/game.dart';
import 'package:test_build/domain/player.dart';
import 'package:test_build/presentation/input_game_data/player_stats_model.dart';
import 'package:test_build/service/service/dialog_helper.dart';
import 'package:test_build/service/service/showModalPicker.dart';

class PlayerStatsPage extends StatelessWidget {
  PlayerStatsPage({this.category, this.game});

  final Game game;
  final Categorys category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlayerStatsModel>(
      create: (_) => PlayerStatsModel()..initState(category, game),
      child: Scaffold(
        body: Consumer<PlayerStatsModel>(
          builder: (context, model, child) {
            return Container(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Text(
                                'GK',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '被シュート',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '失点',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '出場回数 ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 0,
                      ),
                      model.gameGKList.isNotEmpty
                          ? Container(
                              height: 100,
                              child: ListView(
                                children: playerList(model.gameGKList, context),
                              ),
                            )
                          : Container(
                              height: 100,
                              width: double.infinity,
                              child: Center(
                                child: Text('データなし'),
                              ),
                            ),
                      Divider(
                        thickness: 1,
                        height: 0,
                      ),
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Text(
                                'FP',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: !model.hasShownParticipation
                                  ? Text(
                                      'シュート',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Text(
                                      '得点時',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                            Container(
                              child: !model.hasShownParticipation
                                  ? Text(
                                      'ゴール',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Text(
                                      '失点時',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                            Container(
                              child: Text(
                                '出場回数 ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 0,
                      ),
                      model.gameFPList.isNotEmpty
                          ? Expanded(
                              child: Container(
                                height: 550,
                                child: Scrollbar(
                                  child: ListView(
                                    children: !model.hasShownParticipation
                                        ? playerList(model.gameFPList, context)
                                        : participationList(
                                            model.gameFPList, context),
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Container(
                                height: 600,
                                width: double.infinity,
                                child: Center(
                                  child: Text('データなし'),
                                ),
                              ),
                            ),
                      Stack(
                        children: [
                          Container(
                            height: 80,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, top: 16),
                                child: IconButton(
                                  icon: Icon(Icons.change_circle),
                                  onPressed: () {
                                    model.changeFPlist();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('シュート ${model.allShoot}'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('被シュート ${model.allShot}')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  showGK(context, model),
                  showFP(model, context),
                ],
              ),
            );
          },
        ),
        floatingActionButton: Consumer<PlayerStatsModel>(
          builder: (context, model, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  backgroundColor: Colors.redAccent,
                  label: Text(
                    'GK追加',
                    style: TextStyle(color: Colors.white),
                  ),
                  heroTag: 'tag5',
                  onPressed: () {
                    model.selectGK();
                    model.initValue();
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                FloatingActionButton.extended(
                  backgroundColor: Colors.redAccent,
                  heroTag: 'tag6',
                  label: Text(
                    'FP追加',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    model.selectFP();
                    model.initValue();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> playerList(List<Player> list, BuildContext context) {
    final playerList = list
        .map(
          (player) => Column(
            children: [
              Container(
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            child: Text(
                              player.uniformNumber.toString(),
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              player.playerName,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: player.position == 'FP'
                            ? Text(
                                player.shoot.toString(),
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              )
                            : Text(
                                player.shot.toString(),
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: player.position == 'FP'
                            ? Text(
                                player.goal.toString(),
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              )
                            : Text(
                                player.scored.toString(),
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text(
                          player.participation.toString(),
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1.0,
                height: 0,
              ),
            ],
          ),
        )
        .toList();
    return playerList;
  }

  List<Widget> participationList(List<Player> list, BuildContext context) {
    final playerList = list
        .map(
          (player) => Column(
            children: [
              Container(
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            child: Text(
                              player.uniformNumber.toString(),
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              player.playerName,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          child: Text(
                        player.tokutenParticipation.toString(),
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text(
                          player.shittenParticipation.toString(),
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text(
                          player.participation.toString(),
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1.0,
                height: 0,
              ),
            ],
          ),
        )
        .toList();
    return playerList;
  }

  Widget showFP(PlayerStatsModel model, BuildContext context) {
    return Center(
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),
        onEnd: () => print("アニメーション終了"),
        child: Card(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            padding: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
            height: model.selectedFP ? 380 : 0,
            width: model.selectedFP ? 300 : 0,
            child: Column(
              children: [
                Container(
                  height: 20,
                  child: Text(
                    'FP',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 260,
                  child: ElevatedButton(
                    child: Text(
                      model.playerName,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      showModalSelectPicker(
                          context, model.fpNameList, model.onSelectedFP);
                    },
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(
                        '得点時',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                model.decrementTokutenParticipation();
                              },
                              child: Text(
                                '-',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  model.tokutenParticipation.toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                model.incrementTokutenParticipation();
                              },
                              child: Text(
                                '+',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(
                        '失点時',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                model.decrementShittenParticipation();
                              },
                              child: Text(
                                '-',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  model.shittenParticipation.toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                model.incrementShittenParticipation();
                              },
                              child: Text(
                                '+',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(
                        'シュート',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                model.decrementShoot();
                              },
                              child: Text('-'),
                            ),
                            Container(
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  model.shoot.toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                model.incrementShoot();
                              },
                              child: Text('+'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(
                        'ゴール',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                model.decrementGoal();
                              },
                              child: Text(
                                '-',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  model.goal.toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                model.incrementGoal();
                              },
                              child: Text(
                                '+',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(
                        '出場回数',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                model.decrementParticipation();
                              },
                              child: Text(
                                '-',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  model.participation.toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                model.incrementParticipation();
                              },
                              child: Text(
                                '+',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text('キャンセル'),
                      onPressed: () {
                        model.unSelectFP();
                        model.unSelectGK();
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      child: Text('追加'),
                      onPressed: () async {
                        if (model.playerName != '選手を選ぶ') {
                          model.unSelectFP();
                          model.unSelectGK();
                          await model.addGameFP();
                          model.getFP();
                        } else {
                          showAlertDialog(context, '選手を選んでください');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showGK(BuildContext context, PlayerStatsModel model) {
    return Center(
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),
        onEnd: () => print("アニメーション終了"),
        child: Card(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            padding: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
            height: model.selectedGK ? 380 : 0,
            width: model.selectedGK ? 300 : 0,
            child: Column(
              children: [
                Container(
                  height: 30,
                  child: Text(
                    'GK',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    child: Text(
                      model.playerName,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      showModalSelectPicker(
                          context, model.gkNameList, model.onSelectedGK);
                    },
                  ),
                ),
                Text(
                  '被シュート',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            model.decrementShot();
                          },
                          child: Text('-'),
                        ),
                        Container(
                          width: 50,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              model.shot.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            model.incrementShot();
                          },
                          child: Text('+'),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  '失点',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            model.decrementScored();
                          },
                          child: Text(
                            '-',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              model.scored.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            model.incrementScored();
                          },
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  '出場回数',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            model.decrementParticipation();
                          },
                          child: Text(
                            '-',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              model.participation.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            model.incrementParticipation();
                          },
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text('キャンセル'),
                      onPressed: () {
                        model.unSelectFP();
                        model.unSelectGK();
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      child: Text('追加'),
                      onPressed: () async {
                        if (model.playerName != '選手を選ぶ') {
                          model.unSelectFP();
                          model.unSelectGK();
                          await model.addGameGK();
                          model.getGK();
                        } else {
                          showAlertDialog(context, '選手を選んでください');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
