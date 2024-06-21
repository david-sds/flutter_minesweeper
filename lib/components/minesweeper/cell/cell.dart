import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_types/default_cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_types/empty_cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_types/exploded_cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_types/flagged_cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_types/question_cell.dart';

enum CellStateTypes {
  default_,
  empty,
  flag,
  question,
  exploded;
}

class Cell extends StatelessWidget {
  const Cell({
    required this.state,
    required this.onChangeState,
    this.cellSize = 60,
    super.key,
  });

  final CellState state;
  final void Function(CellState) onChangeState;
  final double cellSize;

  @override
  Widget build(BuildContext context) {
    switch (state.type) {
      case CellStateTypes.default_:
        return DefaultCell(
          state: state,
          onChangeState: onChangeState,
        );
      case CellStateTypes.empty:
        return EmptyCell(
          state: state,
          onChangeState: onChangeState,
        );
      case CellStateTypes.exploded:
        return ExplodedCell(
          state: state,
          onChangeState: onChangeState,
        );
      case CellStateTypes.flag:
        return FlaggedCell(
          state: state,
          onChangeState: onChangeState,
        );
      case CellStateTypes.question:
        return QuestionCell(
          state: state,
          onChangeState: onChangeState,
        );
      default:
        return const SizedBox();
    }
  }
}
