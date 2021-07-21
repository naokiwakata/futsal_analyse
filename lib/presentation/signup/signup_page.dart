import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:test_build/presentation/dummyTop/dummy_top_page.dart';
import 'package:test_build/presentation/signup/signup_model.dart';
import 'package:test_build/service/service/dialog_helper.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final AutovalidateMode _validate = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpPageModel>(
      create: (_) => SignUpPageModel(),
      child: Consumer<SignUpPageModel>(builder: (context, model, child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _validate,
                    child: Column(
                      children: <Widget>[
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(minWidth: double.infinity),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 8.0, left: 8.0),
                            child: TextFormField(
                                autofocus: true,
                                onChanged: (String val) {
                                  model.onChangedDisplayName(val);
                                },
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                cursorColor: Colors.redAccent,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  hintText: 'チーム名',
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: BorderSide(
                                          color: Colors.redAccent, width: 2.0)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) return '1文字以上入力してください';
                                  return null;
                                }),
                          ),
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(minWidth: double.infinity),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 8.0, left: 8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onChanged: (String val) {
                                model.onChangedEmail(val);
                              },
                              cursorColor: Colors.orange,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                hintText: 'メールアドレス',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2.0)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              validator: (value) {
                                //20文字以内かつ英数字と-_が使われている場合に通る
                                if (value.isEmpty) return 'メールアドレスを入力してください';
                                if (!EmailValidator.validate(value))
                                  return '正しいメールアドレスを入力しください';
                                return null;
                              },
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(minWidth: double.infinity),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 8.0, left: 8.0),
                            child: TextFormField(
                              obscureText: true,
                              textInputAction: TextInputAction.next,
                              controller: _passwordController,
                              onChanged: (String val) {
                                model.onChangedPassword(val);
                              },
                              style: TextStyle(height: 0.8, fontSize: 18.0),
                              cursorColor: Colors.orange,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                hintText: 'パスワード',
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
                              right: 40.0, left: 40.0, top: 40.0),
                          child: ConstrainedBox(
                            constraints:
                                const BoxConstraints(minWidth: double.infinity),
                            child: ElevatedButton(
                                child: Text(
                                  "新規登録",
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
                                      side: BorderSide(color: Colors.orange)),
                                ),
                                onPressed: () async {
                                  final isValidateOK =
                                      _formKey.currentState.validate();
                                  if (isValidateOK) {
                                    model.startLoading();
                                    FocusScope.of(context).unfocus();
                                    try {
                                      await model.signUp();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DummyTopPage(),
                                        ),
                                      );
                                      showAlertDialog(context, '登録しました');
                                    } catch (e) {
                                      showAlertDialog(context, e.toString());
                                    } finally {
                                      model.endLoading();
                                    }
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Consumer<SignUpPageModel>(
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
        );
      }),
    );
  }
}
