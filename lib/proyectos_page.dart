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
          // Beauty & Salon Management
          {
            'title': 'Bella Color',
            'description': isEn
                ? 'Premium booking system for salons and beauty businesses with staff management and service pricing.'
                : 'Sistema de reservas premium para salones y negocios de belleza con gestión de personal y precios de servicios.',
            'technologies': ['Flutter Web', 'Supabase', 'Real-time'],
            'url': 'https://bella-color.web.app',
            'category': isEn ? 'Beauty & Salons' : 'Belleza & Salones',
            'image': 'assets/images/bellacolor_promo_new.jpg',
          },
          {
            'title': 'Alaía',
            'description': isEn
                ? 'Laser hair removal booking system with session tracking and zone-based management.'
                : 'Sistema de reservas para depilación láser con seguimiento de sesiones y gestión por zonas.',
            'technologies': ['Flutter Web', 'Supabase', isEn ? 'Payments' : 'Pagos'],
            'url': 'https://alaia-depilacion.web.app',
            'category': isEn ? 'Beauty & Salons' : 'Belleza & Salones',
            'image': 'assets/images/bellacolor3.jpg',
          },
          // Food Service
          {
            'title': isEn ? 'Reservas JJ' : 'Sistema de Reservas JJ',
            'description': isEn
                ? 'Multi-tenant restaurant reservation system with real-time availability, staff scheduling and admin dashboard.'
                : 'Sistema multi-tenant de reservas para restaurantes con disponibilidad en tiempo real y panel admin.',
            'technologies': ['Flutter Web', 'Supabase', isEn ? 'Real-time' : 'Tiempo Real'],
            'url': 'https://reserva-jj.web.app',
            'category': isEn ? 'Food Service' : 'Servicios de Comida',
            'image': 'assets/images/IMG-20260322-WA0081.jpg',
          },
          // Financial Services
          {
            'title': 'Billetera JJ',
            'description': isEn
                ? 'Digital wallet app for ARS/USD transfers, P2P payments, QR deposits and exchange rates.'
                : 'App de billetera digital para transferencias ARS/USD, pagos P2P, depósitos por QR y cotizaciones.',
            'technologies': ['Flutter', 'Supabase Auth', isEn ? 'Crypto' : 'Criptografía'],
            'url': 'https://billetera-2026.web.app',
            'category': isEn ? 'Finance' : 'Finanzas',
            'image': 'assets/images/billetera_nuevo.jpg',
          },
          {
            'title': 'AppFirmas FlashCash',
            'description': isEn
                ? 'Mobile app wrapper for digital signatures, document scanning, and verification workflows.'
                : 'App móvil para firmas digitales, escaneo de documentos y flujos de verificación.',
            'technologies': ['Flutter', 'WebView', isEn ? 'Camera' : 'Cámara'],
            'url': null,
            'category': isEn ? 'Finance' : 'Finanzas',
            'image': 'assets/images/bellacolor_vertical.png',
          },
          // Education
          {
            'title': 'Laplace',
            'description': isEn
                ? 'Student enrollment and fee management system for educational institutions.'
                : 'Sistema de inscripciones y gestión de cuotas para instituciones educativas.',
            'technologies': ['Flutter Web', 'Firebase', 'Cloud Functions'],
            'url': 'https://laplace-web.web.app/',
            'category': isEn ? 'Education' : 'Educación',
            'image': 'assets/images/laplace_nuevo.jpg',
          },
          {
            'title': 'Biblio Walsh',
            'description': isEn
                ? 'Digital library platform providing access to educational resources and academic materials.'
                : 'Plataforma de biblioteca digital con acceso a recursos educativos y materiales académicos.',
            'technologies': [isEn ? 'Digital Platform' : 'Plataforma Digital', isEn ? 'Database' : 'Base de Datos', isEn ? 'Search' : 'Búsqueda'],
            'url': 'https://bibliowalsh.org/',
            'category': isEn ? 'Education' : 'Educación',
            'image': 'assets/images/bibliowalsh.jpg',
          },
          {
            'title': isEn ? 'Interactive Alphabet' : 'Alfabeto Interactivo',
            'description': isEn
                ? 'Educational app to help children learn to read through alphabet games.'
                : 'App educativa para ayudar a niños a aprender a leer con juegos del alfabeto.',
            'technologies': ['Flutter', isEn ? 'Gamification' : 'Gamificación', isEn ? 'Education' : 'Educación'],
            'url': 'https://ciudaddeletras-97276.web.app',
            'category': isEn ? 'Kids App' : 'App Infantil',
            'image': 'assets/images/alfabeto.jpg',
          },
          // Business & Services
          {
            'title': 'Kraken Reparaciones',
            'description': isEn
                ? 'Technical services website with repair tracking system.'
                : 'Sitio de servicios técnicos con sistema de seguimiento de reparaciones.',
            'technologies': ['Flutter Web', 'Firebase', 'WhatsApp API'],
            'url': 'https://krakenreparaciones.com/',
            'category': isEn ? 'Business' : 'Negocio',
            'image': 'assets/images/kraken.jpg',
          },
          {
            'title': 'Dietética Centro',
            'description': isEn
                ? 'Web service for health food stores in Argentina.'
                : 'Servicio web para dietéticas en Argentina.',
            'technologies': ['Flutter Web', 'Firebase', 'UI/UX'],
            'url': 'https://dietetica-centro.web.app/',
            'category': isEn ? 'Business' : 'Negocio',
            'image': 'assets/images/dietetica.png',
          },
          // Portfolio & Creative
          {
            'title': 'Luján Allemand',
            'description': isEn
                ? 'Visual artist portfolio showcasing artwork and exhibitions.'
                : 'Portfolio de artista visual con obras y exposiciones.',
            'technologies': ['Flutter Web', 'Firebase', isEn ? 'Gallery' : 'Galería'],
            'url': 'https://lujan-allemand.web.app',
            'category': 'Portfolio',
            'image': 'assets/images/laplace.jpg',
          },
          {
            'title': 'Emiliana Arias',
            'description': isEn
                ? 'Percussionist portfolio with performances and music projects.'
                : 'Portfolio de percusionista con performances y proyectos musicales.',
            'technologies': ['Flutter Web', isEn ? 'Gallery' : 'Galería', isEn ? 'Animation' : 'Animación'],
            'url': 'https://www.emilianaarias.com/',
            'category': 'Portfolio',
            'image': 'assets/images/emiliana.jpg',
          },
          {
            'title': 'Punto Rojo Productora',
            'description': isEn
                ? 'Creative production company website showcasing audiovisual services and portfolio gallery.'
                : 'Sitio web de empresa de producción creativa con servicios audiovisuales y galería de portafolio.',
            'technologies': [isEn ? 'Web Development' : 'Desarrollo Web', isEn ? 'Gallery' : 'Galería', 'Video'],
            'url': 'https://www.puntorojoproductora.com.ar/',
            'category': isEn ? 'Creative' : 'Creativo',
            'image': 'assets/images/puntorojoproductora.jpg',
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
    final hasImage = project['image'] != null;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(project['url']),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen de fondo
              if (hasImage)
                Expanded(
                  flex: 3,
                  child: Image.asset(
                    project['image'],
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.accentSoft,
                        child: const Center(
                          child: Icon(Icons.image, color: AppColors.muted, size: 40),
                        ),
                      );
                    },
                  ),
                ),
              // Contenido
              Expanded(
                flex: hasImage ? 2 : 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.accentSoft,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              project['category'],
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.ink,
                              ),
                            ),
                          ),
                          const Icon(Icons.north_east, size: 14, color: AppColors.muted),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        project['title'],
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.ink,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: Text(
                          project['description'],
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.muted,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: (project['technologies'] as List<String>).take(3).map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              tech,
                              style: GoogleFonts.inter(
                                fontSize: 10,
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
