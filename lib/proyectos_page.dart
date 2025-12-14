import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
        final List<Map<String, dynamic>> proyectos = [
          {
            'titulo': 'SODITA - Sistema Gastronómico',
            'descripcion': languageProvider.isEnglish 
              ? 'Restaurant reservation management system with modern interface and booking functionality'
              : 'Sistema de gestión de reservas gastronómicas con interfaz moderna y funcionalidad de reservas',
            'tecnologias': [
              languageProvider.translate('web_development'),
              'Sistema de Reservas',
              'Gestión Gastronómica',
              'UI/UX Design',
            ],
            'url': 'https://sodita-314e6.web.app/',
            'categoria': languageProvider.translate('business'),
            'color': AppColors.accent,
          },
          {
            'titulo': 'Ciudad de Letras',
            'descripcion': languageProvider.isEnglish 
              ? 'Literary platform for writers and readers with interactive content and community features'
              : 'Plataforma literaria para escritores y lectores con contenido interactivo y funciones de comunidad',
            'tecnologias': [
              languageProvider.translate('flutter_web'),
              languageProvider.translate('creative_design'),
              'Literatura Digital',
              'Comunidad',
            ],
            'url': 'https://ciudaddeletras-97276.web.app/',
            'categoria': languageProvider.translate('creative'),
            'color': AppColors.accent,
          },
          {
            'titulo': 'Kraken Reparaciones',
            'descripcion': languageProvider.translate('kraken_desc'),
            'tecnologias': [
              languageProvider.translate('web_development'),
              languageProvider.translate('business_solutions'),
              languageProvider.translate('contact_forms'),
            ],
            'url': 'https://krakenreparaciones.com/',
            'categoria': languageProvider.translate('business'),
            'color': AppColors.accent,
          },
          {
            'titulo': 'Biblio Walsh',
            'descripcion': languageProvider.translate('biblio_walsh_desc'),
            'tecnologias': [
              languageProvider.translate('digital_platform'),
              languageProvider.translate('education_tech'),
              languageProvider.translate('database_management'),
            ],
            'url': 'https://bibliowalsh.org/',
            'categoria': languageProvider.translate('education'),
            'color': AppColors.accent,
          },
          {
            'titulo': 'Emiliana Arias Portfolio',
            'descripcion': languageProvider.translate('emiliana_arias_desc'),
            'tecnologias': [
              languageProvider.translate('flutter_web'),
              languageProvider.translate('responsive_design'),
              languageProvider.translate('ui_ux'),
              languageProvider.translate('animation'),
            ],
            'url': 'https://www.emilianaarias.com/',
            'categoria': languageProvider.translate('portfolio'),
            'color': AppColors.accent,
          },
          {
            'titulo': 'Punto Rojo Productora',
            'descripcion': languageProvider.translate('punto_rojo_desc'),
            'tecnologias': [
              languageProvider.translate('creative_design'),
              languageProvider.translate('web_development'),
              languageProvider.translate('portfolio_gallery'),
            ],
            'url': 'https://www.puntorojoproductora.com.ar/',
            'categoria': languageProvider.translate('creative'),
            'color': AppColors.accent,
          },
        ];

        final List<Map<String, dynamic>> currentProjects = [
          {
            'titulo': languageProvider.isEnglish ? 'Interactive Alphabet Learning' : 'Alfabeto Interactivo',
            'descripcion': languageProvider.translate('alphabet_app_desc'),
            'tecnologias': [
              languageProvider.translate('flutter_web'),
              languageProvider.translate('interactive_learning'),
              languageProvider.translate('child_education'),
              languageProvider.translate('gamification'),
            ],
            'url': '#',
            'categoria': languageProvider.translate('kids_app'),
            'color': AppColors.accent,
            'inDevelopment': true,
          },
          {
            'titulo': 'CONECTA',
            'descripcion': languageProvider.translate('dating_app_desc'),
            'tecnologias': [
              languageProvider.translate('flutter_web'),
              languageProvider.translate('accessibility'),
              languageProvider.translate('social_connection'),
              languageProvider.translate('inclusive_design'),
            ],
            'url': '#',
            'categoria': languageProvider.translate('dating_app'),
            'color': AppColors.accent,
            'inDevelopment': true,
            'image': 'assets/images/conecta.jpg',
          },
        ];

        final screenSize = MediaQuery.of(context).size;
        final isDesktop = screenSize.width > 1024;
        final isMobile = screenSize.width <= 768;
        final crossAxisCount = isDesktop ? 3 : (isMobile ? 1 : 2);

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            title: Text(
              languageProvider.translate('my_projects'),
              style: GoogleFonts.playfairDisplay(
                color: AppColors.ink,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            iconTheme: const IconThemeData(color: AppColors.ink),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: LanguageToggle(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCurrentProjectsSection(languageProvider, currentProjects, isDesktop),
                const SizedBox(height: 40),
                _buildFeaturedProjectsSection(languageProvider, proyectos, isDesktop, crossAxisCount),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrentProjectsSection(LanguageProvider languageProvider, List<Map<String, dynamic>> currentProjects, bool isDesktop) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                languageProvider.translate('current_projects'),
                style: GoogleFonts.playfairDisplay(
                  fontSize: isDesktop ? 36 : 28,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                ),
              ).animate().slideX(duration: Duration(milliseconds: 600)),
              SizedBox(width: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accentSoft.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.accent),
                ),
                child: Text(
                  languageProvider.translate('in_development'),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ).animate().scale(
                duration: Duration(milliseconds: 800),
                delay: Duration(milliseconds: 300),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.accent, AppColors.accentSoft],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ).animate().scaleX(
            duration: Duration(milliseconds: 800),
            delay: Duration(milliseconds: 300),
          ),
          SizedBox(height: 15),
          Text(
            languageProvider.isEnglish 
              ? 'Projects currently in development - exciting innovations coming soon!'
              : '¡Proyectos actualmente en desarrollo - innovaciones emocionantes próximamente!',
            style: GoogleFonts.robotoMono(
              fontSize: 16,
              color: Colors.white70,
            ),
          ).animate().fadeIn(
            duration: Duration(milliseconds: 800),
            delay: Duration(milliseconds: 500),
          ),
          SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth > 768 ? 2 : 1,
                  childAspectRatio: constraints.maxWidth > 768 ? 1.2 : 1.0,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: currentProjects.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: Duration(milliseconds: 600),
                    columnCount: 2,
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: _buildCurrentProjectCard(currentProjects[index], context),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentProjectCard(Map<String, dynamic> proyecto, BuildContext context) {
    final hasImage = proyecto['image'] != null;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: proyecto['color'].withOpacity(0.3),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // Development badge
            Positioned(
              top: 15,
              right: 15,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: proyecto['color'],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    Provider.of<LanguageProvider>(context).translate('in_development'),
                    style: GoogleFonts.robotoMono(
                      fontSize: 8,
                      color: AppColors.ink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            hasImage 
              ? Column(
                  children: [
                    // Image section
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                          child: Image.asset(
                            proyecto['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: proyecto['color'].withOpacity(0.1),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        color: proyecto['color'],
                                        size: 50,
                                      ),
                                      Text(
                                        'CONECTA',
                                        style: GoogleFonts.orbitron(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: proyecto['color'],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    // Content section
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: proyecto['color'].withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: proyecto['color'].withOpacity(0.5),
                                ),
                              ),
                              child: Text(
                                proyecto['categoria'],
                                style: GoogleFonts.robotoMono(
                                  fontSize: 12,
                                  color: proyecto['color'],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              proyecto['titulo'],
                              style: GoogleFonts.orbitron(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: proyecto['color'],
                              ),
                            ),
                            Spacer(),
                            Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: proyecto['color'].withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: proyecto['color']),
                                ),
                                child: Text(
                                  Provider.of<LanguageProvider>(context).isEnglish ? 'Coming Soon' : 'Próximamente',
                                  style: GoogleFonts.orbitron(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: proyecto['color'],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25), // Space for badge
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.accentSoft.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColors.accent,
                          ),
                        ),
                        child: Text(
                          proyecto['categoria'],
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.accent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        proyecto['titulo'],
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.ink,
                        ),
                      ),
                      SizedBox(height: 12),
                      Flexible(
                        child: Text(
                          proyecto['descripcion'],
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.muted,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 15),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (proyecto['tecnologias'] as List<String>).map((tech) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.border,
                              ),
                            ),
                            child: Text(
                              tech,
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: AppColors.muted,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      Spacer(),
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.accentSoft.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.accent),
                          ),
                          child: Text(
                            Provider.of<LanguageProvider>(context).isEnglish ? 'Coming Soon' : 'Próximamente',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColors.ink,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    ).animate().scale(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Widget _buildFeaturedProjectsSection(LanguageProvider languageProvider, List<Map<String, dynamic>> proyectos, bool isDesktop, int crossAxisCount) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            languageProvider.translate('featured_projects'),
            style: GoogleFonts.orbitron(
              fontSize: isDesktop ? 36 : 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF1493),
            ),
          ).animate().slideX(duration: Duration(milliseconds: 600)),
          SizedBox(height: 10),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF1493), Color(0xFF00FF00)],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ).animate().scaleX(
            duration: Duration(milliseconds: 800),
            delay: Duration(milliseconds: 300),
          ),
          SizedBox(height: 15),
          Text(
            languageProvider.translate('showcase_description'),
            style: GoogleFonts.robotoMono(
              fontSize: 16,
              color: Colors.white70,
            ),
          ).animate().fadeIn(
            duration: Duration(milliseconds: 800),
            delay: Duration(milliseconds: 500),
          ),
          SizedBox(height: 30),
          AnimationLimiter(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: isDesktop ? 1.8 : (crossAxisCount == 1 ? 1.1 : 1.3),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: proyectos.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: Duration(milliseconds: 600),
                  columnCount: crossAxisCount,
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildProjectCard(proyectos[index], context),
                    ),
                  ),
                );
            },
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> proyecto, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: proyecto['color'].withOpacity(0.3),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      proyecto['color'].withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.accentSoft.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColors.accent,
                          ),
                        ),
                        child: Text(
                          proyecto['categoria'],
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.accent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    proyecto['titulo'],
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                    ),
                  ),
                  SizedBox(height: 10),
                  Flexible(
                    child: Text(
                      proyecto['descripcion'],
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppColors.muted,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (proyecto['tecnologias'] as List<String>).map((tech) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.border,
                          ),
                        ),
                        child: Text(
                          tech,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppColors.muted,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.accentSoft.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.accent,
                          ),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.globe,
                          color: AppColors.accent,
                          size: 20,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _launchURL(proyecto['url']),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.ink,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Provider.of<LanguageProvider>(context).translate('view_live'),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            FaIcon(
                              FontAwesomeIcons.upRightFromSquare,
                              size: 12,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().scale(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
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
