import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';

class ProductsSection extends StatefulWidget {
  final bool isDesktop;
  final bool isEn;

  const ProductsSection({
    super.key,
    required this.isDesktop,
    required this.isEn,
  });

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  final _bellaColorController = PageController();
  final _reservasController = PageController();
  int _bellaColorPage = 0;
  int _reservasPage = 0;
  Timer? _bellaColorTimer;
  Timer? _reservasTimer;

  static const _whatsappBase = 'https://wa.me/3413363551';
  static const _instagramUrl = 'https://www.instagram.com/programacion_jj';
  static const _instagramReelUrl = 'https://www.instagram.com/reel/DWCBR1hEXZw/?igsh=MWhkcGtiZTdjYXJieA==';

  final _bellaColorImages = const [
    'assets/images/bellacolor_promo_new.jpg',
    'assets/images/bellacolor3.jpg',
    'assets/images/bellacolor2.jpg',
    'assets/images/bellacolor_vertical.png',
    'assets/images/barberia1.png',
    'assets/images/barberia2.png',
  ];

  final _reservasImages = const [
    'assets/images/reservas_logo.jpg',
    'assets/images/reservas_config.jpg',
    'assets/images/reservas_gratis.jpg',
    'assets/images/reservas_sodita.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _bellaColorTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_bellaColorController.hasClients) {
        final next = (_bellaColorPage + 1) % _bellaColorImages.length;
        _bellaColorController.animateToPage(next,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
    _reservasTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_reservasController.hasClients) {
        final next = (_reservasPage + 1) % _reservasImages.length;
        _reservasController.animateToPage(next,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _bellaColorTimer?.cancel();
    _reservasTimer?.cancel();
    _bellaColorController.dispose();
    _reservasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEn = widget.isEn;
    final isDesktop = widget.isDesktop;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 24,
        vertical: isDesktop ? 80 : 50,
      ),
      decoration: const BoxDecoration(
        color: AppColors.accentSoft,
        border: Border(
          top: BorderSide(color: AppColors.border),
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Text(
            isEn ? 'OUR PRODUCTS' : 'NUESTROS PRODUCTOS',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.muted,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isEn
                ? 'Ready-to-use solutions for your business'
                : 'Soluciones listas para tu negocio',
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 36 : 28,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
              letterSpacing: -1,
              height: 1.2,
            ),
          ),
          SizedBox(height: isDesktop ? 50 : 32),

          // Product cards
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildReservasCard(isDesktop, isEn)),
                    const SizedBox(width: 32),
                    Expanded(child: _buildBellaColorCard(isDesktop, isEn)),
                  ],
                )
              : Column(
                  children: [
                    _buildReservasCard(isDesktop, isEn),
                    const SizedBox(height: 32),
                    _buildBellaColorCard(isDesktop, isEn),
                  ],
                ),
        ],
      ),
    );
  }

  // ─── RESERVAS JJ ───────────────────────────────────────────

  Widget _buildReservasCard(bool isDesktop, bool isEn) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image carousel
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _reservasController,
                    onPageChanged: (i) =>
                        setState(() => _reservasPage = i),
                    itemCount: _reservasImages.length,
                    itemBuilder: (context, i) {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => _showImageDialog(_reservasImages[i]),
                          child: Image.asset(
                            _reservasImages[i],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      );
                    },
                  ),
                  // Dots indicator
                  Positioned(
                    bottom: 12,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _reservasImages.length,
                        (i) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: _reservasPage == i ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _reservasPage == i
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Navigation arrows
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(child: _carouselArrow(Icons.chevron_left, () {
                      _reservasController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    })),
                  ),
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(child: _carouselArrow(Icons.chevron_right, () {
                      _reservasController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    })),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53935).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    isEn ? 'Restaurants' : 'Restaurantes',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFE53935),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  'Reservas JJ',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isEn ? 'System made in Rosario' : 'Sistema hecho en Rosario',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.muted,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  isEn
                      ? 'Automatic reservation system for restaurants. Smart schedule management with remaining capacity control. Your customers book online, you manage everything from one place.'
                      : 'Sistema de reservas automático para restaurantes. Manejo inteligente de horarios con control de capacidad restante. Tus clientes reservan online, vos gestionás todo desde un solo lugar.',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: AppColors.muted,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),

                // Features
                _featureItem(Icons.schedule,
                    isEn ? 'Smart scheduling' : 'Horarios inteligentes'),
                _featureItem(Icons.people,
                    isEn ? 'Capacity management' : 'Gestión de capacidad'),
                _featureItem(
                    Icons.auto_awesome,
                    isEn
                        ? 'Automatic reservations'
                        : 'Reservas automáticas 24/7'),
                _featureItem(Icons.restaurant_menu,
                    isEn ? 'Digital menu' : 'Menú digital integrado'),
                _featureItem(Icons.color_lens,
                    isEn ? 'Your style, your brand' : 'Tu local, tu estilo'),
                _featureItem(Icons.chat,
                    isEn ? 'Integrated WhatsApp' : 'WhatsApp integrado'),

                const SizedBox(height: 24),

                // Link
                _buildProductLink(
                  'https://reserva-jj.web.app/',
                  'reserva-jj.web.app',
                  const Color(0xFFE53935),
                ),
                const SizedBox(height: 10),
                // Instagram
                _buildInstagramLink(),

                const SizedBox(height: 24),

                // Hecho en Argentina
                _buildMadeInArgentina(isEn),

                const SizedBox(height: 20),

                // CTA - 15 días gratis
                _buildFreeTrial(
                  isEn ? 'Try 15 days free' : 'Probá 15 días gratis',
                  isEn
                      ? 'Set up your schedules, manage capacity, and launch your restaurant online. Programación JJ will activate your link.'
                      : 'Tené la paciencia para configurar tus horarios, gestionar la capacidad y lanzar tu restaurante online. Programación JJ te activa el link.',
                  isEn
                      ? 'Hi! I want to try Reservas JJ free for 15 days'
                      : 'Hola! Quiero probar Reservas JJ por 15 días gratis',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── BELLA COLOR ───────────────────────────────────────────

  Widget _buildBellaColorCard(bool isDesktop, bool isEn) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image carousel
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _bellaColorController,
                    onPageChanged: (i) =>
                        setState(() => _bellaColorPage = i),
                    itemCount: _bellaColorImages.length,
                    itemBuilder: (context, i) {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => _showImageDialog(_bellaColorImages[i]),
                          child: Image.asset(
                            _bellaColorImages[i],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      );
                    },
                  ),
                  // Dots indicator
                  Positioned(
                    bottom: 12,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _bellaColorImages.length,
                        (i) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: _bellaColorPage == i ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _bellaColorPage == i
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Navigation arrows
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(child: _carouselArrow(Icons.chevron_left, () {
                      _bellaColorController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    })),
                  ),
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(child: _carouselArrow(Icons.chevron_right, () {
                      _bellaColorController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    })),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _productTag(
                      isEn ? 'Beauty Salons' : 'Salones de Belleza',
                      const Color(0xFFFFD600),
                      const Color(0xFFD4A800),
                    ),
                    _productTag(
                      isEn ? 'Barbershops' : 'Barberías',
                      AppColors.ink,
                      AppColors.ink,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  'Bella Color',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isEn ? 'System made in Rosario' : 'Sistema hecho en Rosario',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.muted,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  isEn
                      ? 'Appointment management for beauty salons and barbershops. Advance payments to avoid cancellations, automatic reminders, and confirmed appointments. Take care of every detail in your salon.'
                      : 'Gestión de citas para salones de belleza y barberías. Cobros anticipados para evitar cancelaciones, recordatorios automáticos y citas confirmadas. Cuidá cada detalle de tu salón.',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: AppColors.muted,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),

                // Features
                _featureItem(Icons.payment,
                    isEn ? 'Advance payments' : 'Cobros anticipados'),
                _featureItem(Icons.notifications_active,
                    isEn ? 'Automatic reminders' : 'Recordatorios automáticos'),
                _featureItem(Icons.event_available,
                    isEn ? 'Confirmed appointments' : 'Citas confirmadas'),
                _featureItem(Icons.content_cut,
                    isEn ? 'Men & women salons' : 'Salones masculinos y femeninos'),
                _featureItem(Icons.list_alt,
                    isEn ? 'Full service catalog' : 'Catálogo completo de servicios'),

                const SizedBox(height: 24),

                // Video container - Barberías
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEn ? 'Bella Color for Barbershops' : 'Bella Color para Barberías',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 10),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          // Open video in new tab
                          html.window.open('videos/bellacolor_masculino.mp4', '_blank');
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  'assets/images/barberia1.png',
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  color: Colors.black.withOpacity(0.35),
                                ),
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.play_arrow,
                                      size: 36,
                                      color: AppColors.ink,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 12,
                                  left: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      isEn ? 'Watch video' : 'Ver video',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Links
                _buildProductLink(
                  'https://bella-color.web.app/',
                  'bella-color.web.app',
                  const Color(0xFFD4A800),
                ),
                const SizedBox(height: 10),
                // Instagram reel
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _launchURL(_instagramReelUrl),
                    child: Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.instagram,
                            size: 14, color: Color(0xFFE1306C)),
                        const SizedBox(width: 8),
                        Text(
                          isEn ? 'Watch Reel' : 'Ver Reel',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFE1306C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildInstagramLink(),

                const SizedBox(height: 24),

                // Hecho en Argentina
                _buildMadeInArgentina(isEn),

                const SizedBox(height: 20),

                // CTA - 15 días gratis
                _buildFreeTrial(
                  isEn ? 'Try 15 days free' : 'Probá 15 días gratis',
                  isEn
                      ? 'List all your services and take care of every detail in your salon. Programación JJ will activate your link.'
                      : 'Desglosá todos tus servicios y cuidá cada detalle de tu salón. Programación JJ te activa el link.',
                  isEn
                      ? 'Hi! I want to try Bella Color free for 15 days'
                      : 'Hola! Quiero probar Bella Color por 15 días gratis',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── SHARED WIDGETS ────────────────────────────────────────

  Widget _featureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFFD4A800)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.ink,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productTag(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _carouselArrow(IconData icon, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
              ),
            ],
          ),
          child: Icon(icon, size: 20, color: AppColors.ink),
        ),
      ),
    );
  }

  Widget _buildInstagramLink() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(_instagramUrl),
        child: Row(
          children: [
            const FaIcon(FontAwesomeIcons.instagram,
                size: 14, color: Color(0xFFE1306C)),
            const SizedBox(width: 8),
            Text(
              '@programacion_jj',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFE1306C),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductLink(String url, String label, Color color) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(url),
        child: Row(
          children: [
            Icon(Icons.link, size: 16, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
                decoration: TextDecoration.underline,
                decorationColor: color,
              ),
            ),
            const SizedBox(width: 6),
            Icon(Icons.arrow_outward, size: 14, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildFreeTrial(
      String title, String description, String waMessage) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF25D366), Color(0xFF128C7E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.white.withOpacity(0.9),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _launchURL(
                '$_whatsappBase?text=${Uri.encodeComponent(waMessage)}',
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(FontAwesomeIcons.whatsapp,
                        size: 20, color: Color(0xFF25D366)),
                    const SizedBox(width: 10),
                    Text(
                      widget.isEn
                          ? 'Subscribe via WhatsApp'
                          : 'Suscribite por WhatsApp',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF25D366),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              widget.isEn
                  ? 'Programación JJ will activate your link and help you with onboarding'
                  : 'Programación JJ te activa el link y te ayuda con el onboarding',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: Colors.white.withOpacity(0.75),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMadeInArgentina(bool isEn) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🇦🇷', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Text(
            isEn ? 'Made in Argentina' : 'Hecho en Argentina',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 10),
          const Text('🇦🇷', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  void _showImageDialog(String imagePath) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (ctx) => GestureDetector(
        onTap: () => Navigator.of(ctx).pop(),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => Navigator.of(ctx).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, size: 24, color: AppColors.ink),
                  ),
                ),
              ),
            ),
          ],
        ),
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
