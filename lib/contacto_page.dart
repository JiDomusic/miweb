import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        final isEn = languageProvider.isEnglish;
        final screenSize = MediaQuery.of(context).size;
        final isDesktop = screenSize.width > 1024;

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
                      _buildContactMethods(isDesktop, isEn),
                      SizedBox(height: isDesktop ? 80 : 50),
                      _buildCreativeWork(isDesktop, isEn),
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
                isEn ? 'Contact' : 'Contacto',
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
          isEn ? 'Let\'s Connect' : 'Conectemos',
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
                ? 'Ready to start a project or have a question? Feel free to reach out through any of these channels.'
                : 'Listo para iniciar un proyecto o tienes alguna pregunta? No dudes en contactarme por cualquiera de estos canales.',
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

  Widget _buildContactMethods(bool isDesktop, bool isEn) {
    final methods = [
      {
        'icon': FontAwesomeIcons.whatsapp,
        'title': 'WhatsApp',
        'subtitle': isEn ? 'Quick response' : 'Respuesta rápida',
        'detail': '+34 133 63 551',
        'url': 'https://wa.me/3413363551',
      },
      {
        'icon': FontAwesomeIcons.envelope,
        'title': 'Email',
        'subtitle': isEn ? 'For detailed inquiries' : 'Para consultas detalladas',
        'detail': 'equiz.rec@gmail.com',
        'url': 'mailto:equiz.rec@gmail.com',
      },
      {
        'icon': FontAwesomeIcons.instagram,
        'title': 'Instagram',
        'subtitle': isEn ? 'Follow my work' : 'Sigue mi trabajo',
        'detail': '@jido_only',
        'url': 'https://www.instagram.com/jido_only',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEn ? 'Contact Methods' : 'Métodos de Contacto',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.muted,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        isDesktop
            ? Row(
                children: methods
                    .map((m) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: _contactCard(m),
                          ),
                        ))
                    .toList(),
              )
            : Column(
                children: methods
                    .map((m) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _contactCard(m),
                        ))
                    .toList(),
              ),
      ],
    );
  }

  Widget _contactCard(Map<String, dynamic> method) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(method['url']),
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
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.accentSoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FaIcon(
                      method['icon'] as IconData,
                      size: 20,
                      color: AppColors.ink,
                    ),
                  ),
                  const Icon(Icons.north_east, size: 16, color: AppColors.muted),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                method['title'],
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                method['subtitle'],
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                method['detail'],
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreativeWork(bool isDesktop, bool isEn) {
    final links = [
      {
        'icon': FontAwesomeIcons.youtube,
        'title': 'YouTube',
        'subtitle': isEn ? 'Music channel' : 'Canal de música',
        'url': 'https://www.youtube.com/@Jido_only',
      },
      {
        'icon': FontAwesomeIcons.bandcamp,
        'title': 'Bandcamp',
        'subtitle': isEn ? 'Music releases' : 'Lanzamientos',
        'url': 'https://jido.bandcamp.com/',
      },
      {
        'icon': FontAwesomeIcons.camera,
        'title': isEn ? 'Photography' : 'Fotografía',
        'subtitle': isEn ? 'Visual stories' : 'Historias visuales',
        'url': 'https://mariajimenadominguez.blogspot.com/?m=1',
      },
      {
        'icon': FontAwesomeIcons.vimeo,
        'title': isEn ? 'Documentary' : 'Documental',
        'subtitle': 'Vimeo',
        'url': 'https://vimeo.com/76730484',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEn ? 'Creative Work' : 'Trabajo Creativo',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.muted,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: links.map((link) => _creativeLink(link, isDesktop)).toList(),
        ),
      ],
    );
  }

  Widget _creativeLink(Map<String, dynamic> link, bool isDesktop) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(link['url']),
        child: Container(
          width: isDesktop ? 240 : double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              FaIcon(
                link['icon'] as IconData,
                size: 18,
                color: AppColors.ink,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      link['title'],
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                    Text(
                      link['subtitle'],
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.north_east, size: 14, color: AppColors.muted),
            ],
          ),
        ),
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
