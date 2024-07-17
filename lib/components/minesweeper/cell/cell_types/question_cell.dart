import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_shell/cell_shell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';

class QuestionCell extends StatelessWidget {
  const QuestionCell({
    required this.state,
    required this.onChangeState,
    required this.cellSize,
    super.key,
  });

  final double cellSize;
  final CellState state;
  final void Function(CellState) onChangeState;

  @override
  Widget build(BuildContext context) {
    return CellShell(
      state: state,
      size: cellSize,
      image: Image.asset('assets/images/question_mark.png'),
      color: Colors.green,
      onRightClick: () => onChangeState(
        state.copyWith(
          type: CellStateTypes.default_,
        ),
      ),
    );
  }
}
