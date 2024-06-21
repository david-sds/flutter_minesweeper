import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_shell/cell_shell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';

class DefaultCell extends StatelessWidget {
  const DefaultCell({
    required this.state,
    required this.onChangeState,
    super.key,
  });

  final CellState state;
  final void Function(CellState) onChangeState;

  @override
  Widget build(BuildContext context) {
    return CellShell(
      color: Colors.blue,
      onLeftClick: () {
        if (state.isBomb) {
          onChangeState(
            state.copyWith(
              type: CellStateTypes.exploded,
            ),
          );
        } else {
          onChangeState(
            state.copyWith(
              type: CellStateTypes.empty,
            ),
          );
        }
      },
      onRightClick: () => onChangeState(
        state.copyWith(
          type: CellStateTypes.flag,
        ),
      ),
    );
  }
}
