import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/presentation/lobby/lobby_page.dart';
import 'package:test_build/presentation/register_team/register_team_model.dart';
import 'package:test_build/presentation/top/top_page.dart';
import 'package:test_build/service/service/dialog_helper.dart';

class RegisterCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterCategoryModel>(
      create: (_) => RegisterCategoryModel()..initState(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'カテゴリー',
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Consumer<RegisterCategoryModel>(
          builder: (context, model, child) {
            return !model.loadingDate
                ? model.categoryList.isNotEmpty
                    ? Container(
                        child: Scrollbar(
                          child: ListView(
                            children: friendList(model, context),
                          ),
                        ),
                      )
                    : Center(
                        child: Text('カテゴリーを登録して\n試合の成績を記録しよう'),
                      )
                : Center(
                    child: CircularProgressIndicator(
                      color: Colors.redAccent,
                    ),
                  );
          },
        ),
        floatingActionButton: Consumer<RegisterCategoryModel>(
          builder: (context, model, child) {
            return FloatingActionButton.extended(
              label: Text(
                'カテゴリー追加',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.redAccent,
              onPressed: () async {
                showAddCategoryDialog(context, model);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> friendList(RegisterCategoryModel model, BuildContext context) {
    final friendList = model.categoryList
        .map(
          (category) => Slidable(
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
                                    title: Text('本当の本当に削除しますか？'),
                                    actions: [
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          await model.deleteCategory(category);
                                          model.getCategory();
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
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopPage(
                        category: category,
                      ),
                    ),
                    (_) => false);
              },
              child: Column(
                children: [
                  Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 60,
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Container(
                                      child: Text(
                                        category.categoryName,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                showEditGameDialog(context, model, category);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
    return friendList;
  }

  showAddCategoryDialog(BuildContext context, RegisterCategoryModel model) {
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
              height: 180,
              width: 300,
              child: Column(
                children: [
                  Container(
                    height: 30,
                    child: Text(
                      'カテゴリーを追加する',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      onChanged: (value) {
                        model.categoryName = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'カテゴリー',
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
                          if (model.categoryName != "") {
                            Navigator.pop(context);
                            await model.addCategory();
                            await model.getCategory();
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

  showEditGameDialog(
      BuildContext context, RegisterCategoryModel model, Categorys category) {
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
              height: 180,
              width: 300,
              child: Column(
                children: [
                  Container(
                    height: 30,
                    child: Text(
                      '名前を編集する',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      onChanged: (value) {
                        model.categoryName = value;
                      },
                      decoration: InputDecoration(
                        hintText: category.categoryName,
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
                          if (model.categoryName != "") {
                            Navigator.pop(context);
                            await model.updateCategory(category);
                            await model.getCategory();
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

  showLoginDialog(BuildContext context, RegisterCategoryModel model) {
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
