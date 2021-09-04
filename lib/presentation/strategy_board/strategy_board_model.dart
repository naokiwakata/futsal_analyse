import 'package:flutter/material.dart';
import 'package:test_build/domain/cursor.dart';

class StrategyBoardModel extends ChangeNotifier {
  Cursor cursorRed1 = Cursor(30, 100);
  Cursor cursorRed2 = Cursor(80, 100);
  Cursor cursorRed3 = Cursor(130, 100);
  Cursor cursorRed4 = Cursor(180, 100);
  Cursor cursorRed5 = Cursor(230, 100);

  Cursor cursorBlue1 = Cursor(30, 400);
  Cursor cursorBlue2 = Cursor(80, 400);
  Cursor cursorBlue3 = Cursor(130, 400);
  Cursor cursorBlue4 = Cursor(180, 400);
  Cursor cursorBlue5 = Cursor(230, 400);

  Cursor cursorBall = Cursor(30, 250);

  void changePoint(Cursor cursor, double dx, double dy) {
    cursor.x += dx;
    cursor.y += dy;
    notifyListeners();
  }

  void clearPoint() {
    cursorRed1 = Cursor(30, 100);
    cursorRed2 = Cursor(80, 100);
    cursorRed3 = Cursor(130, 100);
    cursorRed4 = Cursor(180, 100);
    cursorRed5 = Cursor(230, 100);

    cursorBlue1 = Cursor(30, 400);
    cursorBlue2 = Cursor(80, 400);
    cursorBlue3 = Cursor(130, 400);
    cursorBlue4 = Cursor(180, 400);
    cursorBlue5 = Cursor(230, 400);

    cursorBall = Cursor(30, 250);
    notifyListeners();
  }
}
