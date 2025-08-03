import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:html' as html;

class ProyectosPage extends StatelessWidget {
  final List<Map<String, dynamic>> proyectos = [
    {
      'titulo': 'Emiliana Arias Portfolio',
      'descripcion': 'Professional portfolio website featuring modern design, responsive layout, and creative animations. Showcases artistic work with elegant presentation.',
      'tecnologias': ['Flutter Web', 'Responsive Design', 'UI/UX', 'Animation'],
      'url': 'https://www.emilianaarias.com/',
      'categoria': 'Portfolio',
      'color': Color(0xFFFF1493),
    },
    {
      'titulo': 'Kraken Reparaciones',
      'descripcion': 'Business website for electronics and appliance repair services. Features service catalog, contact forms, and business information presentation.',
      'tecnologias': ['Web Development', 'Business Solutions', 'Contact Forms'],
      'url': 'http://krakenrepaciones.com/',
      'categoria': 'Business',
      'color': Color(0xFF00FF00),
    },
    {
      'titulo': 'Punto Rojo Productora',
      'descripcion': 'Creative production company website showcasing audiovisual services, portfolio gallery, and company information with artistic flair.',
      'tecnologias': ['Creative Design', 'Web Development', 'Portfolio Gallery'],
      'url': 'https://www.puntorojoproductora.com.ar/',
      'categoria': 'Creative',
      'color': Color(0xFFFF1493),
    },
    {
      'titulo': 'Biblio Walsh',
      'descripcion': 'Digital library platform providing access to educational resources, book catalog, and academic materials with user-friendly interface.',
      'tecnologias': ['Digital Platform', 'Education Tech', 'Database Management'],
      'url': 'https://bibliowalsh.org/',
      'categoria': 'Education',
      'color': Color(0xFF00FF00),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1024;
    final crossAxisCount = isDesktop ? 3 : 2;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Projects',
          style: GoogleFonts.orbitron(
            color: Color(0xFFFF1493),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFFFF1493)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.grey[900]!,
              Colors.black,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Featured Projects',
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
                      'A showcase of my work as an independent developer and tech entrepreneur',
                      style: GoogleFonts.robotoMono(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ).animate().fadeIn(
                      duration: Duration(milliseconds: 800),
                      delay: Duration(milliseconds: 500),
                    ),
                  ],
                ),
              ),
              AnimationLimiter(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: isDesktop ? 1.8 : 1.3,
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
        ),
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> proyecto, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: proyecto['color'].withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: proyecto['color'].withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 3,
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
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    proyecto['titulo'],
                    style: GoogleFonts.orbitron(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: proyecto['color'],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    proyecto['descripcion'],
                    style: GoogleFonts.robotoMono(
                      fontSize: 12,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (proyecto['tecnologias'] as List<String>).map((tech) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          tech,
                          style: GoogleFonts.robotoMono(
                            fontSize: 11,
                            color: Colors.white60,
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
                          color: proyecto['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: proyecto['color'].withOpacity(0.3),
                          ),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.globe,
                          color: proyecto['color'],
                          size: 20,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _launchURL(proyecto['url']),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: proyecto['color'],
                          foregroundColor: Colors.black,
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
                              'View Live',
                              style: GoogleFonts.orbitron(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 8),
                            FaIcon(
                              FontAwesomeIcons.upRightFromSquare,
                              size: 12,
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
