class Translations {
  static const Map<String, Map<String, String>> _translations = {
    'en': {
      // Navigation & General
      'home': 'Home',
      'projects': 'Projects',
      'contact': 'Contact',
      'get_in_touch': 'Get In Touch',
      'my_projects': 'My Projects',

      // Home Page
      'independent_tech_entrepreneur': 'Independent Tech Entrepreneur & Full-Stack Developer',
      'developer': 'DEVELOPER',
      'more_projects': 'More Projects',
      'whatsapp': 'WhatsApp',
      'crafted_with_flutter': '© 2026 Programación JJ. Crafted with Flutter 💙',

      // Pricing Section
      'pricing': 'Pricing',
      'hourly_work': 'Hourly Work',
      'hour': '/hour',
      'maintenance': 'Maintenance',
      'month': '/month',
      'custom_system': 'Custom System',
      'quote': 'Quote',
      'request_quote': 'Request Quote',

      // Projects Page
      'featured_projects': 'Featured Projects',
      'showcase_description': 'A showcase of my work as an independent developer and tech entrepreneur',
      'view_live': 'View Live',
      'current_projects': 'Current Projects',
      'in_development': 'In Dev',

      // Categories
      'portfolio': 'Portfolio',
      'business': 'Business',
      'creative': 'Creative',
      'education': 'Education',
      'kids_app': 'Kids App',
      'beauty_salons': 'Beauty & Salons',
      'food_service': 'Food Service',
      'finance': 'Finance',

      // Technologies
      'flutter_web': 'Flutter Web',
      'responsive_design': 'Responsive Design',
      'ui_ux': 'UI/UX',
      'animation': 'Animation',
      'web_development': 'Web Development',
      'business_solutions': 'Business Solutions',
      'contact_forms': 'Contact Forms',
      'creative_design': 'Creative Design',
      'portfolio_gallery': 'Portfolio Gallery',
      'digital_platform': 'Digital Platform',
      'education_tech': 'Education Tech',
      'database_management': 'Database Management',
      'interactive_learning': 'Interactive Learning',
      'child_education': 'Child Education',
      'gamification': 'Gamification',
      'accessibility': 'Accessibility',
      'social_connection': 'Social Connection',
      'inclusive_design': 'Inclusive Design',
      'realtime': 'Real-time',
      'payments': 'Payments',
      'supabase': 'Supabase',
      'firebase': 'Firebase',
      'webview': 'WebView',

      // Contact Page
      'lets_connect': 'Let\'s Connect',
      'ready_to_collaborate': 'Ready to start a project or have a question? Feel free to reach out through any of these channels.',
      'contact_methods': 'Contact Methods',
      'quick_response': 'Quick response',
      'for_detailed_inquiries': 'For detailed inquiries',
      'follow_my_work': 'Follow my work',

      // Language
      'language': 'Language',
      'english': 'English',
      'spanish': 'Español',
    },
    'es': {
      // Navigation & General
      'home': 'Inicio',
      'projects': 'Proyectos',
      'contact': 'Contacto',
      'get_in_touch': 'Contacto',
      'my_projects': 'Mis Proyectos',

      // Home Page
      'independent_tech_entrepreneur': 'Emprendedor Tecnológico Independiente y Desarrollador Full-Stack',
      'developer': 'DESARROLLADOR',
      'more_projects': 'Más Proyectos',
      'whatsapp': 'WhatsApp',
      'crafted_with_flutter': '© 2026 Programación JJ. Creado con Flutter 💙',

      // Pricing Section
      'pricing': 'Precios',
      'hourly_work': 'Trabajo por Hora',
      'hour': '/hora',
      'maintenance': 'Mantenimiento',
      'month': '/mes',
      'custom_system': 'Sistema a Medida',
      'quote': 'Consultar',
      'request_quote': 'Solicitar Presupuesto',

      // Projects Page
      'featured_projects': 'Proyectos Destacados',
      'showcase_description': 'Una muestra de mi trabajo como desarrollador independiente y emprendedor tecnológico',
      'view_live': 'Ver en Vivo',
      'current_projects': 'Proyectos Actuales',
      'in_development': 'En Dev',

      // Categories
      'portfolio': 'Portafolio',
      'business': 'Negocio',
      'creative': 'Creativo',
      'education': 'Educación',
      'kids_app': 'App Infantil',
      'beauty_salons': 'Belleza & Salones',
      'food_service': 'Servicios de Comida',
      'finance': 'Finanzas',

      // Technologies
      'flutter_web': 'Flutter Web',
      'responsive_design': 'Diseño Responsivo',
      'ui_ux': 'UI/UX',
      'animation': 'Animación',
      'web_development': 'Desarrollo Web',
      'business_solutions': 'Soluciones Empresariales',
      'contact_forms': 'Formularios de Contacto',
      'creative_design': 'Diseño Creativo',
      'portfolio_gallery': 'Galería de Portafolio',
      'digital_platform': 'Plataforma Digital',
      'education_tech': 'Tecnología Educativa',
      'database_management': 'Gestión de Base de Datos',
      'interactive_learning': 'Aprendizaje Interactivo',
      'child_education': 'Educación Infantil',
      'gamification': 'Gamificación',
      'accessibility': 'Accesibilidad',
      'social_connection': 'Conexión Social',
      'inclusive_design': 'Diseño Inclusivo',
      'realtime': 'Tiempo Real',
      'payments': 'Pagos',
      'supabase': 'Supabase',
      'firebase': 'Firebase',
      'webview': 'WebView',

      // Contact Page
      'lets_connect': 'Conectemos',
      'ready_to_collaborate': '¿Listo para iniciar un proyecto o tienes alguna pregunta? No dudes en contactarme a través de cualquiera de estos canales.',
      'contact_methods': 'Métodos de Contacto',
      'quick_response': 'Respuesta rápida',
      'for_detailed_inquiries': 'Para consultas detalladas',
      'follow_my_work': 'Sigue mi trabajo',

      // Language
      'language': 'Idioma',
      'english': 'English',
      'spanish': 'Español',
    },
  };

  static String get(String key, String languageCode) {
    return _translations[languageCode]?[key] ?? _translations['en']?[key] ?? key;
  }

  static List<String> getSupportedLanguages() {
    return _translations.keys.toList();
  }
}