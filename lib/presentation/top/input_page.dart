import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/game.dart';
import 'package:test_build/presentation/input_game_data/input_game_data_page.dart';
import 'package:test_build/service/service/dialog_helper.dart';

import 'input_model.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InputPage extends StatelessWidget {
  InputPage({this.category});

  final Categorys category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InputModel>(
      create: (_) => InputModel()..initState(category),
      child: Consumer<InputModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: _bodySection(context, model),
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
                    showAddGameDialog(context, model);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _bodySection(BuildContext context, InputModel model) {
    if (model.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.redAccent,
        ),
      );
    }
    if (model.gameList.isEmpty) {
      return Center(
        child: Text('試合の成績を追加しよう'),
      );
    }
    return Container(
      child: ListView(
        children: gameList(model, context),
      ),
    );
  }

  List<Widget> gameList(InputModel model, BuildContext context) {
    final gameList = model.gameList
        .map(
          (game) => Slidable(
            actionExtentRatio: 0.2,
            actionPane: SlidableScrollActionPane(),
            secondaryActions: [
              IconSlideAction(
                caption: '削除',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('本当に削除しますか？'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () async {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('マジで削除しますか？'),
                                    actions: [
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          await model.deleteGame(game);
                                          model.getGame();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('キャンセル'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          TextButton(
                            child: Text('キャンセル'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ],
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => InputGameDataPage(
                            game: game,
                            category: category,
                          ),
                      fullscreenDialog: true),
                );
                model.getGame();
              },
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    child: Container(
                      height: 60,
                      padding: EdgeInsets.all(13.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  DateFormat("yyyy/MM/dd")
                                      .format(
                                        game.gameDate.toDate(),
                                      )
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Text(
                                  game.opponentName,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  showEditGameDialog(context, model, game);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
    return gameList;
  }

  showAddGameDialog(BuildContext context, InputModel model) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: Duration(milliseconds: 100),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, animation1, animation2, widget) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blueGrey),
              padding:
                  EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
              height: 210,
              width: 300,
              child: Column(
                children: [
                  Container(
                    height: 30,
                    child: Text(
                      '試合',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: ButtonTheme(
                      buttonColor: Colors.redAccent,
                      child: ElevatedButton.icon(
                        // 日付を取得
                        icon: Icon(
                          Icons.arrow_drop_down,
                        ),
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: new DateTime.now(),
                            firstDate:
                                DateTime.now().add(Duration(days: -1095)),
                            lastDate: DateTime.now().add(Duration(days: 1095)),
                          );
                          model.getDate(pickedDate);
                        },
                        label: model.gameDate != null
                            ? Text(
                                '${(DateFormat('yyyy/MM/dd')).format(model.gameDate)}',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            : Text(
                                '日付を選ぶ',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      onChanged: (value) {
                        model.opponentName = value;
                      },
                      decoration: InputDecoration(
                        hintText: "対戦相手",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          'キャンセル',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          model.clearTextField();
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        child: Text(
                          '追加',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (model.gameDate != null &&
                              model.opponentName != '') {
                            Navigator.pop(context);
                            await model.addGame();
                            await model.initState(category);
                            model.clearTextField();
                          } else {
                            showAlertDialog(context, '入力してください');
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showEditGameDialog(BuildContext context, InputModel model, Game game) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: Duration(milliseconds: 100),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, animation1, animation2, widget) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blueGrey),
              padding:
                  EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
              height: 210,
              width: 300,
              child: Column(
                children: [
                  Container(
                    height: 30,
                    child: Text(
                      '編集する',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: ButtonTheme(
                      buttonColor: Colors.redAccent,
                      child: ElevatedButton.icon(
                        // 日付を取得
                        icon: Icon(
                          Icons.arrow_drop_down,
                        ),
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: new DateTime.now(),
                            firstDate:
                                DateTime.now().add(Duration(days: -1095)),
                            lastDate: DateTime.now().add(Duration(days: 1095)),
                          );
                          model.getDate(pickedDate);
                        },
                        label: model.gameDate != null
                            ? Text(
                                '${(DateFormat('yyyy/MM/dd')).format(model.gameDate)}',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            : Text(
                                '日付を選ぶ',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      onChanged: (value) {
                        model.opponentName = value;
                      },
                      decoration: InputDecoration(
                        hintText: game.opponentName,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          'キャンセル',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          model.clearTextField();
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        child: Text(
                          '更新',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (model.gameDate != null &&
                              model.opponentName != '') {
                            Navigator.pop(context);
                            await model.updatgeGame(game);
                            await model.initState(category);
                            model.clearTextField();
                          } else {
                            showAlertDialog(context, '入力してください');
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
