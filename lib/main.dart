import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_build/presentation/dummyTop/dummy_top_page.dart';
import 'package:test_build/presentation/introduction/introduction_model.dart';
import 'package:test_build/presentation/introduction/introduction_page.dart';
import 'package:test_build/presentation/top/top_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Futsal Analyse',
      theme: ThemeData.dark(),
      home: ChangeNotifierProvider<IntroductionModel>(
        create: (_) => IntroductionModel()..getPrefIntro(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Consumer<IntroductionModel>(
            builder: (context, model, child) {
              return model.intro == true ? IntroductionPage() : DummyTopPage();
            },
          ),
        ),
      ),
    );
  }
}
