import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_build/domain/cursor.dart';
import 'package:test_build/presentation/strategy_board/strategy_board_model.dart';

class StrategyBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StrategyBoardModel>(
      create: (_) => StrategyBoardModel(),
      child: Consumer<StrategyBoardModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Stack(
            children: [
              movingCursor(model, model.cursorRed1, Colors.red),
              movingCursor(model, model.cursorRed2, Colors.red),
              movingCursor(model, model.cursorRed3, Colors.red),
              movingCursor(model, model.cursorRed4, Colors.red),
              movingCursor(model, model.cursorRed5, Colors.red),
              movingCursor(model, model.cursorBlue1, Colors.blue),
              movingCursor(model, model.cursorBlue2, Colors.blue),
              movingCursor(model, model.cursorBlue3, Colors.blue),
              movingCursor(model, model.cursorBlue4, Colors.blue),
              movingCursor(model, model.cursorBlue5, Colors.blue),

              movingCursor(model, model.cursorBall, Colors.grey),
            ],
          ),
        );
      }),
    );
  }

  Widget movingCursor(
      StrategyBoardModel model, Cursor cursor, Color color) {
    return Positioned(
      top: cursor.y,
      left: cursor.x,
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          print(details.delta);
          model.changePoint(cursor,details.delta.dx, details.delta.dy);
        },
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
