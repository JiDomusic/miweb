import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;
import 'language_provider.dart';
import 'widgets/language_toggle.dart';
import 'theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _whatsappNumber = '+34 133 63 551';
  static const _whatsappUrl = 'https://wa.me/3413363551';
  static const _demoUrl = 'https://soditaweb.web.app/';

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final screenSize = MediaQuery.of(context).size;
        final isDesktop = screenSize.width > 1024;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            title: Text(
              'mi web',
              style: GoogleFonts.playfairDisplay(
                color: AppColors.ink,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 24),
                child: LanguageToggle(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 120 : 24,
              vertical: isDesktop ? 48 : 28,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHero(isDesktop),
                const SizedBox(height: 48),
                _buildWhyWeb(isDesktop),
                const SizedBox(height: 48),
                _buildProjectsPreview(context, isDesktop),
                const SizedBox(height: 48),
                _buildArtistSection(isDesktop),
                const SizedBox(height: 72),
                _buildFooter(context, isDesktop),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHero(bool isDesktop) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cuando todo se apaga, tu web sigue vendiendo.',
          style: GoogleFonts.playfairDisplay(
            fontSize: isDesktop ? 48 : 32,
            fontWeight: FontWeight.w600,
            color: AppColors.ink,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Creo sitios blancos, veloces y con un mensaje brutalmente claro. Un búnker digital con un botón directo a tu WhatsApp.',
          style: GoogleFonts.inter(
            fontSize: isDesktop ? 18 : 16,
            fontWeight: FontWeight.w400,
            color: AppColors.muted,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            _pill('Entrega en 72h'),
            _pill('Copy que convierte'),
            _pill('Listo para móvil'),
            _pill('Hosting + SEO técnico'),
          ],
        ),
      ],
    );

    final cta = Container(
      width: isDesktop ? 260 : double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accentSoft.withOpacity(0.35),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.accent),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bolt, color: AppColors.accent, size: 18),
              const SizedBox(width: 8),
              Text(
                'Contacto inmediato',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _whatsappNumber,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 10),
          _whatsappButton(primary: true),
          const SizedBox(height: 10),
          _demoButton(),
        ],
      ),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isDesktop ? 48 : 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: content),
                const SizedBox(width: 24),
                cta,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                content,
                const SizedBox(height: 18),
                cta,
              ],
            ),
    );
  }

  Widget _pill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }

  Widget _whatsappButton({required bool primary}) {
    return ElevatedButton.icon(
      onPressed: () => _launchURL(_whatsappUrl),
      style: ElevatedButton.styleFrom(
        backgroundColor: primary ? AppColors.ink : Colors.white,
        foregroundColor: primary ? Colors.white : AppColors.ink,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: primary ? Colors.transparent : AppColors.border),
        ),
        elevation: 0,
      ),
      icon: const Icon(FontAwesomeIcons.whatsapp, size: 16, color: AppColors.whatsapp),
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hablar por WhatsApp',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: primary ? Colors.white : AppColors.ink,
            ),
          ),
          Text(
            _whatsappNumber,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: primary ? Colors.white70 : AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _demoButton() {
    return OutlinedButton.icon(
      onPressed: () => _launchURL(_demoUrl),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        side: const BorderSide(color: AppColors.accent),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: const Icon(Icons.travel_explore_outlined, color: AppColors.accent, size: 18),
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ver demo en trayecto',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          Text(
            _demoUrl,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyWeb(bool isDesktop) {
    final reasons = [
      {
        'title': 'Mensaje de choque',
        'desc': 'Copy directo que promete y mueve a acción con un CTA a WhatsApp.',
      },
      {
        'title': 'Arquitectura mínima',
        'desc': 'Todo blanco, rápido y enfocado. Ideal para móvil y con SEO técnico.',
      },
      {
        'title': 'Entrega express',
        'desc': 'Kickoff hoy, versión lista en 72h y checklist de lanzamiento.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '¿Por qué ahora?',
          style: GoogleFonts.playfairDisplay(
            fontSize: isDesktop ? 32 : 26,
            fontWeight: FontWeight.w600,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: reasons
              .map(
                (r) => Container(
                  width: isDesktop ? 260 : double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.auto_awesome, color: AppColors.accent, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            r['title']!,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.ink,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        r['desc']!,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.muted,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildProjectsPreview(BuildContext context, bool isDesktop) {
    final projects = [
      {
        'title': 'SODITA',
        'subtitle': 'Sistema de reservas gastronómico',
        'url': 'https://reservasodita.web.app/',
      },
      {
        'title': 'Kraken Reparaciones',
        'subtitle': 'Sitio de servicios técnicos con CTA directo',
        'url': 'https://krakenreparaciones.com/',
      },
      {
        'title': 'Ciudad de Letras',
        'subtitle': 'Plataforma literaria digital',
        'url': 'https://ciudaddeletras-97276.web.app/',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Proyectos que resisten',
              style: GoogleFonts.playfairDisplay(
                fontSize: isDesktop ? 32 : 26,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () => Navigator.of(context).pushNamed('/proyectos'),
              icon: const Icon(Icons.north_east, size: 16, color: AppColors.accent),
              label: Text(
                'Ver todos',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: projects
              .map(
                (p) => _projectCard(
                  title: p['title']!,
                  subtitle: p['subtitle']!,
                  url: p['url']!,
                  isDesktop: isDesktop,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _projectCard({
    required String title,
    required String subtitle,
    required String url,
    required bool isDesktop,
  }) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Container(
        width: isDesktop ? 300 : double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.accentSoft.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.launch, color: AppColors.accent, size: 18),
                ),
                const Spacer(),
                const Icon(Icons.north_east, size: 16, color: AppColors.muted),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.muted,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArtistSection(bool isDesktop) {
    final links = [
      {
        'title': 'YouTube',
        'subtitle': '@Jido_only',
        'url': 'https://www.youtube.com/@Jido_only',
        'icon': FontAwesomeIcons.youtube,
      },
      {
        'title': 'Bandcamp',
        'subtitle': 'Releases & mixes',
        'url': 'https://jido.bandcamp.com/',
        'icon': FontAwesomeIcons.bandcamp,
      },
      {
        'title': 'Fotografía',
        'subtitle': 'Visual blog',
        'url': 'https://mariajimenadominguez.blogspot.com/?m=1',
        'icon': FontAwesomeIcons.camera,
      },
      {
        'title': 'Documental',
        'subtitle': 'Vimeo',
        'url': 'https://vimeo.com/76730484',
        'icon': FontAwesomeIcons.vimeo,
      },
    ];

    return Container(
          width: double.infinity,
          padding: EdgeInsets.all(isDesktop ? 36 : 22),
          decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Artista & productor',
            style: GoogleFonts.playfairDisplay(
              fontSize: isDesktop ? 28 : 24,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Música, visuales y relatos que acompañan la misma energía minimalista.',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.muted,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: links
                .map(
                  (link) => ActionChip(
                    avatar: FaIcon(
                      link['icon'] as IconData,
                      size: 14,
                      color: AppColors.accent,
                    ),
                    label: Text(
                      '${link['title']} · ${link['subtitle']}',
                      style: GoogleFonts.inter(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.border),
                    onPressed: () => _launchURL(link['url'] as String),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: AppColors.border),
        const SizedBox(height: 18),
        Text(
          'Listo para tener tu búnker digital.',
          style: GoogleFonts.playfairDisplay(
            fontSize: isDesktop ? 24 : 20,
            fontWeight: FontWeight.w600,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Envíame un audio por WhatsApp y te devuelvo un esquema y copy demo en menos de 24 horas.',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.muted,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _whatsappButton(primary: true),
            const SizedBox(width: 12),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/contacto'),
              child: Text(
                'Ir a contacto',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          '© 2025 — construido en Flutter',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.muted,
          ),
        ),
      ],
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
