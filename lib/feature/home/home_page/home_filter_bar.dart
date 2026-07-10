import 'package:flutter/material.dart';

/// ===============================================================
/// HomeFilterBar
/// ---------------------------------------------------------------
///
/// Displays the Home page filters.
///
/// OFFLINE FIRST
/// ---------------------------------------------------------------
/// UI ONLY.
/// No Firestore.
/// No Isar.
/// No Repository.
///
/// Multi-select popup is opened by the callbacks.
///
/// Filters
/// --------
/// • Key
/// • Dedicated
/// • Year
/// • Beat
///
/// Reset button always visible.
/// ===============================================================
class HomeFilterBar extends StatelessWidget {
  const HomeFilterBar({
    super.key,

    required this.keyLabel,
    required this.dedicatedLabel,
    required this.yearLabel,
    required this.beatLabel,

    this.keySelected = 0,
    this.dedicatedSelected = 0,
    this.yearSelected = 0,
    this.beatSelected = 0,

    this.onKeyTap,
    this.onDedicatedTap,
    this.onYearTap,
    this.onBeatTap,
    this.onReset,
  });

  /// Display text

  final String keyLabel;
  final String dedicatedLabel;
  final String yearLabel;
  final String beatLabel;

  /// Number of selected items

  final int keySelected;
  final int dedicatedSelected;
  final int yearSelected;
  final int beatSelected;

  /// Callbacks

  final VoidCallback? onKeyTap;
  final VoidCallback? onDedicatedTap;
  final VoidCallback? onYearTap;
  final VoidCallback? onBeatTap;
  final VoidCallback? onReset;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 6,
        ),
        child: Row(
          children: [

            Expanded(
              child: _filterButton(
                label: keyLabel,
                count: keySelected,
                icon: Icons.music_note_outlined,
                onPressed: onKeyTap,
              ),
            ),

            const SizedBox(width: 6),

            Expanded(
              child: _filterButton(
                label: dedicatedLabel,
                count: dedicatedSelected,
                icon: Icons.favorite_border,
                onPressed: onDedicatedTap,
              ),
            ),

            const SizedBox(width: 6),

            Expanded(
              child: _filterButton(
                label: yearLabel,
                count: yearSelected,
                icon: Icons.calendar_today_outlined,
                onPressed: onYearTap,
              ),
            ),

            const SizedBox(width: 6),

            Expanded(
              child: _filterButton(
                label: beatLabel,
                count: beatSelected,
                icon: Icons.multitrack_audio_outlined,
                onPressed: onBeatTap,
              ),
            ),

            const SizedBox(width: 8),

            OutlinedButton.icon(
              onPressed: onReset,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterButton({
    required String label,
    required int count,
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(
        count == 0
            ? label
            : '$label ($count)',
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}