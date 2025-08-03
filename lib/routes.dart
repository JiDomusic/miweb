import 'package:flutter/material.dart';
import 'package:miweb/proyectos_page.dart';
import 'contacto_page.dart';
import 'home_page.dart';


final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => HomePage(),
  '/proyectos': (context) => ProyectosPage(),
  '/contacto': (context) => ContactoPage(),
};
