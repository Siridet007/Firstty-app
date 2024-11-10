import 'package:flutter/material.dart';

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key});

  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  List<List<String>> board = [];
  String currentPrayer = '';

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    board = List.generate(3, (index) => List.filled(3, ''));
    currentPrayer = 'X';
  }

  void onCallTapped(int row, int col) {
    if (board[row][col].isEmpty) {
      setState(() {
        board[row][col] = currentPrayer;
        currentPrayer = (currentPrayer == 'X') ? 'O' : 'X';
      });
      String winner = checkForWinner();
      if (winner.isNotEmpty) {
        showWinnerDialog(winner);
      }
    }
  }

  String checkForWinner() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] &&
          board[i][1] == board[i][2] &&
          board[i][0].isNotEmpty) {
        return board[i][0];
      }
      if (board[0][i] == board[1][i] &&
          board[1][i] == board[2][i] &&
          board[0][i].isNotEmpty) {
        return board[0][i];
      }
    }
    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[0][0].isNotEmpty) {
      return board[0][0];
    }
    if (board[0][2] == board[1][1] &&
        board[1][1] == board[2][0] &&
        board[0][2].isNotEmpty) {
      return board[0][2];
    }
    bool isDraw = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          isDraw = false;
          break;
        }
      }
    }
    if (isDraw) {
      return 'Draw';
    }
    return '';
  }

  void showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: Text(
          winner == 'Draw' ? 'It\'s a draw!' : 'Player $winner wins!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.of(context).pop();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      initializeGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic-Tac-Toe'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Text(
              'Current Player:$currentPrayer',
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                final row = index ~/ 3;
                final col = index % 3;
                return GestureDetector(
                  onTap: () => onCallTapped(row, col),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Center(
                      child: Text(
                        board[row][col],
                        style: const TextStyle(
                          fontSize: 48,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ElevatedButton(
              onPressed: resetGame,
              child: const Text('Reset Game'),
            ),
          ),
        ],
      ),
    );
  }
}
