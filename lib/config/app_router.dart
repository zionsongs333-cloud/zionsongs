import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/hymn_detail_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/settings_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/hymn/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final hymnsList = state.extra as List<Map<String, String>>; // <-- GET LIST FROM EXTRA
          return HymnDetailScreen(
  hymnId: id,
  hymnsList: state.extra as List<Map<String, String>>,
  currentUserRole: 'Admin',
);
        },
      ),
      GoRoute(
        path: '/favorites',
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}