import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/supabase_config.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'storage/cache/hive_config.dart';
import 'storage/database/app_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize Hive cache
  await HiveConfig.initialize();

  // 2. Initialize SQLite Database
  await AppDatabase.database;

  // 3. Initialize Supabase (with graceful offline fallback)
  await SupabaseConfig.initialize();

  runApp(
    const ProviderScope(
      child: NenilApp(),
    ),
  );
}

class NenilApp extends StatelessWidget {
  const NenilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nenil',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
