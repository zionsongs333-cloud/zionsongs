import 'package:flutter/material.dart';

import '../app_bar/home_selection_controller.dart';

/// ===============================================================
/// HomeHymnTile
/// ---------------------------------------------------------------
///
/// Displays ONE hymn in the Home page list.
///
/// OFFLINE FIRST
/// ---------------------------------------------------------------
/// UI only.
/// Never talks to:
/// • Firestore
/// • Isar
/// • Repository
/// • SyncQueue
///
/// It only reflects the data passed to it.
///
/// Layout
///
/// ✓  Sr No
/// ✓  Title
/// ✓  Favorite
/// ✓  Page No
///
/// Long Press
/// ----------
/// Select hymn.
///
/// Tap
/// ---
/// • Open Hymn when not in selection mode.
/// • Toggle selection when selection mode is active.
/// ===============================================================
class HomeHymnTile extends StatelessWidget {
  const HomeHymnTile({
    super.key,
    required this.hymnId,
    required this.serialNo,
    required this.title,
    required this.pageNo,
    required this.isFavorite,
    required this.selectionController,
    this.onOpen,
  });

  final String hymnId;
  final String serialNo;
  final String title;
  final String pageNo;
  final bool isFavorite;

  final HomeSelectionController selectionController;

  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final selected = selectionController.isSelected(hymnId);

    return Material(
      color: selected
          ? Theme.of(context)
              .colorScheme
              .primaryContainer
          : Colors.transparent,
      child: InkWell(
        onTap: () {
          if (selectionController.hasSelection) {
            selectionController.toggle(hymnId);
          } else {
            onOpen?.call();
          }
        },
        onLongPress: () {
          selectionController.select(hymnId);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          child: Row(
            children: [

              //----------------------------------------------------
              // Selection Indicator
              //----------------------------------------------------

              SizedBox(
                width: 28,
                child: selected
                    ? const Icon(
                        Icons.check_circle,
                        size: 20,
                      )
                    : const Icon(
                        Icons.radio_button_unchecked,
                        size: 20,
                      ),
              ),

              //----------------------------------------------------
              // Serial Number
              //----------------------------------------------------

              SizedBox(
                width: 55,
                child: Text(
                  serialNo,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              //----------------------------------------------------
              // Title
              //----------------------------------------------------

              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              //----------------------------------------------------
              // Favorite
              //----------------------------------------------------

              SizedBox(
                width: 36,
                child: Icon(
                  isFavorite
                      ? Icons.star
                      : Icons.star_border,
                ),
              ),

              //----------------------------------------------------
              // Page Number
              //----------------------------------------------------

              SizedBox(
                width: 55,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(pageNo),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}