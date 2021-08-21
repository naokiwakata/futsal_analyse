import 'package:flutter/material.dart';
import 'package:test_build/domain/cursor.dart';

class StrategyBoardModel extends ChangeNotifier {
  Cursor cursorRed1 = Cursor(50, 50);
  Cursor cursorRed2 = Cursor(50, 100);
  Cursor cursorRed3 = Cursor(50, 150);
  Cursor cursorRed4 = Cursor(50, 200);
  Cursor cursorRed5 = Cursor(50, 250);

  Cursor cursorBlue1 = Cursor(50, 350);
  Cursor cursorBlue2 = Cursor(50, 400);
  Cursor cursorBlue3 = Cursor(50, 450);
  Cursor cursorBlue4 = Cursor(50, 500);
  Cursor cursorBlue5 = Cursor(50, 550);

  Cursor cursorBall = Cursor(50, 300);

  void changePoint(Cursor cursor, double dx, double dy) {
    cursor.x += dx;
    cursor.y += dy;
    notifyListeners();
  }

  void clearPoint() {
    cursorRed1 = Cursor(50, 50);
    cursorRed2 = Cursor(50, 100);
    cursorRed3 = Cursor(50, 150);
    cursorRed4 = Cursor(50, 200);
    cursorRed5 = Cursor(50, 250);

    cursorBlue1 = Cursor(50, 350);
    cursorBlue2 = Cursor(50, 400);
    cursorBlue3 = Cursor(50, 450);
    cursorBlue4 = Cursor(50, 500);
    cursorBlue5 = Cursor(50, 550);

    cursorBall = Cursor(50, 300);
    notifyListeners();
  }
}
