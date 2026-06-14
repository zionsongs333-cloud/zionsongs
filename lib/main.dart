import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/theme_provider.dart';
import 'providers/language_provider.dart';
import 'providers/hymn_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/viewlist_provider.dart';
import 'providers/medley_provider.dart';
import 'config/app_router.dart';
import 'models/hymn_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  
  await Hive.initFlutter();
  Hive.registerAdapter(HymnModelAdapter());
  await Hive.openBox<HymnModel>('hymns');
  await Hive.openBox('favorites');
  await Hive.openBox('viewlists');
  await Hive.openBox('medleys');
 

  runApp(const ZionSongsApp());
}

class ZionSongsApp extends StatelessWidget {
  const ZionSongsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => HymnProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => ViewListProvider()),
        ChangeNotifierProvider(create: (_) => MedleyProvider()),
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, languageProvider, _) {
          return MaterialApp.router(
            title: 'Zion Songs',
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            locale: Locale(languageProvider.currentLanguage),
            supportedLocales: const [Locale('en'), Locale('hi')],
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
