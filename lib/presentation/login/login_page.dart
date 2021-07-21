import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_build/presentation/dummyTop/dummy_top_page.dart';
import 'package:test_build/presentation/login/login_model.dart';
import 'package:test_build/service/service/dialog_helper.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginPageModel>(
      create: (_) => LoginPageModel(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(),
            body: Consumer<LoginPageModel>(builder: (context, model, child) {
              return Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints(minWidth: double.infinity),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, right: 24.0, left: 24.0),
                        child: TextFormField(
                          autofocus: true,
                          textAlignVertical: TextAlignVertical.center,
                          textInputAction: TextInputAction.next,
                          onChanged: (String val) {
                            model.onChangeEmail(val);
                          },
                          style: TextStyle(fontSize: 18.0),
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.redAccent,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 16, right: 16),
                            hintText: "メールアドレス",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1),
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 2.0)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) return 'メールアドレスを入力してください';
                            if (!EmailValidator.validate(value))
                              return '正しいメールアドレスを入力しください';

                            return null;
                          },
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(minWidth: double.infinity),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, right: 24.0, left: 24.0),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (String val) {
                            model.onChangePassword(val);
                          },
                          onFieldSubmitted: (password) async {},
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(fontSize: 18.0),
                          cursorColor: Colors.redAccent,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 16, right: 16),
                            hintText: "パスワード",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 2.0)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          validator: (value) {
                            //20文字以内かつ英数字と-_が使われている場合に通る
                            if (value.isEmpty) return 'パスワードを入力してください';
                            if (value.length > 20)
                              return 'パスワードは6文字以内で入力してください';
                            if (value.contains(" ") || value.contains("　"))
                              return '空白文字が含まれています。';
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 40.0, left: 40.0, top: 40),
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        child: ElevatedButton(
                          child: Text(
                            "ログイン",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                                side: BorderSide(color: Colors.redAccent)),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              model.startLoading();
                              FocusScope.of(context).unfocus();
                              try {
                                await model.login();
                                await Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DummyTopPage(),
                                    ),
                                    (_) => false);
                              } catch (e) {
                                showAlertDialog(context,
                                    "ログインに失敗しました。メールアドレスとパスワードを確認してください。");
                              } finally {
                                model.endLoading();
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          Consumer<LoginPageModel>(
            builder: (context, model, child) {
              return model.isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.redAccent,
                        ),
                      ),
                    )
                  : SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
