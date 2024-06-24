import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell.dart';

class CellState {
  CellState({
    required this.x,
    required this.y,
    required this.isBomb,
    required this.type,
    required this.closeCells,
  });

  int x;
  int y;
  bool isBomb;
  CellStateTypes type;
  CloseCells closeCells;

  CellState copyWith({
    int? x,
    int? y,
    bool? isBomb,
    CellStateTypes? type,
    CloseCells? closeCells,
  }) {
    return CellState(
      x: x ?? this.x,
      y: y ?? this.y,
      isBomb: isBomb ?? this.isBomb,
      type: type ?? this.type,
      closeCells: closeCells ?? this.closeCells,
    );
  }
}

class CloseCells {
  // TODO put this in the controller
  CloseCells({
    this.top,
    this.topRight,
    this.right,
    this.bottomRight,
    this.bottom,
    this.bottomLeft,
    this.left,
    this.topLeft,
  });

  CellState? top;
  CellState? topRight;
  CellState? right;
  CellState? bottomRight;
  CellState? bottom;
  CellState? bottomLeft;
  CellState? left;
  CellState? topLeft;

  List<CellState?> get values => [
        top,
        topRight,
        right,
        bottomRight,
        bottom,
        bottomLeft,
        left,
        topLeft,
      ];

  int get bombNumber => values.where((cell) => cell?.isBomb ?? false).length;

  Color? get bombNumberColor {
    switch (bombNumber) {
      case 1:
        return Colors.lightBlue;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      case 4:
        return Colors.blue[900];
      case 5:
        return Colors.red[900];
      case 6:
        return Colors.cyan;
      case 7:
        return Colors.black;
      case 8:
        return Colors.grey;
      default:
        return null;
    }
  }

  CloseCells copyWith({
    CellState? top,
    CellState? topRight,
    CellState? right,
    CellState? bottomRight,
    CellState? bottom,
    CellState? bottomLeft,
    CellState? left,
    CellState? topLeft,
  }) {
    return CloseCells(
      top: top ?? this.top,
      topRight: topRight ?? this.topRight,
      right: right ?? this.right,
      bottomRight: bottomRight ?? this.bottomRight,
      bottom: bottom ?? this.bottom,
      bottomLeft: bottomLeft ?? this.bottomLeft,
      left: left ?? this.left,
      topLeft: topLeft ?? this.topLeft,
    );
  }
}
