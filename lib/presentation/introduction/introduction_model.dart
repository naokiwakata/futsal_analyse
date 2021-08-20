import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionModel extends ChangeNotifier {
  bool intro = false;

  getPrefIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「intro」がキー名。見つからなければtrueを返す
    intro = prefs.getBool('intro') ?? true;
    notifyListeners();
  }

  setIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("intro", false);
    notifyListeners();
  }

  var listPagesViewModel = [
    PageViewModel(
      title: "アプリの使い方",
      body: "アプリをインストールしてくれて\nありがとうございます！！\nフットサルの試合結果を記録し\n分析するアプリです！",
      image: const Center(
        child: Icon(
          Icons.auto_graph,
          size: 200,
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            color: Colors.redAccent, fontSize: 30, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
      ),
    ),
    PageViewModel(
      title: "カテゴリー",
      body:
      'カテゴリーを追加してカテゴリーごとに\n結果を記録しよう!',
      image: const Center(
          child: Icon(
            Icons.list,
            size: 200,
          )),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            color: Colors.redAccent, fontSize: 30, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
      ),
    ),
    PageViewModel(
      title: "試合画面",
      body: '試合結果を追加しよう！',
      image: const Center(
          child: Icon(
        Icons.edit,
        size: 200,
      )),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            color: Colors.redAccent, fontSize: 30, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
      ),
    ),
    PageViewModel(
      title: "選手画面",
      body: '選手を登録しよう！',
      image: const Center(
          child: Icon(
        Icons.group,
        size: 200,
      )),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            color: Colors.redAccent, fontSize: 30, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
      ),
    ),
    PageViewModel(
      title: "分析画面",
      body: '入力した試合結果からチーム状況を分析！',
      image: const Center(
          child: Icon(
        Icons.insights,
        size: 200,
      )),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            color: Colors.redAccent, fontSize: 30, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
      ),
    ),
  ];
}
