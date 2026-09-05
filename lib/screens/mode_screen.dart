import 'package:dotandboxes/screens/player_names_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'grid_screen.dart';

//import 'game_screen.dart';
class ModeScreen extends StatelessWidget {
  const ModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101A46),
      body: SafeArea(
        child: Stack(
          children: [
            // Background circles
            Positioned(
              top: -50,
              left: -50,
              child: _backgroundCircle(150, const Color(0xFF2878FF)),
            ),

            Positioned(
              top: 180,
              right: -55,
              child: _backgroundCircle(130, const Color(0xFF6847E8)),
            ),

            Positioned(
              bottom: -45,
              left: -35,
              child: _backgroundCircle(120, const Color(0xFF18C8E8)),
            ),

            Positioned(
              bottom: -40,
              right: -30,
              child: _backgroundCircle(120, const Color(0xFFFF5A9D)),
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

                  const SizedBox(height: 45),

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
                    'YOUR MODE',
                    style: GoogleFonts.lilitaOne(
                      fontSize: 42,
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
                    'HOW DO YOU WANT TO PLAY?',
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.white70,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Local game
                  _GameModeCard(
                    icon: Icons.people_alt_rounded,
                    title: 'PLAY LOCAL',
                    subtitle: 'Two players • Same device',
                    iconColor: const Color(0xFF55DFFF),
                    gradient: const [Color(0xFF1769E8), Color(0xFF174DB8)],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlayerNamesScreen(),
                        ),
                      ); // Game screen will be opened here.
                    },
                  ),

                  const SizedBox(height: 22),

                  // Multiplayer
                  _GameModeCard(
                    icon: Icons.public_rounded,
                    title: 'MULTIPLAYER',
                    subtitle: 'Play online with friends',
                    iconColor: const Color(0xFFFFB7D5),
                    gradient: const [Color(0xFF7549E8), Color(0xFF5228B8)],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GridScreen(
                            player1: 'PLAYER 1',
                            player2: 'PLAYER 2',
                          ),
                        ),
                      ); // Multiplayer screen will be added later.
                    },
                  ),

                  const Spacer(),

                  Text(
                    'CONNECT • COMPETE • WIN',
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.white54,
                      letterSpacing: 1.5,
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

  static Widget _backgroundCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.18),
      ),
    );
  }
}

// ------------------------------------------------------------
// GAME MODE CARD
// ------------------------------------------------------------

class _GameModeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final List<Color> gradient;
  final VoidCallback onTap;

  const _GameModeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: gradient.first.withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.13),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: iconColor, size: 34),
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
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    subtitle,
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
