import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_shell/cell_shell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/neighbor_cells/neighbor_cells.dart';

class EmptyCell extends StatelessWidget {
  const EmptyCell({
    required this.state,
    required this.neighborCells,
    required this.onClearSurroundingCells,
    super.key,
  });

  final CellState state;
  final NeighborCells neighborCells;
  final void Function(CellState) onClearSurroundingCells;

  @override
  Widget build(BuildContext context) {
    return CellShell(
      state: state,
      bombNumber: neighborCells.bombNumber,
      bombNumberColor: neighborCells.bombNumberColor,
      onLeftClick: () => onClearSurroundingCells(state),
      color: Colors.grey,
    );
  }
}
