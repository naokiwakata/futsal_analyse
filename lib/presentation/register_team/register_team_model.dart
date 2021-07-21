import 'package:flutter/material.dart';
import 'package:test_build/domain/category.dart';
import 'package:test_build/domain/teams.dart';
import 'package:test_build/repository/teams_repository.dart';

class RegisterCategoryModel extends ChangeNotifier {
  final _teamsRepository = TeamsRepository.instance;
  List<Categorys> categoryList = [];
  Team team;
  String categoryName = '';
  bool loadingDate = false;

  Future initState() async {
    startLoading();

    team = await _teamsRepository.fetch();
    print(team.uid);
    await getCategory();
    endLoading();
    notifyListeners();
  }

  Future getCategory() async {
    categoryList = await _teamsRepository.getCategory();
    print(categoryList);
    notifyListeners();
  }

  void initValue() {
    categoryName = '';
    notifyListeners();
  }

  Future addCategory() async {
    _teamsRepository.addCategory(categoryName, team);
    notifyListeners();
  }

  Future deleteCategory(Categorys category) async {
    _teamsRepository.deleteCategory(team: team, category: category);
    notifyListeners();
  }

  Future updateCategory(Categorys category) async {
    _teamsRepository.updateCategory(
        categoryName: categoryName, team: team, category: category);
    notifyListeners();
  }

  void startLoading() {
    loadingDate = true;
    notifyListeners();
  }

  void endLoading() {
    loadingDate = false;
    notifyListeners();
  }
}
