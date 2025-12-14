import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;
import 'language_provider.dart';
import 'widgets/language_toggle.dart';
import 'theme.dart';

class ContactoPage extends StatelessWidget {
  const ContactoPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final screenSize = MediaQuery.of(context).size;
        
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            title: Text(
              languageProvider.translate('get_in_touch'),
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
                _buildHeader(screenSize.width > 1024, languageProvider),
                SizedBox(height: 32),
                _buildContactSection(languageProvider),
                SizedBox(height: 32),
                _buildProjectsSection(languageProvider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(bool isDesktop, LanguageProvider languageProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageProvider.translate('lets_connect'),
          style: GoogleFonts.playfairDisplay(
            fontSize: isDesktop ? 36 : 28,
            fontWeight: FontWeight.w600,
            color: AppColors.ink,
          ),
        ).animate().slideX(duration: Duration(milliseconds: 600)),
        SizedBox(height: 10),
        Container(
          height: 3,
          width: 120,
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
        SizedBox(height: 20),
        Text(
          languageProvider.translate('ready_to_collaborate'),
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppColors.muted,
            height: 1.6,
          ),
        ).animate().fadeIn(
          duration: Duration(milliseconds: 800),
          delay: Duration(milliseconds: 500),
        ),
      ],
    );
  }

  Widget _buildContactSection(LanguageProvider languageProvider) {
    final contactMethods = [
      {
        'icon': FontAwesomeIcons.envelope,
        'title': 'Email',
        'subtitle': 'equiz.rec@gmail.com',
        'color': AppColors.accent,
        'action': () => _launchURL('mailto:equiz.rec@gmail.com'),
      },
      {
        'icon': FontAwesomeIcons.whatsapp,
        'title': 'WhatsApp',
        'subtitle': 'Send me a message',
        'color': Color(0xFF25D366),
        'action': () => _launchURL('https://wa.me/3413363551'),
      },
      {
        'icon': FontAwesomeIcons.instagram,
        'title': 'Instagram',
        'subtitle': '@jido_only',
        'color': Color(0xFFE4405F),
        'action': () => _launchURL('https://www.instagram.com/jido_only'),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.ink,
          ),
        ).animate().slideY(duration: Duration(milliseconds: 600)),
        SizedBox(height: 25),
        ...contactMethods.asMap().entries.map((entry) {
          final index = entry.key;
          final method = entry.value;
          
          return Container(
            margin: EdgeInsets.only(bottom: 20),
            child: GestureDetector(
              onTap: method['action'] as VoidCallback,
              child: Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.border,
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
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: (method['color'] as Color).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: FaIcon(
                        method['icon'] as IconData,
                        color: method['color'] as Color,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            method['title'] as String,
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: method['color'] as Color,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            method['subtitle'] as String,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FaIcon(
                      FontAwesomeIcons.upRightFromSquare,
                      color: method['color'] as Color,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ).animate().slideX(
            duration: Duration(milliseconds: 600),
            delay: Duration(milliseconds: 200 + (index * 100)),
          );
        }),
      ],
    );
  }

  Widget _buildProjectsSection(LanguageProvider languageProvider) {
    final projects = [
      {
        'icon': FontAwesomeIcons.youtube,
        'title': 'YouTube Music',
        'subtitle': 'Jido_only Channel',
        'color': Color(0xFFFF0000),
        'action': () => _launchURL('https://www.youtube.com/@Jido_only'),
      },
      {
        'icon': FontAwesomeIcons.bandcamp,
        'title': 'Bandcamp',
        'subtitle': 'Music Releases',
        'color': Color(0xFF629aa0),
        'action': () => _launchURL('https://jido.bandcamp.com/'),
      },
      {
        'icon': FontAwesomeIcons.camera,
        'title': 'Photography Blog',
        'subtitle': 'Visual Stories',
        'color': AppColors.accent,
        'action': () => _launchURL('https://mariajimenadominguez.blogspot.com/?m=1'),
      },
      {
        'icon': FontAwesomeIcons.vimeo,
        'title': 'Documentary',
        'subtitle': 'Film Project',
        'color': Color(0xFF1ab7ea),
        'action': () => _launchURL('https://vimeo.com/76730484'),
      },
      {
        'icon': FontAwesomeIcons.paintBrush,
        'title': 'Emiliana Arias',
        'subtitle': 'Portfolio Website',
        'color': AppColors.accent,
        'action': () => _launchURL('https://www.emilianaarias.com/'),
      },
      {
        'icon': FontAwesomeIcons.screwdriverWrench,
        'title': 'Kraken Reparaciones',
        'subtitle': 'Business Website',
        'color': AppColors.accent,
        'action': () => _launchURL('https://krakenreparaciones.com/'),
      },
      {
        'icon': FontAwesomeIcons.video,
        'title': 'Punto Rojo Productora',
        'subtitle': 'Creative Production',
        'color': AppColors.accent,
        'action': () => _launchURL('https://www.puntorojoproductora.com.ar/'),
      },
      {
        'icon': FontAwesomeIcons.book,
        'title': 'Biblio Walsh',
        'subtitle': 'Digital Library',
        'color': AppColors.accent,
        'action': () => _launchURL('https://bibliowalsh.org/'),
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              languageProvider.translate('my_projects_creative_work'),
              style: GoogleFonts.orbitron(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ).animate().slideY(duration: Duration(milliseconds: 600)),
            SizedBox(height: 25),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth > 768 ? 2 : 1,
                childAspectRatio: 3.5,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                
                return GestureDetector(
                  onTap: project['action'] as VoidCallback,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppColors.border,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: (project['color'] as Color).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FaIcon(
                            project['icon'] as IconData,
                            color: project['color'] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                project['title'] as String,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: project['color'] as Color,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                project['subtitle'] as String,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: AppColors.muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FaIcon(
                          FontAwesomeIcons.upRightFromSquare,
                          color: project['color'] as Color,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ).animate().slideX(
                  duration: Duration(milliseconds: 600),
                  delay: Duration(milliseconds: 100 + (index * 50)),
                );
              },
            ),
          ],
        );
      },
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
