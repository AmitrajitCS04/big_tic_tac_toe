import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const TicTacToeApp());
  });
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4x4 Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TicTacToeHomePage(),
    );
  }
}

class TicTacToeHomePage extends StatefulWidget {
  const TicTacToeHomePage({super.key});

  @override
  _TicTacToeHomePageState createState() => _TicTacToeHomePageState();
}

class _TicTacToeHomePageState extends State<TicTacToeHomePage> {
  List<String> board = List.filled(16, '');
  int turn = 0;
  String playerChoice = '';

  void restart() {
    board = List.filled(16, '');
    turn = 0;
    playerChoice = '';
  }

  void _handleTap(int index) {
    setState(() {
      if (board[index] == '') {
        board[index] = turn == 0 ? 'X' : 'O';
        turn = 1 - turn;
      }
    });
  }

  Widget _buildCell(int index) {
    return GestureDetector(
      onTap: () => _handleTap(index),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            board[index],
            style: const TextStyle(fontSize: 40, color: Colors.black),
          ),
        ),
      ),
    );
  }

  void _userSelectionX() {
    setState(() {
      playerChoice = 'X';
    });
    print("User selected " + playerChoice);
  }

  void _userSelectionO() {
    setState(() {
      playerChoice = 'O';
    });
    print("User selected " + playerChoice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff283593),
        title: const Text(
          '4x4 Tic Tac Toe',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                if (playerChoice == '')
                  const Text(
                    "Select X or O. X goes first",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (playerChoice == '')
                      ElevatedButton(
                        onPressed: const ListEquality()
                                .equals(board, List.filled(16, ''))
                            ? _userSelectionX
                            : null,
                        child: const Text(
                          "X",
                          style: TextStyle(
                              color: Color(0xff37474f),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    if (playerChoice == '')
                      ElevatedButton(
                        onPressed: const ListEquality()
                                .equals(board, List.filled(16, ''))
                            ? _userSelectionO
                            : null,
                        child: const Text(
                          "O",
                          style: TextStyle(
                              color: Color(0xff37474f),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (playerChoice != '')
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 40, 6, 8),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: 16,
                  itemBuilder: (context, index) {
                    return _buildCell(index);
                  },
                ),
              ),
            ),
        ],
      ),
      backgroundColor: const Color(0xff37474f),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            restart();
          });
        },
        child: const Icon(Icons.restart_alt_outlined),
      ),
    );
  }
}
