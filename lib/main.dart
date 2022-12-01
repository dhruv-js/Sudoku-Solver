import 'package:flutter/material.dart';
import 'package:sudoku_solver/cell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sudoku Solver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Soduko Solver',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<int>> grid = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
  ];

  late bool solvable;

  late List<List<TextEditingController>> controllers = [
    for (int i = 0; i < 9; i++)
      [for (int j = 0; j < 9; j++) TextEditingController()],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: GridView.count(
                crossAxisCount: 9,
                children: [
                  for (int i = 0; i < 9; i++)
                    for (int j = 0; j < 9; j++)
                      Cell(
                        controller: controllers[i][j],
                      ),
                ],
              ),
            ),
            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'SOLVE',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              onPressed: () async {
                for (int i = 0; i < 9; i++) {
                  for (int j = 0; j < 9; j++) {
                    grid[i][j] = int.parse(controllers[i][j].text.isEmpty
                        ? '0'
                        : controllers[i][j].text);
                  }
                }
                for (int i = 0; i < 9; i++) {
                  for (int j = 0; j < 9; j++) {
                    print(grid[i][j]);
                  }
                }
                solvable = solveSudoku(grid, 0, 0);
                if (!solvable) {
                  print('not solvable');
                } else {
                  print(grid);
                  print('solved');
                }
              },
            )
          ],
        ),
      ),
    );
  }

  static int N = 9;
  bool solveSudoku(List<List<int>> grid, int row, int col) {
    if (row == N - 1 && col == N) {
      return true;
    }

    if (col == N) {
      row++;
      col = 0;
    }
    if (grid[row][col] != 0) {
      return solveSudoku(grid, row, col + 1);
    }

    for (int num = 1; num < 10; num++) {
      if (isSafe(grid, row, col, num)) {
        controllers[row][col].text = num.toString();

        if (solveSudoku(grid, row, col + 1)) {
          return true;
        }
      }
      grid[row][col] = 0;

      controllers[row][col].text = '0';
    }
    return false;
  }

  static bool isSafe(List<List<int>> grid, int row, int col, int num) {
    for (int x = 0; x <= 8; x++) {
      if (grid[row][x] == num) {
        return false;
      }
    }
    for (int x = 0; x <= 8; x++) {
      if (grid[x][col] == num) {
        return false;
      }
    }
    int startRow = row - row % 3, startCol = col - col % 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (grid[i + startRow][j + startCol] == num) {
          return false;
        }
      }
    }
    return true;
  }
}
