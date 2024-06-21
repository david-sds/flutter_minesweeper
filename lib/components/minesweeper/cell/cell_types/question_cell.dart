import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_shell/cell_shell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class QuestionCell extends StatelessWidget {
  const QuestionCell({
    required this.state,
    required this.onChangeState,
    super.key,
  });

  final CellState state;
  final void Function(CellState) onChangeState;

  @override
  Widget build(BuildContext context) {
    return CellShell(
      iconData: Symbols.question_mark,
      color: Colors.green,
      onRightClick: () => onChangeState(
        state.copyWith(
          type: CellStateTypes.default_,
        ),
      ),
    );
  }
}
