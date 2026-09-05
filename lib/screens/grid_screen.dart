import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'game_screen.dart';
import 'player_names_screen.dart';

class GridScreen extends StatefulWidget {
  final String player1;
  final String player2;

  const GridScreen({super.key, required this.player1, required this.player2});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  int selectedSize = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101A46),
      body: SafeArea(
        child: Stack(
          children: [
            // Background decoration
            Positioned(
              top: -50,
              right: -45,
              child: _circle(150, const Color(0xFF2878FF)),
            ),

            Positioned(
              bottom: -50,
              left: -45,
              child: _circle(140, const Color(0xFF18C8E8)),
            ),

            Positioned(
              bottom: -45,
              right: -30,
              child: _circle(120, const Color(0xFFFF5A9D)),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // Back button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.10),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.15),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 38),

                  // Heading
                  Text(
                    'CHOOSE',
                    style: GoogleFonts.lilitaOne(
                      fontSize: 48,
                      color: const Color(0xFF55C7FF),
                      letterSpacing: 2,
                      shadows: const [
                        Shadow(
                          offset: Offset(0, 4),
                          blurRadius: 0,
                          color: Color(0xFF0876C9),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    'GRID SIZE',
                    style: GoogleFonts.lilitaOne(
                      fontSize: 44,
                      color: const Color(0xFFFF5A9D),
                      letterSpacing: 1,
                      shadows: const [
                        Shadow(
                          offset: Offset(0, 4),
                          blurRadius: 0,
                          color: Color(0xFFB51D5B),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'HOW BIG SHOULD THE BOARD BE?',
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.white70,
                      letterSpacing: 1.1,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // Grid options
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _GridOption(
                          size: 3,
                          title: '3 × 3',
                          subtitle: '4 boxes • Quick Game',
                          selected: selectedSize == 3,
                          color: const Color(0xFF55DFFF),
                          onTap: () {
                            setState(() {
                              selectedSize = 3;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        _GridOption(
                          size: 4,
                          title: '4 × 4',
                          subtitle: '9 boxes • Classic',
                          selected: selectedSize == 4,
                          color: const Color(0xFFFFC928),
                          onTap: () {
                            setState(() {
                              selectedSize = 4;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        _GridOption(
                          size: 5,
                          title: '5 × 5',
                          subtitle: '16 boxes • Challenge',
                          selected: selectedSize == 5,
                          color: const Color(0xFFFF5A9D),
                          onTap: () {
                            setState(() {
                              selectedSize = 5;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        _GridOption(
                          size: 6,
                          title: '6 × 6',
                          subtitle: '25 boxes • Expert',
                          selected: selectedSize == 6,
                          color: const Color(0xFF9C7AFF),
                          onTap: () {
                            setState(() {
                              selectedSize = 6;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Continue button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameScreen(
                            gridSize: selectedSize,
                            player1: widget.player1,
                            player2: widget.player2,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFD45A), Color(0xFFFFB83D)],
                        ),
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFC928).withOpacity(0.30),
                            blurRadius: 15,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'START GAME',
                          style: GoogleFonts.lilitaOne(
                            fontSize: 24,
                            color: const Color(0xFF493300),
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.16),
      ),
    );
  }
}

// ------------------------------------------------------------
// GRID OPTION
// ------------------------------------------------------------

class _GridOption extends StatelessWidget {
  final int size;
  final String title;
  final String subtitle;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _GridOption({
    required this.size,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        decoration: BoxDecoration(
          color: selected
              ? color.withOpacity(0.15)
              : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: selected ? color : Colors.white12,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Mini grid preview
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Center(
                child: CustomPaint(
                  size: const Size(42, 42),
                  painter: _MiniGridPainter(size: size, color: color),
                ),
              ),
            ),

            const SizedBox(width: 18),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lilitaOne(
                      fontSize: 25,
                      color: selected ? color : Colors.white,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    subtitle,
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),

            // Selection indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? color : Colors.transparent,
                border: Border.all(
                  color: selected ? color : Colors.white30,
                  width: 2,
                ),
              ),
              child: selected
                  ? const Icon(
                      Icons.check_rounded,
                      color: Color(0xFF101A46),
                      size: 17,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// MINI GRID PREVIEW
// ------------------------------------------------------------

class _MiniGridPainter extends CustomPainter {
  final int size;
  final Color color;

  _MiniGridPainter({required this.size, required this.color});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final double spacing = canvasSize.width / (size - 1);

    for (int row = 0; row < size; row++) {
      for (int col = 0; col < size; col++) {
        final x = col * spacing;
        final y = row * spacing;

        // Horizontal lines
        if (col < size - 1) {
          canvas.drawLine(Offset(x, y), Offset(x + spacing, y), paint);
        }

        // Vertical lines
        if (row < size - 1) {
          canvas.drawLine(Offset(x, y), Offset(x, y + spacing), paint);
        }

        // Dot
        canvas.drawCircle(Offset(x, y), 3, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _MiniGridPainter oldDelegate) {
    return oldDelegate.size != size || oldDelegate.color != color;
  }
}
