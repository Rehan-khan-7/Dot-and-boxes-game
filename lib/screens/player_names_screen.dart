import 'package:dotandboxes/screens/game_screen.dart';
import 'package:dotandboxes/screens/grid_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'grid_screen.dart';

class PlayerNamesScreen extends StatefulWidget {
  const PlayerNamesScreen({super.key});

  @override
  State<PlayerNamesScreen> createState() => _PlayerNamesScreenState();
}

class _PlayerNamesScreenState extends State<PlayerNamesScreen> {
  final TextEditingController _player1Controller = TextEditingController();

  final TextEditingController _player2Controller = TextEditingController();

  @override
  void dispose() {
    _player1Controller.dispose();
    _player2Controller.dispose();
    super.dispose();
  }

  void _continue() {
    String player1 = _player1Controller.text.trim();
    String player2 = _player2Controller.text.trim();

    if (player1.isEmpty) {
      player1 = 'PLAYER 1';
    }

    if (player2.isEmpty) {
      player2 = 'PLAYER 2';
    }

    Navigator.pushNamed(
      context,
      '/grid-size',
      arguments: {'player1': player1, 'player2': player2},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07102F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 25),

              // Back button
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // Heading
              Text(
                'PLAYER SETUP',
                style: GoogleFonts.lilitaOne(
                  fontSize: 34,
                  letterSpacing: 1.5,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'ENTER YOUR NAMES',
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                  color: Colors.white54,
                ),
              ),

              const SizedBox(height: 45),

              // Player 1
              _playerInput(
                label: 'PLAYER 1',
                hint: 'Enter player 1 name',
                color: const Color(0xFF55DFFF),
                controller: _player1Controller,
                icon: Icons.person_rounded,
              ),

              const SizedBox(height: 25),

              // VS
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                  border: Border.all(color: Colors.white.withOpacity(0.12)),
                ),
                child: Center(
                  child: Text(
                    'VS',
                    style: GoogleFonts.lilitaOne(
                      fontSize: 17,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Player 2
              _playerInput(
                label: 'PLAYER 2',
                hint: 'Enter player 2 name',
                color: const Color(0xFFFF5A9D),
                controller: _player2Controller,
                icon: Icons.person_rounded,
              ),

              const Spacer(),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    String player1 = _player1Controller.text.trim();
                    String player2 = _player2Controller.text.trim();

                    if (player1.isEmpty) {
                      player1 = 'PLAYER 1';
                    }

                    if (player2.isEmpty) {
                      player2 = 'PLAYER 2';
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GridScreen(player1: player1, player2: player2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF55DFFF),
                    foregroundColor: const Color(0xFF07102F),
                    elevation: 10,
                    shadowColor: const Color(0xFF55DFFF).withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'CONTINUE',
                    style: GoogleFonts.lilitaOne(
                      fontSize: 21,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _playerInput({
    required String label,
    required String hint,
    required Color color,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: color,
          ),
        ),

        const SizedBox(height: 9),

        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withOpacity(0.45), width: 1.2),
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.08), blurRadius: 15),
            ],
          ),
          child: TextField(
            controller: controller,
            style: GoogleFonts.nunito(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            cursorColor: color,
            textCapitalization: TextCapitalization.words,
            maxLength: 15,
            decoration: InputDecoration(
              counterText: '',
              hintText: hint,
              hintStyle: GoogleFonts.nunito(
                color: Colors.white30,
                fontSize: 15,
              ),
              prefixIcon: Icon(icon, color: color),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 17,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
