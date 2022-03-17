import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/board/board.dart';
import 'package:tic_tac_toe_app/presenter/game_presenter.dart';
import 'package:tic_tac_toe_app/presenter/game_view_model.dart';
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
  GameViewModel get viewModel => GamePresenter.map(game);

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
              viewModel.currentTurnStatus,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: viewModel.currentTurnColor),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: boardWidth,
              height: boardWidth,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: viewModel.crossAxisCount,
                padding: const EdgeInsets.all(16.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: viewModel.cells.asMap().entries.map((entry) {
                  return CellBox(
                    text: entry.value.text,
                    color: entry.value.color,
                    onTap: () {
                      int row = entry.key ~/ 3;
                      int col = entry.key % 3;
                      setState(() {
                        game.mark(BoardIndex(row: row, collumn: col));
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              viewModel.gameStatus,
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
}

class CellBox extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback? onTap;

  const CellBox({
    Key? key,
    required this.text,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 64.0,
            ),
          ),
        ),
      ),
    );
  }
}
