import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/board/board.dart';
import 'package:flutter_minesweeper/components/minesweeper/cronometer/cronometer.dart';
import 'package:flutter_minesweeper/components/minesweeper/cronometer/cronometer_controller.dart';
import 'package:flutter_minesweeper/components/minesweeper/face/face.dart';
import 'package:flutter_minesweeper/components/minesweeper/minesweeper_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

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
    required this.initialDifficulty,
    super.key,
  });

  final Difficulty initialDifficulty;

  @override
  State<Minesweeper> createState() => _MinesweeperState();
}

class _MinesweeperState extends State<Minesweeper> {
  late ReactionDisposer reactionDisposer;
  Stopwatch stopwatch = Stopwatch();
  Timer timer = Timer(Duration.zero, () {});
  final _scrollController = ScrollController();
  final _cronometerController = CronometerController();
  final ctrl = MinesweeperController();
  final contentPadding = 8.0;
  final defaultCellSizeWidth = 45.0;

  @override
  initState() {
    reactionDisposer = reaction(
      (_) => ctrl.gameState,
      (value) {
        switch (value) {
          case GameState.ready:
            _cronometerController.reset();
            break;
          case GameState.playing:
            _cronometerController.start();
            break;
          case GameState.victory:
            _cronometerController.stop();
            break;
          case GameState.gameOver:
            _cronometerController.stop();
            break;
          default:
            break;
        }
      },
    );
    ctrl.initBoard(widget.initialDifficulty);
    super.initState();
  }

  @override
  void dispose() {
    reactionDisposer.reaction.dispose();
    super.dispose();
  }

  double getCellSize(BoxConstraints constraints, isHorizontalView) {
    final padding = contentPadding * 2;
    final horizontalCellsNumber =
        isHorizontalView ? ctrl.difficulty.x : ctrl.difficulty.y;
    var cellSize = defaultCellSizeWidth;

    if ((horizontalCellsNumber * cellSize) + padding > constraints.maxWidth) {
      cellSize = (constraints.maxWidth - padding) / horizontalCellsNumber;
    }

    return cellSize;
  }

  @override
  Widget build(BuildContext context) {
    final isHorizontalView =
        MediaQuery.sizeOf(context).width > MediaQuery.sizeOf(context).height;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Observer(builder: (context) {
          return Stack(
            children: [
              Center(
                child: Face(
                  state: ctrl.gameState,
                  onTap: () {
                    _cronometerController.reset();
                    ctrl.initBoard(ctrl.difficulty);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Cronometer(
                      controller: _cronometerController,
                    ),
                    DropdownButton<Difficulty>(
                      value: ctrl.difficulty,
                      items: Difficulty.values
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value.name,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) ctrl.initBoard(value);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              width: double.infinity,
              color: Colors.grey[600],
              child: Center(
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Observer(builder: (context) {
                          return Padding(
                            padding: EdgeInsets.all(contentPadding),
                            child: Board(
                              boardState: ctrl.boardState,
                              gameState: ctrl.gameState,
                              isHorizontalView: isHorizontalView,
                              onGetNeighborCells: ctrl.getNeighborCells,
                              onClearSurroundingCells:
                                  ctrl.clearSurroundingCells,
                              onUpdateCellState: ctrl.updateCellState,
                              cellSize: getCellSize(
                                constraints,
                                isHorizontalView,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
