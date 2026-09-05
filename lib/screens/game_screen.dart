import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'player_names_screen.dart';

class GameScreen extends StatefulWidget {
  final int gridSize;
  final String player1;
  final String player2;

  const GameScreen({
    super.key,
    required this.gridSize,
    required this.player1,
    required this.player2,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Map<String, int> _selectedLines = {};
  final Map<String, int> _claimedBoxes = {};

  int _currentPlayer = 1;
  int _player1Score = 0;
  int _player2Score = 0;

  bool _isGameOver() {
    final totalBoxes = (widget.gridSize - 1) * (widget.gridSize - 1);

    return _claimedBoxes.length == totalBoxes;
  }

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

  void _showGameOver() {
    String winner;
    bool isDraw = false;

    if (_player1Score > _player2Score) {
      winner = '${widget.player1.toUpperCase()} WINS!';
    } else if (_player2Score > _player1Score) {
      winner = '${widget.player2.toUpperCase()} WINS!';
    } else {
      winner = "IT'S A DRAW!";
      isDraw = true;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.75),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 28),
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF17245A), Color(0xFF0B1235)],
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDraw
                      ? Colors.white.withOpacity(0.15)
                      : const Color(0xFF55DFFF).withOpacity(0.25),
                  blurRadius: 35,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Trophy
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF55DFFF), Color(0xFF4776FF)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF55DFFF).withOpacity(0.4),
                        blurRadius: 25,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.emoji_events_rounded,
                    size: 42,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 18),

                // GAME OVER
                Text(
                  'GAME OVER',
                  style: GoogleFonts.lilitaOne(
                    fontSize: 18,
                    letterSpacing: 2,
                    color: Colors.white54,
                  ),
                ),

                const SizedBox(height: 4),

                // Winner
                Text(
                  winner,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lilitaOne(
                    fontSize: 30,
                    letterSpacing: 1,
                    color: isDraw ? Colors.white : const Color(0xFF55DFFF),
                    shadows: [
                      Shadow(
                        color: const Color(0xFF55DFFF).withOpacity(0.5),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // Score title
                Text(
                  'FINAL SCORE',
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                    color: Colors.white54,
                  ),
                ),

                const SizedBox(height: 12),

                // Score cards
                Row(
                  children: [
                    Expanded(
                      child: _resultScoreCard(
                        widget.player1.toUpperCase(),
                        _player1Score,
                        const Color(0xFF55DFFF),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _resultScoreCard(
                        widget.player2.toUpperCase(),
                        _player2Score,
                        const Color(0xFFFF5A9D),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Play again
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _resetGame();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF55DFFF),
                      foregroundColor: const Color(0xFF07102F),
                      elevation: 10,
                      shadowColor: const Color(0xFF55DFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      'PLAY AGAIN',
                      style: GoogleFonts.lilitaOne(
                        fontSize: 19,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Close
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'BACK TO GAME',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _resultScoreCard(String player, int score, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.45), width: 1.2),
        boxShadow: [BoxShadow(color: color.withOpacity(0.12), blurRadius: 15)],
      ),
      child: Column(
        children: [
          Text(
            player,
            style: GoogleFonts.nunito(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            '$score',
            style: GoogleFonts.lilitaOne(fontSize: 34, color: Colors.white),
          ),

          Text(
            score == 1 ? 'BOX' : 'BOXES',
            style: GoogleFonts.nunito(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white38,
            ),
          ),
        ],
      ),
    );
  }

  void _resetGame() {
    setState(() {
      _selectedLines.clear();
      _player1Score = 0;
      _player2Score = 0;
      _currentPlayer = 1;
      _claimedBoxes.clear();
    });
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

                  _topButton(Icons.refresh_rounded, () {
                    _resetGame();
                  }),
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
                      widget.player1.toUpperCase(),
                      '$_player1Score',
                      const Color(0xFF55DFFF),
                      true,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _playerCard(
                      widget.player2.toUpperCase(),
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
              _currentPlayer == 1
                  ? "${widget.player1.toUpperCase()}'S TURN"
                  : "${widget.player2.toUpperCase()}'S TURN",
              style: GoogleFonts.lilitaOne(
                fontSize: 24,
                color: _currentPlayer == 1
                    ? const Color(0xFF55DFFF)
                    : const Color(0xFFFF5A9D),
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

        // Check whether the final box was completed.
        if (_isGameOver()) {
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              _showGameOver();
            }
          });
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
