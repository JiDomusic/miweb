import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import 'package:provider/provider.dart';
import 'language_provider.dart';
import 'widgets/language_toggle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedProfile = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final screenSize = MediaQuery.of(context).size;
        final isDesktop = screenSize.width > 1024;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: LanguageToggle(),
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_field.jpg'),
                fit: BoxFit.cover,
                opacity: 0.03,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  _buildHeader(context, isDesktop),
                  const SizedBox(height: 60),
                  _buildProfileSelector(context),
                  const SizedBox(height: 80),
                  _buildProfileContent(context, isDesktop),
                  const SizedBox(height: 100),
                  _buildFooter(context, isDesktop),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, bool isDesktop) {
    return Column(
      children: [
        Text(
          'JIDO',
          style: GoogleFonts.inter(
            fontSize: isDesktop ? 72 : 48,
            fontWeight: FontWeight.w300,
            letterSpacing: -2,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Developer • Producer • Entrepreneur',
          style: GoogleFonts.inter(
            fontSize: isDesktop ? 18 : 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF666666),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSelector(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width <= 768;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProfileTab('Developer', 0, isMobile),
        const SizedBox(width: 4),
        _buildProfileTab('Artist', 1, isMobile),
      ],
    );
  }

  Widget _buildProfileTab(String title, int index, bool isMobile) {
    final isSelected = _selectedProfile == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedProfile = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 32,
          vertical: isMobile ? 12 : 16,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A1A1A) : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected ? const Color(0xFF1A1A1A) : const Color(0xFFDDDDDD),
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : const Color(0xFF666666),
            fontWeight: FontWeight.w500,
            fontSize: isMobile ? 14 : 16,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, bool isDesktop) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _selectedProfile == 0
        ? _buildDeveloperProfile(context, isDesktop)
        : _buildArtistProfile(context, isDesktop),
    );
  }

  Widget _buildDeveloperProfile(BuildContext context, bool isDesktop) {
    final projects = [
      {
        'title': 'SODITA',
        'subtitle': 'Restaurant Management System',
        'url': 'https://reservasodita.web.app/',
      },
      {
        'title': 'Ciudad de Letras',
        'subtitle': 'Literary Platform',
        'url': 'https://ciudaddeletras-97276.web.app/',
      },
      {
        'title': 'Kraken Reparaciones',
        'subtitle': 'Repair Service',
        'url': 'https://krakenreparaciones.com/',
      },
      {
        'title': 'Biblio Walsh',
        'subtitle': 'Library System',
        'url': 'https://bibliowalsh.org/',
      },
      {
        'title': 'Emiliana Arias',
        'subtitle': 'Artist Portfolio',
        'url': 'https://www.emilianaarias.com/',
      },
      {
        'title': 'Punto Rojo',
        'subtitle': 'Production Company',
        'url': 'https://www.puntorojoproductora.com.ar/',
      },
    ];

    return Container(
      key: const ValueKey('developer'),
      constraints: BoxConstraints(maxWidth: isDesktop ? 1000 : 600),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected Projects',
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 32 : 24,
              fontWeight: FontWeight.w300,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 40),
          ...projects.map((project) => _buildProjectItem(project, isDesktop)),
        ],
      ),
    );
  }

  Widget _buildProjectItem(Map<String, dynamic> project, bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: InkWell(
        onTap: () => _launchURL(project['url']),
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project['title'],
                    style: GoogleFonts.inter(
                      fontSize: isDesktop ? 20 : 18,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project['subtitle'],
                    style: GoogleFonts.inter(
                      fontSize: isDesktop ? 14 : 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward,
              size: 20,
              color: const Color(0xFF666666),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArtistProfile(BuildContext context, bool isDesktop) {
    final links = [
      {
        'title': 'YouTube',
        'subtitle': '@Jido_only',
        'url': 'https://www.youtube.com/@Jido_only',
      },
      {
        'title': 'Bandcamp',
        'subtitle': 'Music Releases',
        'url': 'https://jido.bandcamp.com/',
      },
      {
        'title': 'Photography',
        'subtitle': 'Visual Blog',
        'url': 'https://mariajimenadominguez.blogspot.com/?m=1',
      },
      {
        'title': 'Documentary',
        'subtitle': 'Vimeo',
        'url': 'https://vimeo.com/76730484',
      },
    ];

    return Container(
      key: const ValueKey('artist'),
      constraints: BoxConstraints(maxWidth: isDesktop ? 1000 : 600),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Music & Art',
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 32 : 24,
              fontWeight: FontWeight.w300,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 40),
          ...links.map((link) => _buildProjectItem(link, isDesktop)),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isDesktop) {
    return Container(
      constraints: BoxConstraints(maxWidth: isDesktop ? 1000 : 600),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: const Color(0xFFDDDDDD),
            thickness: 1,
          ),
          const SizedBox(height: 32),
          Text(
            'Get in touch',
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 24 : 20,
              fontWeight: FontWeight.w300,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 24),
          _buildContactLink('More Projects', () => Navigator.pushNamed(context, '/proyectos')),
          const SizedBox(height: 16),
          _buildContactLink('Contact', () => Navigator.pushNamed(context, '/contacto')),
          const SizedBox(height: 16),
          _buildContactLink('WhatsApp', () => _launchURL('https://wa.me/3413363551')),
          const SizedBox(height: 48),
          Text(
            '© 2025 — Built with Flutter',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF999999),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactLink(String title, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.arrow_forward,
            size: 16,
            color: const Color(0xFF666666),
          ),
        ],
      ),
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
      try {
        html.window.open(url, '_blank');
      } catch (htmlError) {
        print('Could not launch $url with dart:html: $htmlError');
      }
    }
  }
}
