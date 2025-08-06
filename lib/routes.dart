import 'package:flutter/material.dart';
import 'package:miweb/proyectos_page.dart';
import 'contacto_page.dart';
import 'home_page.dart';


final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomePage(),
  '/proyectos': (context) => const ProyectosPage(),
  '/contacto': (context) => const ContactoPage(),
};
