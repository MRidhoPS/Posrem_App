import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
      width: double.infinity,
      height: 250,
      color: Colors.black,
      child: Text(
        textAlign: TextAlign.start,
        "Welcome Kader\nPosrem",
        style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w600,
            letterSpacing: 1),
      ),
    );
  }
}
