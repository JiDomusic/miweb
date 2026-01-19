import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;
import 'language_provider.dart';
import 'widgets/language_toggle.dart';
import 'theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isHoveringCTA = false;
  bool _isHoveringDemo = false;
  int _hoveredProject = -1;

  static const _whatsappUrl = 'https://wa.me/3413363551';
  static const _instagramUrl = 'https://www.instagram.com/jido_only';
  static const _demoUrl = 'https://sodita.com.ar';

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final screenSize = MediaQuery.of(context).size;
        final isDesktop = screenSize.width > 1024;
        final isEn = languageProvider.isEnglish;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroSection(isDesktop, isEn),
                    _buildServicesSection(isDesktop, isEn),
                    _buildProjectsSection(context, isDesktop, isEn),
                    _buildCTASection(isDesktop, isEn),
                    _buildFooter(context, isDesktop, isEn),
                  ],
                ),
              ),
              _buildNavBar(context, isDesktop, isEn),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavBar(BuildContext context, bool isDesktop, bool isEn) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        color: AppColors.background,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 60 : 20,
          vertical: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _launchURL(_instagramUrl),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const FaIcon(FontAwesomeIcons.instagram, size: 16, color: AppColors.ink),
                    const SizedBox(width: 6),
                    Text(
                      'jido_only',
                      style: GoogleFonts.inter(
                        fontSize: isDesktop ? 16 : 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                if (isDesktop) ...[
                  _navLink(isEn ? 'Projects' : 'Proyectos', () => Navigator.pushNamed(context, '/proyectos')),
                  const SizedBox(width: 24),
                  _navLink(isEn ? 'Contact' : 'Contacto', () => Navigator.pushNamed(context, '/contacto')),
                  const SizedBox(width: 24),
                ],
                const LanguageToggle(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _navLink(String label, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.muted,
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isDesktop, bool isEn) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isDesktop ? 60 : 24,
        isDesktop ? 140 : 100,
        isDesktop ? 60 : 24,
        isDesktop ? 120 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              'Fullstack Developer',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.muted,
                letterSpacing: 1,
              ),
            ),
          ),
          SizedBox(height: isDesktop ? 40 : 32),

          // Headline grande
          Text(
            isEn
                ? 'Building digital\nproducts that work.'
                : 'Construyo productos\ndigitales que funcionan.',
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 80 : 44,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
              height: 1.0,
              letterSpacing: -3,
            ),
          ),
          SizedBox(height: isDesktop ? 40 : 28),

          // Subtítulo
          SizedBox(
            width: isDesktop ? 650 : double.infinity,
            child: Text(
              isEn
                  ? 'I create fast, clean web applications with Flutter and Firebase. From concept to deployment, focused on results.'
                  : 'Creo aplicaciones web rápidas y limpias con Flutter y Firebase. Del concepto al deploy, enfocado en resultados.',
              style: GoogleFonts.inter(
                fontSize: isDesktop ? 22 : 18,
                fontWeight: FontWeight.w400,
                color: AppColors.muted,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: isDesktop ? 50 : 36),

          // CTAs
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _isHoveringCTA = true),
                onExit: (_) => setState(() => _isHoveringCTA = false),
                child: GestureDetector(
                  onTap: () => _launchURL(_whatsappUrl),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                    decoration: BoxDecoration(
                      color: _isHoveringCTA ? AppColors.muted : AppColors.ink,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 18),
                        const SizedBox(width: 12),
                        Text(
                          isEn ? 'Start a project' : 'Iniciar proyecto',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _isHoveringDemo = true),
                onExit: (_) => setState(() => _isHoveringDemo = false),
                child: GestureDetector(
                  onTap: () => _launchURL(_demoUrl),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                    decoration: BoxDecoration(
                      color: _isHoveringDemo ? AppColors.accentSoft : Colors.transparent,
                      border: Border.all(color: AppColors.border, width: 1.5),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      isEn ? 'View demo' : 'Ver demo',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isDesktop ? 60 : 40),

          // Social link
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _launchURL(_instagramUrl),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FaIcon(FontAwesomeIcons.instagram, size: 18, color: AppColors.muted),
                  const SizedBox(width: 10),
                  Text(
                    '@jido_only',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection(bool isDesktop, bool isEn) {
    final services = [
      {
        'num': '01',
        'title': isEn ? 'Web Apps' : 'Apps Web',
        'desc': isEn
            ? 'Fast, responsive applications with Flutter Web, React and modern frameworks.'
            : 'Aplicaciones rápidas y responsivas con Flutter Web, React y frameworks modernos.',
        'tech': 'Flutter · React · TypeScript',
      },
      {
        'num': '02',
        'title': isEn ? 'Mobile' : 'Móvil',
        'desc': isEn
            ? 'Cross-platform apps with native performance for iOS and Android.'
            : 'Apps multiplataforma con rendimiento nativo para iOS y Android.',
        'tech': 'Flutter · Dart · Native',
      },
      {
        'num': '03',
        'title': 'Backend',
        'desc': isEn
            ? 'Scalable infrastructure with databases, APIs and cloud services.'
            : 'Infraestructura escalable con bases de datos, APIs y servicios cloud.',
        'tech': 'Firebase · Supabase · Node.js · SQL',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 24,
        vertical: isDesktop ? 100 : 60,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEn ? 'WHAT I DO' : 'LO QUE HAGO',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.muted,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: isDesktop ? 60 : 40),
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: services.asMap().entries.map((entry) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: entry.key < 2 ? 40 : 0),
                        child: _serviceItem(entry.value, isDesktop),
                      ),
                    );
                  }).toList(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: services.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 48),
                    child: _serviceItem(s, isDesktop),
                  )).toList(),
                ),
        ],
      ),
    );
  }

  Widget _serviceItem(Map<String, String> service, bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          service['num']!,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.muted,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          service['title']!,
          style: GoogleFonts.inter(
            fontSize: isDesktop ? 28 : 24,
            fontWeight: FontWeight.w600,
            color: AppColors.ink,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          service['desc']!,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.muted,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          service['tech']!,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.ink,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsSection(BuildContext context, bool isDesktop, bool isEn) {
    final projects = [
      {
        'title': 'Laplace',
        'desc': isEn ? 'Student enrollment & fee management' : 'Inscripciones y gestión de cuotas',
        'url': 'https://laplace-web.web.app/',
        'tag': isEn ? 'Education' : 'Educación',
      },
      {
        'title': 'SODITA',
        'desc': isEn ? 'Restaurant reservation platform' : 'Plataforma de reservas gastronómicas',
        'url': 'https://sodita.com.ar',
        'tag': isEn ? 'Business' : 'Negocio',
      },
      {
        'title': 'Luján Allemand',
        'desc': isEn ? 'Visual artist portfolio' : 'Portfolio de artista visual',
        'url': 'https://lujan-allemand.web.app',
        'tag': 'Portfolio',
      },
      {
        'title': 'Kraken',
        'desc': isEn ? 'Technical services' : 'Servicios técnicos',
        'url': 'https://krakenreparaciones.com/',
        'tag': isEn ? 'Business' : 'Negocio',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 24,
        vertical: isDesktop ? 100 : 60,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEn ? 'Selected work' : 'Trabajos',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.muted,
                  letterSpacing: 2,
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/proyectos'),
                  child: Row(
                    children: [
                      Text(
                        isEn ? 'View all' : 'Ver todos',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, size: 18, color: AppColors.ink),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isDesktop ? 50 : 32),
          ...projects.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;
            return _projectRow(project, index, isDesktop);
          }),
        ],
      ),
    );
  }

  Widget _projectRow(Map<String, String> project, int index, bool isDesktop) {
    final isHovered = _hoveredProject == index;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredProject = index),
      onExit: (_) => setState(() => _hoveredProject = -1),
      child: GestureDetector(
        onTap: () => _launchURL(project['url']!),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            vertical: isDesktop ? 32 : 24,
            horizontal: isHovered ? 20 : 0,
          ),
          decoration: BoxDecoration(
            color: isHovered ? AppColors.accentSoft : Colors.transparent,
            border: Border(bottom: BorderSide(color: AppColors.border)),
            borderRadius: BorderRadius.circular(isHovered ? 12 : 0),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  project['title']!,
                  style: GoogleFonts.inter(
                    fontSize: isDesktop ? 28 : 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              if (isDesktop)
                Expanded(
                  flex: 2,
                  child: Text(
                    project['desc']!,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: AppColors.muted,
                    ),
                  ),
                ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  project['tag']!,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.muted,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: isHovered ? 0.125 : 0,
                child: const Icon(Icons.arrow_outward, size: 20, color: AppColors.ink),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCTASection(bool isDesktop, bool isEn) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(isDesktop ? 60 : 24),
      padding: EdgeInsets.all(isDesktop ? 80 : 40),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEn ? 'Let\'s work together' : 'Trabajemos juntos',
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 56 : 36,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.1,
              letterSpacing: -2,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: isDesktop ? 500 : double.infinity,
            child: Text(
              isEn
                  ? 'Have a project in mind? Send me a message and I\'ll get back to you within 24 hours.'
                  : '¿Tenés un proyecto en mente? Enviame un mensaje y te respondo en 24 horas.',
              style: GoogleFonts.inter(
                fontSize: 18,
                color: Colors.white70,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _launchURL(_whatsappUrl),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const FaIcon(FontAwesomeIcons.whatsapp, color: AppColors.ink, size: 18),
                        const SizedBox(width: 12),
                        Text(
                          'WhatsApp',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _launchURL(_instagramUrl),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white30),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const FaIcon(FontAwesomeIcons.instagram, color: Colors.white, size: 18),
                        const SizedBox(width: 12),
                        Text(
                          '@jido_only',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isDesktop, bool isEn) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 24,
        vertical: 40,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© 2026 jido.dev',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.muted,
            ),
          ),
          Text(
            'Flutter & Firebase',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      final uri = Uri.parse(url);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      try {
        html.window.open(url, '_blank');
      } catch (_) {}
    }
  }
}
