import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/board/board.dart';
import 'package:tic_tac_toe_app/tic_tac_toe/tic_tac_toe_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicTacToe',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TicTacToeGame game;

  @override
  void initState() {
    super.initState();
    game = TicTacToeGame.start(player1: "X", player2: "O");
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("TicTacToe"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                game = TicTacToeGame.start(player1: "X", player2: "O");
              });
            },
            child: const Text(
              "REFRESH",
              style: TextStyle(color: Colors.amberAccent),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              turnStatus(),
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: turnStatusColor()),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: boardWidth,
              height: boardWidth,
              child: GridView.count(
                crossAxisCount: 9 ~/ 3,
                padding: const EdgeInsets.all(16.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(
                  9,
                  (index) {
                    int row = index ~/ 3;
                    int col = index % 3;
                    final cell = game.board.matrix[row][col];

                    return InkWell(
                      onTap: () {
                        setState(() {
                          game.mark(BoardIndex(row: row, collumn: col));
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Center(
                          child: Text(
                            cell.value ?? "",
                            style: TextStyle(
                              color:
                                  cell.value == "X" ? Colors.blue : Colors.pink,
                              fontSize: 64.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              gameStatus(),
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  String turnStatus() {
    return "It's ${game.turn.player.name} turn";
  }

  Color turnStatusColor() {
    return game.turn.player.name == "X" ? Colors.blue : Colors.pink;
  }

  String gameStatus() {
    return game.result.when(
      inProgress: () => "🎮 Game in progres 🎮",
      draw: () => "🤺 It's a draw 🤺",
      over: (winner) => "🏆 Player $winner win🏆 ",
    );
  }
}
