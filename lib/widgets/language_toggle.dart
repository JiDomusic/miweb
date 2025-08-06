import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../language_provider.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Color(0xFF00FF00).withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageButton(
                'ES',
                languageProvider.isSpanish,
                () => languageProvider.setLanguage('es'),
                Color(0xFFFF1493),
              ),
              SizedBox(width: 6),
              _buildLanguageButton(
                'EN',
                languageProvider.isEnglish,
                () => languageProvider.setLanguage('en'),
                Color(0xFF00FF00),
              ),
              SizedBox(width: 6),
              _buildLanguageButton(
                '中',
                languageProvider.isChinese,
                () => languageProvider.setLanguage('zh'),
                Color(0xFF00BFFF),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageButton(
    String text,
    bool isSelected,
    VoidCallback onTap,
    Color color,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: isSelected
              ? Border.all(color: color, width: 1)
              : null,
        ),
        child: Text(
          text,
          style: GoogleFonts.orbitron(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? color : Colors.white60,
          ),
        ),
      ),
    );
  }
}