class TicTacToe4x4 {
  List<String> board;
  String currentPlayer;

  TicTacToe4x4()
      : board = List.filled(16, ''),
        currentPlayer = 'X';

  TicTacToe4x4.fromBoard(this.board, this.currentPlayer);

  bool isTerminal() {
    return checkWin() || board.every((cell) => cell != '');
  }

  bool checkWin() {
    for (int i = 0; i < 4; i++) {
      if (board[i] != '') {
        if (board[i + 4] == board[i] &&
            board[i + 8] == board[i] &&
            board[i + 12] == board[i]) {
          return true;
        }
      }
    }

    if (board[0] == '' &&
        board[0] == board[5] &&
        board[5] == board[10] &&
        board[10] == board[15]) {
      return true;
    }

    if (board[3] == '' &&
        board[3] == board[6] &&
        board[6] == board[9] &&
        board[9] == board[12]) {
      return true;
    }

    if (board[1] == '' &&
        board[1] == board[4] &&
        board[4] == board[9] &&
        board[9] == board[14]) {
      return true;
    }

    if (board[1] == '' &&
        board[1] == board[6] &&
        board[6] == board[11] &&
        board[11] == board[14]) {
      return true;
    }

    if (board[2] == '' &&
        board[2] == board[5] &&
        board[5] == board[8] &&
        board[8] == board[13]) {
      return true;
    }

    if (board[2] == '' &&
        board[2] == board[7] &&
        board[7] == board[10] &&
        board[10] == board[13]) {
      return true;
    }

    return false;
  }

  List<TicTacToe4x4> getPossibleMoves() {
    List<TicTacToe4x4> moves = [];
    for (int i = 0; i < 16; i++) {
      if (board[i] == '') {
        var newState = TicTacToe4x4.fromBoard(List.from(board), currentPlayer);
        newState.board[i] = currentPlayer;
        newState.currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        moves.add(newState);
      }
    }
    return moves;
  }

  double evaluate() {
    if (checkWin()) {
      return currentPlayer == 'X' ? 0.0 : 1.0;
    } else {
      return 0.5;
    }
  }
}
