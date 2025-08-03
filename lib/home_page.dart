import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  int _selectedProfile = 0; // 0: Developer, 1: Music Producer

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1024;
    final isTablet = screenSize.width > 768 && screenSize.width <= 1024;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.grey[900]!,
              Colors.black,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context, isDesktop),
              _buildProfileSelector(context),
              _buildProfileContent(context, isDesktop, isTablet),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              width: isDesktop ? 120 : 100,
              height: isDesktop ? 120 : 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFFF1493), Color(0xFF00FF00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFFF1493).withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Icon(
                Icons.person,
                size: isDesktop ? 60 : 50,
                color: Colors.black,
              ),
            ).animate().scale(
              duration: Duration(milliseconds: 800),
              curve: Curves.elasticOut,
            ),
          ),
          SizedBox(height: 20),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'JIDO',
                textStyle: GoogleFonts.orbitron(
                  fontSize: isDesktop ? 48 : 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF1493),
                  shadows: [
                    Shadow(
                      color: Color(0xFF00FF00),
                      offset: Offset(2, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
                speed: Duration(milliseconds: 200),
              ),
            ],
            totalRepeatCount: 1,
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF00FF00), width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              'Developer • Music Producer • Tech Entrepreneur',
              style: GoogleFonts.robotoMono(
                fontSize: isDesktop ? 16 : 12,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ).animate().slideX(
            duration: Duration(milliseconds: 1000),
            delay: Duration(milliseconds: 1500),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSelector(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildProfileButton(
            'DEVELOPER',
            0,
            FontAwesomeIcons.code,
            Color(0xFFFF1493),
          ),
          SizedBox(width: 30),
          _buildProfileButton(
            'ARTIST',
            1,
            FontAwesomeIcons.music,
            Color(0xFF00FF00),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileButton(String title, int index, IconData icon, Color color) {
    final isSelected = _selectedProfile == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedProfile = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
          border: Border.all(
            color: isSelected ? color : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: isSelected ? [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ] : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              color: isSelected ? color : Colors.grey,
              size: 20,
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.orbitron(
                color: isSelected ? color : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, bool isDesktop, bool isTablet) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: _selectedProfile == 0 
        ? _buildDeveloperProfile(context, isDesktop, isTablet)
        : _buildArtistProfile(context, isDesktop, isTablet),
    );
  }

  Widget _buildDeveloperProfile(BuildContext context, bool isDesktop, bool isTablet) {
    final projects = [
      {
        'title': 'Emiliana Arias Portfolio',
        'url': 'https://www.emilianaarias.com/',
        'icon': FontAwesomeIcons.paintBrush,
      },
      {
        'title': 'Kraken Reparaciones',
        'url': 'http://krakenrepaciones.com/',
        'icon': FontAwesomeIcons.tools,
      },
      {
        'title': 'Punto Rojo Productora',
        'url': 'https://www.puntorojoproductora.com.ar/',
        'icon': FontAwesomeIcons.video,
      },
      {
        'title': 'Biblio Walsh',
        'url': 'https://bibliowalsh.org/',
        'icon': FontAwesomeIcons.book,
      },
    ];

    return Container(
      key: ValueKey('developer'),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'SOFTWARE DEVELOPER',
            style: GoogleFonts.orbitron(
              fontSize: isDesktop ? 28 : 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF1493),
            ),
          ).animate().slideY(duration: Duration(milliseconds: 600)),
          SizedBox(height: 15),
          Text(
            'Independent Tech Entrepreneur & Full-Stack Developer',
            style: GoogleFonts.robotoMono(
              fontSize: isDesktop ? 16 : 14,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            alignment: WrapAlignment.center,
            children: projects.asMap().entries.map((entry) {
              final index = entry.key;
              final project = entry.value;
              final color = index % 2 == 0 ? Color(0xFFFF1493) : Color(0xFF00FF00);
              
              return _buildSimpleProjectButton(project, color);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleProjectButton(Map<String, dynamic> project, Color color) {
    return GestureDetector(
      onTap: () => _launchURL(project['url']),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              project['icon'] as IconData,
              color: color,
              size: 18,
            ),
            SizedBox(width: 12),
            Text(
              project['title'],
              style: GoogleFonts.orbitron(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 8),
            FaIcon(
              FontAwesomeIcons.upRightFromSquare,
              color: color,
              size: 14,
            ),
          ],
        ),
      ),
    ).animate().scale(
      duration: Duration(milliseconds: 400),
      delay: Duration(milliseconds: 100),
    );
  }

  Widget _buildArtistProfile(BuildContext context, bool isDesktop, bool isTablet) {
    return Container(
      key: ValueKey('artist'),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'MUSIC PRODUCER',
            style: GoogleFonts.orbitron(
              fontSize: isDesktop ? 28 : 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00FF00),
            ),
          ).animate().slideY(duration: Duration(milliseconds: 600)),
          SizedBox(height: 15),
          Text(
            'Electronic Music Producer & Audio Engineer',
            style: GoogleFonts.robotoMono(
              fontSize: isDesktop ? 16 : 14,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Container(
            width: isDesktop ? 100 : 80,
            height: isDesktop ? 100 : 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF00FF00), Color(0xFFFF1493)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF00FF00).withOpacity(0.5),
                  blurRadius: 15,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Icon(
              FontAwesomeIcons.youtube,
              size: isDesktop ? 40 : 32,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Jido_only',
            style: GoogleFonts.orbitron(
              fontSize: isDesktop ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00FF00),
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton.icon(
            onPressed: () => _launchURL('https://www.youtube.com/@Jido_only'),
            icon: FaIcon(FontAwesomeIcons.youtube, color: Colors.red, size: 20),
            label: Text(
              'Visit YouTube Channel',
              style: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF00FF00),
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ).animate().scale(
            duration: Duration(milliseconds: 800),
            delay: Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildContactButton(
                'More Projects',
                () => Navigator.pushNamed(context, '/proyectos'),
                FontAwesomeIcons.briefcase,
                Color(0xFFFF1493),
              ),
              _buildContactButton(
                'Get In Touch',
                () => Navigator.pushNamed(context, '/contacto'),
                FontAwesomeIcons.envelope,
                Color(0xFF00FF00),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            '© 2025 Jido. Crafted with Flutter 💙',
            style: GoogleFonts.robotoMono(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildContactButton(String title, VoidCallback onPressed, IconData icon, Color color) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: FaIcon(icon, size: 18),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.2),
        foregroundColor: color,
        side: BorderSide(color: color),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ).animate().slideY(
      duration: Duration(milliseconds: 600),
      delay: Duration(milliseconds: 400),
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      print('Could not launch $url with url_launcher: $e');
      // Fallback usando dart:html para web
      try {
        html.window.open(url, '_blank');
      } catch (htmlError) {
        print('Could not launch $url with dart:html: $htmlError');
      }
    }
  }
}
