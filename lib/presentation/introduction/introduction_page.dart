import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:test_build/presentation/dummyTop/dummy_top_page.dart';
import 'package:test_build/presentation/introduction/introduction_model.dart';

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IntroductionModel>(
      create: (_) => IntroductionModel(),
      child: Scaffold(
        body: Consumer<IntroductionModel>(
          builder: (context, model, child) {
            return IntroductionScreen(
              pages: model.listPagesViewModel,
              onDone: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => DummyTopPage(),
                    ),
                    (_) => false);
                model.setIntro();
              },
              showSkipButton: true,
              skip: const Text(
                "スキップ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
              next: const Text(
                '次へ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
              done: const Text(
                "アプリへ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
