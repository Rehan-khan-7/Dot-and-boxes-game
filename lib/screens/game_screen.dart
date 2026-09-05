import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScreen extends StatefulWidget {
  final int gridSize;

  const GameScreen({super.key, required this.gridSize});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
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
                      '0',
                      const Color(0xFF55DFFF),
                      true,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _playerCard(
                      'PLAYER 2',
                      '0',
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
              'PLAYER 1\'S TURN',
              style: GoogleFonts.lilitaOne(
                fontSize: 23,
                color: const Color(0xFF55DFFF),
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
        const double dotSize = 14;
        const double lineThickness = 6;

        // Space around the board so edge dots are fully visible
        const double margin = dotSize / 2;

        final double boardSize = constraints.maxWidth - (margin * 2);

        final double spacing = boardSize / (widget.gridSize - 1);

        return Padding(
          padding: const EdgeInsets.all(margin),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // ------------------------------------------------
              // HORIZONTAL LINES
              // ------------------------------------------------
              for (int row = 0; row < widget.gridSize; row++)
                for (int col = 0; col < widget.gridSize - 1; col++)
                  Positioned(
                    left: col * spacing,
                    top: row * spacing - lineThickness / 2,
                    width: spacing,
                    height: lineThickness,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),

              // ------------------------------------------------
              // VERTICAL LINES
              // ------------------------------------------------
              for (int row = 0; row < widget.gridSize - 1; row++)
                for (int col = 0; col < widget.gridSize; col++)
                  Positioned(
                    left: col * spacing - lineThickness / 2,
                    top: row * spacing,
                    width: lineThickness,
                    height: spacing,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),

              // ------------------------------------------------
              // DOTS
              // ------------------------------------------------
              for (int row = 0; row < widget.gridSize; row++)
                for (int col = 0; col < widget.gridSize; col++)
                  Positioned(
                    left: col * spacing - dotSize / 2,
                    top: row * spacing - dotSize / 2,
                    child: Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }

  // ----------------------------------------------------------
  // PLAYER CARD
  // ----------------------------------------------------------

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

  // ----------------------------------------------------------
  // TOP BUTTON
  // ----------------------------------------------------------

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
}
