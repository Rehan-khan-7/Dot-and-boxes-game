import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScreen extends StatefulWidget {
  final int gridSize;

  const GameScreen({super.key, required this.gridSize});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Map<String, int> _selectedLines = {};
  final Map<String, int> _claimedBoxes = {};

  int _currentPlayer = 1;
  int _player1Score = 0;
  int _player2Score = 0;

  Widget _playerCard(String name, String score, Color color, bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: active
            ? color.withOpacity(0.15)
            : Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: active ? color : Colors.white12,
          width: active ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              name,
              style: GoogleFonts.nunito(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: color,
                letterSpacing: 1,
              ),
            ),
          ),

          Text(
            score,
            style: GoogleFonts.lilitaOne(fontSize: 27, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _topButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white12),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101A46),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),

            // TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _topButton(Icons.arrow_back_rounded, () {
                    Navigator.pop(context);
                  }),

                  const Spacer(),

                  Text(
                    'DOTS & BOXES',
                    style: GoogleFonts.lilitaOne(
                      fontSize: 25,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),

                  const Spacer(),

                  _topButton(Icons.refresh_rounded, () {}),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // PLAYER SCORES
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _playerCard(
                      'PLAYER 1',
                      '$_player1Score',
                      const Color(0xFF55DFFF),
                      true,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _playerCard(
                      'PLAYER 2',
                      '$_player2Score',
                      const Color(0xFFFF5A9D),
                      false,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // TURN
            Text(
              'PLAYER $_currentPlayer\'S TURN',
              style: GoogleFonts.lilitaOne(
                fontSize: 23,
                color: _currentPlayer == 1
                    ? const Color(0xFF55DFFF)
                    : const Color(0xFFFF5A9D),
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 25),

            // BOARD
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: AspectRatio(aspectRatio: 1, child: _buildBoard()),
                ),
              ),
            ),

            Text(
              'CONNECT THE DOTS • CLAIM THE BOXES',
              style: GoogleFonts.nunito(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: Colors.white54,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // BOARD
  // ----------------------------------------------------------

  Widget _buildBoard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double spacing = constraints.maxWidth / (widget.gridSize - 1);

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // =========================
            // CLAIMED BOXES
            // =========================
            for (int row = 0; row < widget.gridSize - 1; row++)
              for (int col = 0; col < widget.gridSize - 1; col++)
                if (_claimedBoxes.containsKey('$row-$col'))
                  Positioned(
                    left: col * spacing + 4,
                    top: row * spacing + 4,
                    width: spacing - 8,
                    height: spacing - 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _claimedBoxes['$row-$col'] == 1
                            ? const Color(0xFF55DFFF).withOpacity(0.22)
                            : const Color(0xFFFF5A9D).withOpacity(0.22),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '♛',
                          style: TextStyle(
                            fontSize: spacing * 0.25,
                            color: _claimedBoxes['$row-$col'] == 1
                                ? const Color(0xFF55DFFF)
                                : const Color(0xFFFF5A9D),
                          ),
                        ),
                      ),
                    ),
                  ),

            // =========================
            // HORIZONTAL LINES
            // =========================
            for (int row = 0; row < widget.gridSize; row++)
              for (int col = 0; col < widget.gridSize - 1; col++)
                Positioned(
                  left: col * spacing,
                  top: row * spacing - 10,
                  width: spacing,
                  height: 20,
                  child: GestureDetector(
                    onTap: () {
                      _playLine('H-$row-$col');
                    },
                    child: Center(
                      child: Container(
                        height: 6,
                        width: spacing - 12,
                        decoration: BoxDecoration(
                          color: _lineColor('H-$row-$col'),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),

            // =========================
            // VERTICAL LINES
            // =========================
            for (int row = 0; row < widget.gridSize - 1; row++)
              for (int col = 0; col < widget.gridSize; col++)
                Positioned(
                  left: col * spacing - 10,
                  top: row * spacing,
                  width: 20,
                  height: spacing,
                  child: GestureDetector(
                    onTap: () {
                      _playLine('V-$row-$col');
                    },
                    child: Center(
                      child: Container(
                        width: 6,
                        height: spacing - 12,
                        decoration: BoxDecoration(
                          color: _lineColor('V-$row-$col'),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),

            // =========================
            // DOTS
            // =========================
            for (int row = 0; row < widget.gridSize; row++)
              for (int col = 0; col < widget.gridSize; col++)
                Positioned(
                  left: col * spacing - 7,
                  top: row * spacing - 7,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
          ],
        );
      },
    );
  }

  Color _lineColor(String line) {
    if (!_selectedLines.containsKey(line)) {
      return Colors.white24;
    }

    return _selectedLines[line] == 1
        ? const Color(0xFF55DFFF)
        : const Color(0xFFFF5A9D);
  }

  void _playLine(String line) {
    if (_selectedLines.containsKey(line)) {
      return;
    }

    setState(() {
      _selectedLines[line] = _currentPlayer;

      final completedBoxes = _checkCompletedBoxes(line);

      if (completedBoxes.isNotEmpty) {
        for (final box in completedBoxes) {
          _claimedBoxes[box] = _currentPlayer;

          if (_currentPlayer == 1) {
            _player1Score++;
          } else {
            _player2Score++;
          }
        }

        // Player gets another turn.
      } else {
        _currentPlayer = _currentPlayer == 1 ? 2 : 1;
      }
    });
  }

  List<String> _checkCompletedBoxes(String line) {
    final parts = line.split('-');

    final type = parts[0];
    final row = int.parse(parts[1]);
    final col = int.parse(parts[2]);

    final List<String> completed = [];

    if (type == 'H') {
      // Box below the horizontal line
      if (row < widget.gridSize - 1) {
        final key = '$row-$col';

        if (!_claimedBoxes.containsKey(key) && _hasBox(row, col)) {
          completed.add(key);
        }
      }

      // Box above the horizontal line
      if (row > 0) {
        final boxRow = row - 1;
        final key = '$boxRow-$col';

        if (!_claimedBoxes.containsKey(key) && _hasBox(boxRow, col)) {
          completed.add(key);
        }
      }
    }

    if (type == 'V') {
      // Box to the right
      if (col < widget.gridSize - 1) {
        final key = '$row-$col';

        if (!_claimedBoxes.containsKey(key) && _hasBox(row, col)) {
          completed.add(key);
        }
      }

      // Box to the left
      if (col > 0) {
        final boxCol = col - 1;
        final key = '$row-$boxCol';

        if (!_claimedBoxes.containsKey(key) && _hasBox(row, boxCol)) {
          completed.add(key);
        }
      }
    }

    return completed;
  }

  bool _hasBox(int row, int col) {
    final top = 'H-$row-$col';
    final bottom = 'H-${row + 1}-$col';
    final left = 'V-$row-$col';
    final right = 'V-$row-${col + 1}';

    return _selectedLines.containsKey(top) &&
        _selectedLines.containsKey(bottom) &&
        _selectedLines.containsKey(left) &&
        _selectedLines.containsKey(right);
  }
}
