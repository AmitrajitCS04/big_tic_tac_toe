import 'dart:math';

import 'TicTacToe4x4.dart';

class MCTSNode {
  MCTSNode? parent;
  TicTacToe4x4 state;
  List<MCTSNode> children = [];
  int visits = 0;
  double wins = 0.0;

  MCTSNode(this.state, [this.parent]);

  bool isFullyExpanded() {
    return children.length == state.getPossibleMoves().length;
  }

  bool isTerminal() {
    return state.isTerminal();
  }

  MCTSNode expand() {
    var untriedMoves = state.getPossibleMoves()
      ..removeWhere((move) => children.any(
          (child) => child.state.board.toString() == move.board.toString()));

    var nextMove = untriedMoves[Random().nextInt(untriedMoves.length)];
    var childNode = MCTSNode(nextMove, this);
    children.add(childNode);
    return childNode;
  }

  MCTSNode bestChild(double explorationParam) {
    return children.reduce((a, b) {
      var uctA = a.uctValue(explorationParam);
      var uctB = b.uctValue(explorationParam);
      return uctA > uctB ? a : b;
    });
  }

  double uctValue(double explorationParam) {
    return wins / (visits + 1) +
        explorationParam * sqrt(log(parent!.visits + 1) / (visits + 1));
  }

  void backpropagate(double result) {
    visits++;
    wins += result;
    parent?.backpropagate(result);
  }
}

MCTSNode mctsSearch(TicTacToe4x4 rootState, int iterations) {
  var root = MCTSNode(rootState);

  for (var i = 0; i < iterations; i++) {
    var node = root;

    // Selection
    while (node.isFullyExpanded() && !node.isTerminal()) {
      node = node.bestChild(1.4);
    }

    // Expansion
    if (!node.isTerminal()) {
      node = node.expand();
    }

    // Simulation
    var currentState = node.state;
    while (!currentState.isTerminal()) {
      currentState = currentState.getPossibleMoves()[
          Random().nextInt(currentState.getPossibleMoves().length)];
    }

    // Backpropagation
    var result = currentState.evaluate();
    node.backpropagate(result);
  }

  return root.bestChild(0);
}

void main() {
  var initialState = TicTacToe4x4();
  var bestMove = mctsSearch(initialState, 1000);
  // bestMove now holds the best move determined by MCTS
  print('Best move found with win rate: ${bestMove.wins / bestMove.visits}');
}
