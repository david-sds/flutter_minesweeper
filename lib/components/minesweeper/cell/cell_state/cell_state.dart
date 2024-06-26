import 'package:flutter_minesweeper/components/minesweeper/cell/cell.dart';

class CellState {
  CellState({
    required this.x,
    required this.y,
    required this.isBomb,
    required this.type,
  });

  int x;
  int y;
  bool isBomb;
  CellStateTypes type;

  CellState copyWith({
    int? x,
    int? y,
    bool? isBomb,
    CellStateTypes? type,
  }) {
    return CellState(
      x: x ?? this.x,
      y: y ?? this.y,
      isBomb: isBomb ?? this.isBomb,
      type: type ?? this.type,
    );
  }

  @override
  String toString() {
    return '\n($x, '
        '$y, '
        'isBomb: $isBomb, '
        'type: ${type.toString()}.)';
  }
}
