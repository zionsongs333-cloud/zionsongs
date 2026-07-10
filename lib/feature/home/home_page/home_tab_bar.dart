import 'package:flutter/material.dart';

import '../home_models.dart';
/// ===============================================================
/// HomeTabBar
/// ---------------------------------------------------------------
///
/// Primary navigation of the Home page.
///
/// RESPONSIBILITY
/// • Display the four permanent hymn collections.
/// • Notify parent when the selected tab changes.
/// • UI only.
/// • No Firestore.
/// • No Isar.
/// • No SyncQueue.
/// • No business logic.
///
/// OFFLINE FIRST
/// Selected tab comes from HomeState.
/// This widget never stores state.
/// ===============================================================
class HomeTabBar extends StatelessWidget {
  const HomeTabBar({
    super.key,
    required this.currentTab,
    required this.onChanged,
  });

  final HomeTab currentTab;
  final ValueChanged<HomeTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: SizedBox(
        height: 52,
        child: Row(
          children: [
            _tab(
              context,
              HomeTab.allHymns,
              'All Hymns',
              Icons.library_music_outlined,
            ),
            _tab(
              context,
              HomeTab.favorites,
              'Favorites',
              Icons.star_border,
            ),
            _tab(
              context,
              HomeTab.viewLists,
              'View Lists',
              Icons.folder_outlined,
            ),
            _tab(
              context,
              HomeTab.medleys,
              'Medleys',
              Icons.queue_music_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab(
    BuildContext context,
    HomeTab tab,
    String title,
    IconData icon,
  ) {
    final selected = currentTab == tab;

    return Expanded(
      child: InkWell(
        onTap: () => onChanged(tab),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 3,
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: selected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}