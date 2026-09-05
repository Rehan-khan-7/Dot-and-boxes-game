import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mode_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background decorations
            Positioned(
              top: -40,
              left: -50,
              child: _circle(140, const Color(0xFF263B9B)),
            ),

            Positioned(
              top: 100,
              right: -35,
              child: _circle(90, const Color(0xFF6536B8)),
            ),

            Positioned(
              bottom: -60,
              left: -40,
              child: _circle(150, const Color(0xFF2799F5)),
            ),

            Positioned(
              bottom: -60,
              right: -40,
              child: _circle(150, const Color(0xFFFF3E83)),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  // LOGO
                  Text(
                    'DOTS',
                    style: GoogleFonts.baloo2(
                      fontSize: 64,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF55B9FF),
                      height: 0.9,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '&',
                        style: GoogleFonts.baloo2(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFFFC83D),
                        ),
                      ),

                      const SizedBox(width: 6),

                      Text(
                        'BOXES',
                        style: GoogleFonts.baloo2(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFFF4F8B),
                          height: 0.9,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Connect Dots  •  Claim Boxes',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),

                  Text(
                    'Outsmart Your Opponent',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // GAME PREVIEW
                  const Expanded(child: Center(child: GamePreview())),

                  // PLAY BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ModeScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC83D),
                        foregroundColor: const Color(0xFF3A2800),
                        elevation: 8,
                        shadowColor: Colors.black45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.play_arrow_rounded, size: 32),

                          const SizedBox(width: 8),

                          Text(
                            'PLAY',
                            style: GoogleFonts.poppins(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Small Moves.\nBig Wins!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class GamePreview extends StatelessWidget {
  const GamePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: CustomPaint(painter: GamePreviewPainter()),
      ),
    );
  }
}

class GamePreviewPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double spacing = size.width / 3;

    final paintLine = Paint()
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    final paintDot = Paint()..color = Colors.white;

    final paintBlue = Paint()..color = const Color(0xFF42B5FF);

    final paintPink = Paint()..color = const Color(0xFFFF4F91);

    // Coordinates
    final points = <Offset>[
      Offset(spacing * 0.5, spacing * 0.5),
      Offset(spacing * 1.5, spacing * 0.5),
      Offset(spacing * 2.5, spacing * 0.5),

      Offset(spacing * 0.5, spacing * 1.5),
      Offset(spacing * 1.5, spacing * 1.5),
      Offset(spacing * 2.5, spacing * 1.5),

      Offset(spacing * 0.5, spacing * 2.5),
      Offset(spacing * 1.5, spacing * 2.5),
      Offset(spacing * 2.5, spacing * 2.5),
    ];

    // Draw completed box backgrounds
    final boxPaintBlue = Paint()
      ..color = const Color(0xFF1976D2).withOpacity(0.35);

    final boxPaintPink = Paint()
      ..color = const Color(0xFFE91E63).withOpacity(0.35);

    canvas.drawRect(Rect.fromPoints(points[0], points[4]), boxPaintBlue);

    canvas.drawRect(Rect.fromPoints(points[4], points[8]), boxPaintPink);

    // Blue lines
    paintLine.color = paintBlue.color;

    canvas.drawLine(points[0], points[1], paintLine);
    canvas.drawLine(points[0], points[3], paintLine);
    canvas.drawLine(points[3], points[4], paintLine);
    canvas.drawLine(points[1], points[4], paintLine);

    // Pink lines
    paintLine.color = paintPink.color;

    canvas.drawLine(points[1], points[2], paintLine);
    canvas.drawLine(points[2], points[5], paintLine);
    canvas.drawLine(points[4], points[5], paintLine);
    canvas.drawLine(points[4], points[7], paintLine);
    canvas.drawLine(points[7], points[8], paintLine);
    canvas.drawLine(points[5], points[8], paintLine);

    // Dashed/open lines
    final dashedPaint = Paint()
      ..color = Colors.white38
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    _dashedLine(canvas, points[3], points[6], dashedPaint);
    _dashedLine(canvas, points[6], points[7], dashedPaint);
    _dashedLine(canvas, points[5], points[8], dashedPaint);

    // Dots
    for (final point in points) {
      canvas.drawCircle(point, 9, paintDot);
    }

    // Crown in first box
    _drawCrown(
      canvas,
      Offset(
        (points[0].dx + points[4].dx) / 2,
        (points[0].dy + points[4].dy) / 2,
      ),
      const Color(0xFF9CDCFF),
    );

    // Crown in second box
    _drawCrown(
      canvas,
      Offset(
        (points[4].dx + points[8].dx) / 2,
        (points[4].dy + points[8].dy) / 2,
      ),
      const Color(0xFFFFB6D2),
    );
  }

  void _dashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashLength = 10.0;
    const gapLength = 8.0;

    final distance = (end - start).distance;
    final direction = (end - start) / distance;

    double current = 0;

    while (current < distance) {
      final dashStart = start + direction * current;

      final double dashEndDistance = (current + dashLength).clamp(0, distance);

      final dashEnd = start + direction * dashEndDistance;

      canvas.drawLine(dashStart, dashEnd, paint);

      current += dashLength + gapLength;
    }
  }

  void _drawCrown(Canvas canvas, Offset center, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(center.dx - 18, center.dy - 8);
    path.lineTo(center.dx - 10, center.dy + 8);
    path.lineTo(center.dx + 10, center.dy + 8);
    path.lineTo(center.dx + 18, center.dy - 8);
    path.lineTo(center.dx + 11, center.dy - 1);
    path.lineTo(center.dx + 5, center.dy - 12);
    path.lineTo(center.dx, center.dy - 1);
    path.lineTo(center.dx - 5, center.dy - 12);
    path.lineTo(center.dx - 11, center.dy - 1);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
