import 'dart:async';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'hymn_models.dart';
import 'hymn_pin_button.dart';
import 'hymn_transpose_button.dart';
import 'hymn_preferences_button.dart';
import 'hymn_preferences_logic.dart';
import 'hymn_edit_button.dart';
import 'hymn_notepad_button.dart';
import 'hymn_transpose_logic.dart';
import 'hymn_sync_logic.dart';
import 'hymn_auth_service.dart';
import 'edit_lyrics_page.dart';

class HymnInfoBar extends StatefulWidget {
  final String hymnId;
  final String lyrics;
  final String title;
  final Isar isar;

  const HymnInfoBar({
    super.key,
    required this.hymnId,
    required this.lyrics,
    required this.title,
    required this.isar,
  });

  @override
  State<HymnInfoBar> createState() => _HymnInfoBarState();
}

class _HymnInfoBarState extends State<HymnInfoBar> {
  UserHymnPref? _pref;
  LocalHymn? _hymn;
  String? _detectedKey;
  int _noteCount = 0;
  int _errorCount = 0;
  List<String> _styles = [];
  StreamSubscription? _connectivitySub;

  String get _activeHymnId => globalPin.value ?? widget.hymnId;
  String get _activeLyrics =>
      globalPin.value == null ? widget.lyrics : _hymn?.originalLyrics ?? "";
  String get _activeTitle =>
      globalPin.value == null ? widget.title : _hymn?.title ?? "";
  String get _displayedLyrics => HymnTransposeLogic.transposeLyrics(
    _activeLyrics,
    _pref?.transposeOffset ?? 0,
    _pref?.preferFlats ?? false,
  );

  @override
  void initState() {
    super.initState();
    globalPin.addListener(_refresh);
    _initAndLoad();
    HymnPreferencesLogic.getStyles().then(
      (s) => mounted ? setState(() => _styles = s) : null,
    );
    _connectivitySub = Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        SyncLogic.attemptSync(widget.isar, AuthService.userId);
      }
    });
  }

  @override
  void dispose() {
    globalPin.removeListener(_refresh);
    _connectivitySub?.cancel();
    super.dispose();
  }

  Future<void> _initAndLoad() async {
    if (AuthService.userId.isEmpty)
      await Future.delayed(const Duration(milliseconds: 100));
    await _refresh();
  }

  Future<void> _refresh() async {
    await _loadHymnData(_activeHymnId);
    await _refreshBadge();
  }

  Future<void> _loadHymnData(String id) async {
    _pref ??= UserHymnPref()
      ..hymnId = id
      ..userId = AuthService.userId;

    try {
      _hymn = await widget.isar.localHymns
          .filter()
          .hymnIdEqualTo(id)
          .findFirst();
      final existingPref = await widget.isar.userHymnPrefs
          .filter()
          .hymnIdEqualTo(id)
          .userIdEqualTo(AuthService.userId)
          .findFirst();

      if (existingPref != null) {
        _pref = existingPref;
      } else if (_hymn != null) {
        await widget.isar.writeTxn(() => widget.isar.userHymnPrefs.put(_pref!));
      }

      _detectedKey = HymnTransposeLogic.detectKey(_hymn?.originalLyrics ?? "");
      if (mounted) setState(() {});
    } catch (_) {
      if (mounted) {
        setState(() {
          _hymn = null;
          _pref ??= UserHymnPref()
            ..hymnId = id
            ..userId = AuthService.userId;
        });
      }
    }
  }

  Future<void> _refreshBadge() async {
    int count = await widget.isar.userNotes
        .filter()
        .hymnIdEqualTo(_activeHymnId)
        .userIdEqualTo(AuthService.userId)
        .count();
    int errors = await widget.isar.userNotes
        .filter()
        .hymnIdEqualTo(_activeHymnId)
        .userIdEqualTo(AuthService.userId)
        .syncStatusEqualTo(SyncStatus.error)
        .count();
    errors += await widget.isar.editProposals
        .filter()
        .hymnIdEqualTo(_activeHymnId)
        .userIdEqualTo(AuthService.userId)
        .syncStatusEqualTo(SyncStatus.error)
        .count();
    if (mounted) setState(() => {_noteCount = count, _errorCount = errors});
  }

  void _openEditPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditLyricsPage(
          isar: widget.isar,
          hymnId: _activeHymnId,
          originalLyrics: _activeLyrics,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_hymn == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final effectivePref = _pref ?? UserHymnPref()
      ..hymnId = _activeHymnId
      ..userId = AuthService.userId;
    final hasChords = _detectedKey != null;

    return Container(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PinButton(hymnId: widget.hymnId),
                const SizedBox(width: 8),
                if (hasChords)
                  HymnTransposeButton(pref: effectivePref, onChanged: _refresh),
                if (hasChords) const SizedBox(width: 8),
                Expanded(
                  child: HymnPreferencesButton(
                    pref: effectivePref,
                    isar: widget.isar,
                    styles: _styles,
                    onChanged: _refresh,
                  ),
                ),
                const SizedBox(width: 8),
                EditButton(
                  isar: widget.isar,
                  hymnId: _activeHymnId,
                  lyrics: _activeLyrics,
                  onEditTogether: _openEditPage,
                  hasError: _errorCount > 0,
                ),
                NotepadButton(
                  badge: _noteCount,
                  hasError: _errorCount > 0,
                  isar: widget.isar,
                  hymnId: _activeHymnId,
                  hymnTitle: _activeTitle,
                  onChanged: _refresh,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SelectableText(
                _displayedLyrics,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
