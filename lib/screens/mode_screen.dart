import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModeScreen extends StatelessWidget {
  const ModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101A46),
      body: SafeArea(
        child: Stack(
          children: [
            // Background decoration
            Positioned(
              top: -40,
              right: -30,
              child: _circle(
                120,
                const Color(0xFF6536B8).withOpacity(0.35),
              ),
            ),

            Positioned(
              bottom: -50,
              left: -40,
              child: _circle(
                140,
                const Color(0xFF2799F5).withOpacity(0.25),
              ),
            ),

            Positioned(
              bottom: 80,
              right: -30,
              child: _circle(
                90,
                const Color(0xFFFF3E83).withOpacity(0.2),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Back button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // Heading
                  Text(
                    'Choose Game',
                    style: GoogleFonts.baloo2(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 0.95,
                    ),
                  ),

                  Text(
                    'Mode',
                    style: GoogleFonts.baloo2(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF55B9FF),
                      height: 0.95,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    'How do you want to play?',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 45),

                  // PLAY LOCAL
                  _ModeButton(
                    icon: Icons.people_alt_rounded,
                    title: 'Play Local',
                    subtitle: 'Two players on the same device',
                    colors: const [
                      Color(0xFF3478F6),
                      Color(0xFF2460D0),
                    ],
                    iconColor: const Color(0xFF8DD7FF),
                    onTap: () {
                      // Game screen will be connected here.
                    },
                  ),

                  const SizedBox(height: 22),

                  // MULTIPLAYER
                  _ModeButton(
                    icon: Icons.public_rounded,
                    title: 'Multiplayer',
                    subtitle: 'Play online with your friends',
                    colors: const [
                      Color(0xFF7650E8),
                      Color(0xFF5B32C7),
                    ],
                    iconColor: const Color(0xFFBBA7FF),
                    onTap: () {
                      // Multiplayer will be added later.
                    },
                  ),

                  const Spacer(),

                  Text(
                    'Same Game.\nMore Fun!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 30),
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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}


/// Reusable button for the game mode screen.
class _ModeButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> colors;
  final Color iconColor;
  final VoidCallback onTap;

  const _ModeButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.colors,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: colors.first.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  icon,
                  size: 34,
                  color: iconColor,
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
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}