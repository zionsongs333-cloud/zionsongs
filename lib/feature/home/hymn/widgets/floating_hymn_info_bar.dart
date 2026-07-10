import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../hymn_models.dart';
import '../hymn_pin_button.dart';
import '../hymn_transpose_button.dart';
import '../hymn_preferences_button.dart';
import '../hymn_transpose_logic.dart';
import '../hymn_preferences_logic.dart';
import '../hymn_auth_service.dart';

class FloatingHymnInfoBar extends StatefulWidget {
  final LocalHymn hymn;
  final Isar isar;
  final bool pinned;
  final VoidCallback onChanged;
  final VoidCallback onToggleChords;
  final VoidCallback onNotepadTapped;
  final VoidCallback onEditOpened;

  const FloatingHymnInfoBar({
    super.key,
    required this.hymn,
    required this.isar,
    required this.pinned,
    required this.onChanged,
    required this.onToggleChords,
    required this.onNotepadTapped,
    required this.onEditOpened,
  });

  @override
  State<FloatingHymnInfoBar> createState() => _FloatingHymnInfoBarState();
}

class _FloatingHymnInfoBarState extends State<FloatingHymnInfoBar> {
  UserHymnPref? _pref;
  String? _detectedKey;
  int _noteCount = 0;
  int _errorCount = 0;
  List<String> _styles = [];

  @override
  void initState() {
    super.initState();
    _loadDetails();
    HymnPreferencesLogic.getStyles().then((s) => mounted ? setState(() => _styles = s) : null);
  }

  Future<void> _loadDetails() async {
    final existingPref = await widget.isar.userHymnPrefs
        .filter()
        .hymnIdEqualTo(widget.hymn.hymnId)
        .userIdEqualTo(AuthService.userId)
        .findFirst();

    if (existingPref != null) {
      _pref = existingPref;
    } else {
      _pref = UserHymnPref()
        ..hymnId = widget.hymn.hymnId
        ..userId = AuthService.userId;
      await widget.isar.writeTxn(() => widget.isar.userHymnPrefs.put(_pref!));
    }

    _detectedKey = HymnTransposeLogic.detectKey(widget.hymn.originalLyrics);
    await _refreshBadge();
    if (mounted) setState(() {});
  }

  Future<void> _refreshBadge() async {
    final count = await widget.isar.userNotes
        .filter()
        .hymnIdEqualTo(widget.hymn.hymnId)
        .userIdEqualTo(AuthService.userId)
        .count();
    var errors = await widget.isar.userNotes
        .filter()
        .hymnIdEqualTo(widget.hymn.hymnId)
        .userIdEqualTo(AuthService.userId)
        .syncStatusEqualTo(SyncStatus.error)
        .count();
    errors += await widget.isar.editProposals
        .filter()
        .hymnIdEqualTo(widget.hymn.hymnId)
        .userIdEqualTo(AuthService.userId)
        .syncStatusEqualTo(SyncStatus.error)
        .count();
    if (mounted) {
      setState(() {
        _noteCount = count;
        _errorCount = errors;
      });
    }
  }

  Future<void> _onChanged() async {
    await _refreshBadge();
    widget.onChanged();
  }

  Future<void> _togglePin() async {
    await globalPin.togglePin(widget.hymn.hymnId);
    await _onChanged();
  }

  void _openEditPage() {
    if (!AuthService.isAdmin) return;
    widget.onEditOpened();
  }

  @override
  Widget build(BuildContext context) {
    final pref = _pref ?? UserHymnPref()
      ..hymnId = widget.hymn.hymnId
      ..userId = AuthService.userId;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha((0.95 * 255).round()),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.hymn.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(
                          'Code: ${widget.hymn.hymnId} • Key: ${_detectedKey ?? 'N/A'}',
                          style: const TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.push_pin),
                    color: widget.pinned ? Colors.amber : Colors.black54,
                    tooltip: widget.pinned ? 'Unpin hymn' : 'Pin hymn',
                    onPressed: _togglePin,
                  ),
                  IconButton(
                    icon: const Icon(Icons.music_note),
                    tooltip: 'Toggle chords',
                    onPressed: widget.onToggleChords,
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: AuthService.isAdmin ? 'Edit hymn' : 'No edit access',
                    onPressed: AuthService.isAdmin ? _openEditPage : null,
                    color: AuthService.isAdmin ? null : Colors.grey,
                  ),
                  IconButton(
                    icon: const Icon(Icons.note),
                    tooltip: 'Open notepad',
                    onPressed: widget.onNotepadTapped,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  if (_detectedKey != null) ...[
                    HymnTransposeButton(pref: pref, onChanged: () => setState(() {})),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: HymnPreferencesButton(
                      pref: pref,
                      isar: widget.isar,
                      styles: _styles,
                      onChanged: _onChanged,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(label: Text('Tempo: ${pref.tempo}')),
                  const SizedBox(width: 8),
                  Chip(label: Text('Style: ${pref.style}')),
                  const SizedBox(width: 8),
                  Chip(label: Text('Beat: ${pref.beat}')),
                  const SizedBox(width: 8),
                  Chip(label: Text('Notes: $_noteCount')),
                  if (_errorCount > 0) ...[
                    const SizedBox(width: 8),
                    Chip(
                      backgroundColor: Colors.red.shade50,
                      label: Text('Errors: $_errorCount', style: const TextStyle(color: Colors.red)),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
