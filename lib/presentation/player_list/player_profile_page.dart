import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_build/domain/player.dart';
import 'package:test_build/presentation/player_list/player_list_model.dart';

class PlayerProfilePage extends StatelessWidget {
  PlayerProfilePage({this.player});

  final Player player;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlayerListModel>(
      create: (_) => PlayerListModel(),
      child: Consumer<PlayerListModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('プレイヤー'),
            ),
            body: Container(
              height: 380,
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '選手  ',
                              style: TextStyle(fontSize: 20),
                            ),
                            Row(
                              children: [
                                Text(
                                  'No. ${player.uniformNumber.toString()}  ',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  player.playerName,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ポジション  ',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              player.position,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            player.position == 'FP'
                                ? Text(
                                    'ゴール  ',
                                    style: TextStyle(fontSize: 20),
                                  )
                                : Text(
                                    '失点  ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                            player.position == 'FP'
                                ? Text(
                                    '${player.goal.toString()} G',
                                    style: TextStyle(fontSize: 20),
                                  )
                                : Text(
                                    '${player.scored.toString()} G',
                                    style: TextStyle(fontSize: 20),
                                  ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            player.position == 'FP'
                                ? Text(
                                    'シュート  ',
                                    style: TextStyle(fontSize: 20),
                                  )
                                : Text(
                                    '被シュート  ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                            player.position == 'FP'
                                ? Text(
                                    '${player.shoot.toString()} 本',
                                    style: TextStyle(fontSize: 20),
                                  )
                                : Text(
                                    '${player.scored.toString()} 本',
                                    style: TextStyle(fontSize: 20),
                                  ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '出場  ',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              '${player.participation.toString()} 回',
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
