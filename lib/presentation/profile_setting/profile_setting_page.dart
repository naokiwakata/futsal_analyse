import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:test_build/presentation/dummyTop/dummy_top_page.dart';
import 'package:test_build/presentation/profile_setting/profile_setting_model.dart';
import 'package:test_build/service/service/dialog_helper.dart';

class ProfileSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileSettingModel>(
      create: (_) => ProfileSettingModel()..initState(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'プロフィール',
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Consumer<ProfileSettingModel>(
          builder: (context, model, child) {
            return !model.loadingDate
                ? ListView(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          model.teamName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text('チーム名'),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('チーム名編集'),
                                content: TextField(
                                  decoration:
                                      InputDecoration(hintText: model.teamName),
                                  onChanged: (value) {
                                    model.editName = value;
                                  },
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('キャンセル'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text('更新'),
                                    onPressed: () async {
                                      if (model.editName != '') {
                                        await model.editTeamName();
                                        Navigator.pop(context);
                                      } else {
                                        showAlertDialog(context, '入力をしてください');
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text(
                          'ログアウト',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('ログアウトしますか？'),
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
                                      await model.logOut();
                                      await Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DummyTopPage(),
                                          ),
                                          (_) => false);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      Divider(),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: Colors.redAccent,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
