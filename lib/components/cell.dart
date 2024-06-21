import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum CellState {
  default_,
  empty,
  flag,
  question,
  exploded;
}

class Cell extends StatelessWidget {
  const Cell({
    required this.isBomb,
    required this.state,
    required this.onChangeState,
    super.key,
  });

  final bool isBomb;
  final CellState state;
  final void Function(CellState) onChangeState;

  bool get canClick => ![CellState.empty, CellState.exploded].contains(state);

  IconData? get iconData {
    switch (state) {
      case CellState.empty:
        return null;
      case CellState.flag:
        return Symbols.flag;
      case CellState.question:
        return Symbols.question_mark;
      case CellState.exploded:
        return Symbols.bomb;
      case CellState.default_:
        return null;
      default:
        return null;
    }
  }

  Color? get color {
    switch (state) {
      case CellState.empty:
        return Colors.grey;
      case CellState.flag:
        return Colors.yellow;
      case CellState.question:
        return Colors.green;
      case CellState.exploded:
        return Colors.red;
      case CellState.default_:
        return Colors.blue;
      default:
        return null;
    }
  }

  void leftClick() {
    switch (state) {
      case CellState.empty:
        break;
      case CellState.flag:
        break;
      case CellState.question:
        break;
      case CellState.exploded:
        break;
      case CellState.default_:
        if (isBomb) {
          onChangeState(CellState.exploded);
        } else {
          onChangeState(CellState.empty);
        }
        break;
      default:
        return;
    }
  }

  void rightClick() {
    switch (state) {
      case CellState.empty:
        break;
      case CellState.flag:
        onChangeState(CellState.question);
        break;
      case CellState.question:
        onChangeState(CellState.default_);
        break;
      case CellState.exploded:
        break;
      case CellState.default_:
        onChangeState(CellState.flag);
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Material(
        child: InkWell(
          onTap: canClick ? leftClick : null,
          onSecondaryTap: canClick ? rightClick : null,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              color: color,
            ),
            width: 100,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  size: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
