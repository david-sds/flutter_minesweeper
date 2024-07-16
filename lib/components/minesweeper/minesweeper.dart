import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/face/face.dart';
import 'package:flutter_minesweeper/components/minesweeper/minesweeper_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

enum Difficulty {
  classic(
    x: 8,
    y: 8,
    bombNumber: 9,
  ),
  easy(
    x: 9,
    y: 9,
    bombNumber: 10,
  ),
  medium(
    x: 16,
    y: 16,
    bombNumber: 40,
  ),
  expert(
    x: 30,
    y: 16,
    bombNumber: 99,
  );

  const Difficulty({
    required this.x,
    required this.y,
    required this.bombNumber,
  });

  final int x;
  final int y;
  final int bombNumber;
}

class Minesweeper extends StatefulWidget {
  const Minesweeper({
    required this.difficulty,
    super.key,
  });

  final Difficulty difficulty;

  @override
  State<Minesweeper> createState() => _MinesweeperState();
}

class _MinesweeperState extends State<Minesweeper> {
  final ctrl = MinesweeperController();

  @override
  initState() {
    ctrl.setDifficulty(widget.difficulty);
    ctrl.initBoard();
    super.initState();
  }

  double getCellSize(BoxConstraints constraints) {
    var maxCellSizeWidth = 30.0;
    var maxCellSizeHeight = 30.0;

    if (widget.difficulty.x * maxCellSizeWidth > constraints.maxWidth) {
      maxCellSizeWidth = constraints.maxWidth / widget.difficulty.x;
    }

    if (widget.difficulty.y * maxCellSizeHeight > constraints.maxHeight) {
      maxCellSizeHeight = constraints.maxHeight / widget.difficulty.y;
    }

    return maxCellSizeWidth < maxCellSizeHeight
        ? maxCellSizeWidth
        : maxCellSizeHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Observer(builder: (context) {
          return Face(
            state: ctrl.gameState,
            onTap: () {
              ctrl.initBoard();
            },
          );
        }),
        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              color: Colors.grey[600],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  ctrl.boardState.length,
                  (y) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        ctrl.boardState[y].length,
                        (x) {
                          return Observer(builder: (context) {
                            return Cell(
                              cellSize: getCellSize(constraints),
                              state: ctrl.boardState[x][y],
                              gameState: ctrl.gameState,
                              neighborCells: ctrl.getNeighborCells(
                                ctrl.boardState[x][y],
                              ),
                              onChangeState: (state) {
                                ctrl.updateCellState(state);
                              },
                              onClearSurroundingCells: (state) {
                                ctrl.clearSurroundingCells(state);
                              },
                            );
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
