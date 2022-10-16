import 'package:flutter_modular/flutter_modular.dart';
import 'package:posterr/modules/home/presenter/home.page.dart';

/// It's the main App module. Each module should have your binds (dependencys) and routes
class MainModule extends Module {

  // Dependency injection 
  @override
  List<Bind<Object>> get binds => [];

  // Main Routes: All the App Mobules routes
  @override
  List<ModularRoute> get routes => [
    // App Initial Route 
    ChildRoute('/', child: (context, args) => const HomePage()),
    // Modules Routes
  ];
}