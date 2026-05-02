import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import '../language_provider.dart';

class ContactoForm extends StatefulWidget {
  const ContactoForm({super.key});

  @override
  _ContactoFormState createState() => _ContactoFormState();
}

class _ContactoFormState extends State<ContactoForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final isEn = Provider.of<LanguageProvider>(context, listen: false).isEnglish;

      setState(() {
        _isLoading = true;
      });

      try {
        await FirebaseFirestore.instance.collection('contactos').add({
          'nombre': _nameController.text,
          'email': _emailController.text,
          'mensaje': _messageController.text,
          'fecha': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEn ? 'Message sent successfully!' : '¡Mensaje enviado exitosamente!',
              style: GoogleFonts.inter(color: Colors.white),
            ),
            backgroundColor: AppColors.accent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );

        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEn ? 'Error sending message. Please try again.' : 'Error al enviar el mensaje. Por favor intenta de nuevo.',
              style: GoogleFonts.inter(color: Colors.white),
            ),
            backgroundColor: AppColors.ink,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isEn = languageProvider.isEnglish;

        return Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: _nameController,
                label: isEn ? 'Full Name' : 'Nombre Completo',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return isEn ? 'Please enter your name' : 'Por favor ingresa tu nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              _buildTextField(
                controller: _emailController,
                label: isEn ? 'Email Address' : 'Correo Electrónico',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return isEn ? 'Please enter your email' : 'Por favor ingresa tu correo';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return isEn ? 'Please enter a valid email' : 'Por favor ingresa un correo válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              _buildTextField(
                controller: _messageController,
                label: isEn ? 'Your Message' : 'Tu Mensaje',
                icon: Icons.message_outlined,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return isEn ? 'Please enter your message' : 'Por favor ingresa tu mensaje';
                  }
                  if (value.length < 10) {
                    return isEn ? 'Message must be at least 10 characters' : 'El mensaje debe tener al menos 10 caracteres';
                  }
                  return null;
                },
              ),
              SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ink,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                    shadowColor: AppColors.ink.withOpacity(0.1),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          isEn ? 'Send Message' : 'Enviar Mensaje',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ).animate().slideY(
                duration: Duration(milliseconds: 600),
                delay: Duration(milliseconds: 800),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: GoogleFonts.inter(
          color: AppColors.ink,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(
            color: AppColors.muted,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.accent,
          ),
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.border,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.border,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.accent,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Color(0xFFFF1493),
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Color(0xFFFF1493),
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: maxLines > 1 ? 20 : 16,
          ),
          errorStyle: GoogleFonts.robotoMono(
            color: Color(0xFFFF1493),
            fontSize: 12,
          ),
        ),
      ),
    ).animate().slideX(
      duration: Duration(milliseconds: 600),
      delay: Duration(milliseconds: 200),
    );
  }
}
