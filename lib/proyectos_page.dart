import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;
import 'language_provider.dart';
import 'widgets/language_toggle.dart';
import 'theme.dart';

class ProyectosPage extends StatelessWidget {
  const ProyectosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isEn = languageProvider.isEnglish;
        final screenSize = MediaQuery.of(context).size;
        final isDesktop = screenSize.width > 1024;
        final isMobile = screenSize.width <= 600;

        final List<Map<String, dynamic>> projects = [
          {
            'title': 'Laplace',
            'description': isEn
                ? 'Student enrollment and fee management system for educational institutions.'
                : 'Sistema de inscripciones y gestión de cuotas para instituciones educativas.',
            'technologies': ['Flutter Web', 'Firebase', 'Cloud Functions'],
            'url': 'https://laplace-web.web.app/',
            'category': isEn ? 'Education' : 'Educación',
            'image': 'assets/images/laplace.png',
          },
          {
            'title': 'SODITA',
            'description': isEn
                ? 'Restaurant website with menu, events and contact.'
                : 'Sitio web del restaurante con menú, eventos y contacto.',
            'technologies': ['Flutter Web', 'Firebase', 'UI/UX'],
            'url': 'https://sodita.com.ar',
            'category': isEn ? 'Business' : 'Negocio',
            'image': 'assets/images/sodita.png',
          },
          {
            'title': isEn ? 'SODITA Reservations' : 'Reservas SODITA',
            'description': isEn
                ? 'Online reservation system with real-time availability and booking management.'
                : 'Sistema de reservas online con disponibilidad en tiempo real y gestión de reservas.',
            'technologies': ['Flutter Web', 'Firebase', isEn ? 'Realtime DB' : 'BD Tiempo Real'],
            'url': 'https://reservasodita.web.app/',
            'category': isEn ? 'Business' : 'Negocio',
            'image': 'assets/images/reservas.png',
          },
          {
            'title': 'Luján Allemand',
            'description': isEn
                ? 'Visual artist portfolio showcasing artwork and exhibitions.'
                : 'Portfolio de artista visual con obras y exposiciones.',
            'technologies': ['Flutter Web', 'Firebase', isEn ? 'Gallery' : 'Galería'],
            'url': 'https://lujan-allemand.web.app',
            'category': 'Portfolio',
            'image': 'assets/images/lujan.png',
          },
          {
            'title': 'Kraken Reparaciones',
            'description': isEn
                ? 'Technical services website with repair tracking system.'
                : 'Sitio de servicios técnicos con sistema de seguimiento de reparaciones.',
            'technologies': ['Flutter Web', 'Firebase', 'WhatsApp API'],
            'url': 'https://krakenreparaciones.com/',
            'category': isEn ? 'Business' : 'Negocio',
            'image': 'assets/images/kraken.png',
          },
          {
            'title': 'Biblio Walsh',
            'description': isEn
                ? 'Digital library platform providing access to educational resources and academic materials.'
                : 'Plataforma de biblioteca digital con acceso a recursos educativos y materiales académicos.',
            'technologies': [isEn ? 'Digital Platform' : 'Plataforma Digital', isEn ? 'Database' : 'Base de Datos', isEn ? 'Search' : 'Búsqueda'],
            'url': 'https://bibliowalsh.org/',
            'category': isEn ? 'Education' : 'Educación',
          },
          {
            'title': 'Emiliana Arias',
            'description': isEn
                ? 'Percussionist portfolio with performances and music projects.'
                : 'Portfolio de percusionista con performances y proyectos musicales.',
            'technologies': ['Flutter Web', isEn ? 'Gallery' : 'Galería', isEn ? 'Animation' : 'Animación'],
            'url': 'https://www.emilianaarias.com/',
            'category': 'Portfolio',
            'image': 'assets/images/emiliana.png',
          },
          {
            'title': 'Punto Rojo Productora',
            'description': isEn
                ? 'Creative production company website showcasing audiovisual services and portfolio gallery.'
                : 'Sitio web de empresa de producción creativa con servicios audiovisuales y galería de portafolio.',
            'technologies': [isEn ? 'Web Development' : 'Desarrollo Web', isEn ? 'Gallery' : 'Galería', 'Video'],
            'url': 'https://www.puntorojoproductora.com.ar/',
            'category': isEn ? 'Creative' : 'Creativo',
          },
          {
            'title': isEn ? 'Interactive Alphabet' : 'Alfabeto Interactivo',
            'description': isEn
                ? 'Educational app to help children learn to read through engaging alphabet activities and games.'
                : 'App educativa para ayudar a niños a aprender a leer con actividades del alfabeto y juegos.',
            'technologies': ['Flutter', isEn ? 'Gamification' : 'Gamificación', isEn ? 'Education' : 'Educación'],
            'url': 'https://ciudaddeletras-97276.web.app',
            'category': isEn ? 'Kids App' : 'App Infantil',
          },
        ];

        final List<Map<String, dynamic>> inDevelopment = [
          {
            'title': 'CONECTA',
            'description': isEn
                ? 'Inclusive dating application focused on meaningful connections for people with disabilities.'
                : 'Aplicación de citas inclusiva enfocada en conexiones significativas para personas con discapacidades.',
            'technologies': ['Flutter', 'Firebase', isEn ? 'Accessibility' : 'Accesibilidad'],
            'category': 'Social',
          },
        ];

        return Scaffold(
          backgroundColor: AppColors.background,
          body: CustomScrollView(
            slivers: [
              _buildAppBar(context, isEn),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 120 : 24,
                    vertical: isDesktop ? 60 : 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(isDesktop, isEn),
                      SizedBox(height: isDesktop ? 60 : 40),
                      _buildProjectsGrid(projects, isDesktop, isMobile),
                      SizedBox(height: isDesktop ? 80 : 50),
                      _buildInDevelopmentSection(inDevelopment, isDesktop, isEn),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  SliverAppBar _buildAppBar(BuildContext context, bool isEn) {
    return SliverAppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      floating: true,
      pinned: true,
      expandedHeight: 70,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.ink),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 48),
              Text(
                isEn ? 'Projects' : 'Proyectos',
                style: GoogleFonts.inter(
                  color: AppColors.ink,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const LanguageToggle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDesktop, bool isEn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEn ? 'All Projects' : 'Todos los Proyectos',
          style: GoogleFonts.inter(
            fontSize: isDesktop ? 48 : 32,
            fontWeight: FontWeight.w600,
            color: AppColors.ink,
            letterSpacing: -1.5,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: isDesktop ? 600 : double.infinity,
          child: Text(
            isEn
                ? 'A collection of web applications and digital products I\'ve built for clients and personal projects.'
                : 'Una colección de aplicaciones web y productos digitales que he construido para clientes y proyectos personales.',
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: AppColors.muted,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsGrid(List<Map<String, dynamic>> projects, bool isDesktop, bool isMobile) {
    final crossAxisCount = isDesktop ? 3 : (isMobile ? 1 : 2);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: isDesktop ? 1.1 : (isMobile ? 1.3 : 1.0),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return _buildProjectCard(projects[index]);
      },
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(project['url']),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.accentSoft,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      project['category'],
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                  const Icon(Icons.north_east, size: 16, color: AppColors.muted),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                project['title'],
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  project['description'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.muted,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: (project['technologies'] as List<String>).map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      tech,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.muted,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInDevelopmentSection(List<Map<String, dynamic>> projects, bool isDesktop, bool isEn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              isEn ? 'In Development' : 'En Desarrollo',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.muted,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.ink,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                isEn ? 'Coming Soon' : 'Próximamente',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        isDesktop
            ? Row(
                children: projects
                    .map((p) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: _buildDevCard(p),
                          ),
                        ))
                    .toList(),
              )
            : Column(
                children: projects
                    .map((p) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildDevCard(p),
                        ))
                    .toList(),
              ),
      ],
    );
  }

  Widget _buildDevCard(Map<String, dynamic> project) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              project['category'],
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            project['title'],
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            project['description'],
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.muted,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: (project['technologies'] as List<String>).map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  tech,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.muted,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      try {
        html.window.open(url, '_blank');
      } catch (_) {}
    }
  }
}
