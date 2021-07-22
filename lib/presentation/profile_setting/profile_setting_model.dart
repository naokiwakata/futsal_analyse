import 'package:flutter/material.dart';
import 'package:test_build/domain/teams.dart';
import 'package:test_build/repository/auth_repository.dart';
import 'package:test_build/repository/teams_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileSettingModel extends ChangeNotifier {
  final _teamsRepository = TeamsRepository.instance;
  final authRepository = AuthRepository.instance;
  Team team;
  String teamName = '';
  String editName = '';
  bool loadingDate = false;

  Future initState() async {
    if(authRepository.isLogin){
      startLoading();
      team = await _teamsRepository.fetch();
      print('${team.uid} init');
      teamName = team.teamName;
      endLoading();
    }else{
      teamName ='なし';
    }
    notifyListeners();
  }

  launchInApp() async {
    const url = 'https://list-ad8ab.firebaseapp.com/';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    } else {
      throw 'このURLにはアクセスできません';
    }
  }

  Future logOut() async {
    await authRepository.signOut();
    _teamsRepository.deleteLocalCache();
    print('ログアウト');
    notifyListeners();
  }

  Future editTeamName() async {
    await _teamsRepository.updateTeamName(teamName: editName, team: team);
    print('更新');
    teamName = editName;
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
