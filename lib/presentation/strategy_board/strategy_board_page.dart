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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              model.clearPoint();
            },
            child: const Icon(Icons.clear),
            backgroundColor: Colors.redAccent,
          ),
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Divider(
                    height: 5,
                    thickness: 5,
                    color: Colors.grey,
                  ),
                  Divider(
                    height: 5,
                    thickness: 5,
                    color: Colors.grey,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VerticalDivider(
                    width: 5,
                    thickness: 5,
                    color: Colors.grey,
                  ),
                  VerticalDivider(
                    width: 5,
                    thickness: 5,
                    color: Colors.grey,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 5,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(80),
                            bottomRight: Radius.circular(80),
                          ),
                        ),
                        height: 100,
                        width: 200,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 5,
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(80),
                            topLeft: Radius.circular(80),
                          ),
                        ),
                        height: 100,
                        width: 200,
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  height: 160,
                  width: 160,
                ),
              ),
              Center(
                child: Divider(
                  thickness: 5,
                  color: Colors.grey,
                ),
              ),
              Stack(
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
                  movingCursor(model, model.cursorBall, Colors.white),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget movingCursor(StrategyBoardModel model, Cursor cursor, Color color) {
    return Positioned(
      top: cursor.y,
      left: cursor.x,
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          model.changePoint(cursor, details.delta.dx, details.delta.dy);
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
