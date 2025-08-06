import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/contacto_form.dart';
import 'dart:html' as html;

class ContactoPage extends StatelessWidget {
  const ContactoPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1024;
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Get In Touch',
          style: GoogleFonts.orbitron(
            color: Color(0xFF00FF00),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFF00FF00)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
              _buildHeader(isDesktop),
              SizedBox(height: 40),
              screenSize.width > 768
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 1, child: _buildContactInfo()),
                      SizedBox(width: 40),
                      Expanded(flex: 2, child: _buildContactForm()),
                    ],
                  )
                : Column(
                    children: [
                      _buildContactInfo(),
                      SizedBox(height: 30),
                      _buildContactForm(),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Let\'s Create Something Amazing',
          style: GoogleFonts.orbitron(
            fontSize: isDesktop ? 36 : 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00FF00),
          ),
        ).animate().slideX(duration: Duration(milliseconds: 600)),
        SizedBox(height: 10),
        Container(
          height: 3,
          width: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00FF00), Color(0xFFFF1493)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ).animate().scaleX(
          duration: Duration(milliseconds: 800),
          delay: Duration(milliseconds: 300),
        ),
        SizedBox(height: 20),
        Text(
          'Ready to bring your ideas to life? Whether you need a stunning website, mobile app, or want to collaborate on a music project, I\'m here to help.',
          style: GoogleFonts.robotoMono(
            fontSize: 16,
            color: Colors.white70,
            height: 1.6,
          ),
        ).animate().fadeIn(
          duration: Duration(milliseconds: 800),
          delay: Duration(milliseconds: 500),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    final contactMethods = [
      {
        'icon': FontAwesomeIcons.envelope,
        'title': 'Email',
        'subtitle': 'Contact me directly',
        'color': Color(0xFFFF1493),
        'action': () => _launchURL('mailto:equiz.rec@gmail.com'),
      },
      {
        'icon': FontAwesomeIcons.youtube,
        'title': 'YouTube Music',
        'subtitle': 'Jido_only',
        'color': Color(0xFF00FF00),
        'action': () => _launchURL('https://www.youtube.com/@Jido_only'),
      },
      {
        'icon': FontAwesomeIcons.instagram,
        'title': 'Instagram',
        'subtitle': '@jido_only',
        'color': Color(0xFFFF1493),
        'action': () => _launchURL('https://www.instagram.com/jido_only'),
      },
      {
        'icon': FontAwesomeIcons.globe,
        'title': 'Emiliana Arias',
        'subtitle': 'Portfolio Website',
        'color': Color(0xFFFF1493),
        'action': () => _launchURL('https://www.emilianaarias.com/'),
      },
      {
        'icon': FontAwesomeIcons.tools,
        'title': 'Kraken Reparaciones',
        'subtitle': 'Business Website',
        'color': Color(0xFF00FF00),
        'action': () => _launchURL('https://krakenreparaciones.com/'),
      },
      {
        'icon': FontAwesomeIcons.video,
        'title': 'Punto Rojo Productora',
        'subtitle': 'Creative Production',
        'color': Color(0xFFFF1493),
        'action': () => _launchURL('https://www.puntorojoproductora.com.ar/'),
      },
      {
        'icon': FontAwesomeIcons.book,
        'title': 'Biblio Walsh',
        'subtitle': 'Digital Library',
        'color': Color(0xFF00FF00),
        'action': () => _launchURL('https://bibliowalsh.org/'),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: GoogleFonts.orbitron(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF1493),
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
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: (method['color'] as Color).withOpacity(0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (method['color'] as Color).withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (method['color'] as Color).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FaIcon(
                        method['icon'] as IconData,
                        color: method['color'] as Color,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            method['title'] as String,
                            style: GoogleFonts.orbitron(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: method['color'] as Color,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            method['subtitle'] as String,
                            style: GoogleFonts.robotoMono(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).animate().slideX(
            duration: Duration(milliseconds: 600),
            delay: Duration(milliseconds: 200 + (index * 100)),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF00FF00).withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00FF00).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send a Message',
            style: GoogleFonts.orbitron(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00FF00),
            ),
          ),
          SizedBox(height: 25),
          ContactoForm(),
        ],
      ),
    ).animate().slideY(
      duration: Duration(milliseconds: 800),
      delay: Duration(milliseconds: 400),
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
