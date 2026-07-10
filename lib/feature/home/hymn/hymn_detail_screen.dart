import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:isar/isar.dart';
import 'app_initializer.dart';
import 'hymn_models.dart';
import 'hymn_auth_service.dart';
import 'hymn_pin_button.dart';
import 'widgets/chord_lyrics_widget.dart';
import 'widgets/chord_preference_service.dart';
import 'widgets/floating_app_info_bar.dart';
import 'widgets/floating_hymn_info_bar.dart';
import 'widgets/floating_notepad_window.dart';
import 'widgets/hymn_navigation_controls.dart';
import 'edit_lyrics_page.dart';

class HymnDetailScreen extends StatefulWidget {
  final String hymnId;
  final List<String>? sourceHymnIds;
  final int? initialIndex;

  const HymnDetailScreen({
    super.key,
    required this.hymnId,
    this.sourceHymnIds,
    this.initialIndex,
  });

  @override
  State<HymnDetailScreen> createState() => _HymnDetailScreenState();
}

class _HymnDetailScreenState extends State<HymnDetailScreen> {
  final ScrollController _scrollController = ScrollController();

  LocalHymn? _currentHymn;
  LocalHymn? _pinnedHymn;
  List<LocalHymn> _sourceHymns = [];
  int _currentIndex = 0;
  bool _showAppBar = true;
  bool _showNotepad = false;
  bool _showChords = false;
  bool _loading = true;
  bool _appBarHiddenByScroll = false;

  LocalHymn? get _activeHymn => _pinnedHymn ?? _currentHymn;
  bool get _pinned => _pinnedHymn != null && _pinnedHymn!.hymnId != _currentHymn?.hymnId;
  String get _lyrics => _currentHymn?.originalLyrics ?? '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    globalPin.addListener(_onPinChanged);
    _loadScreen();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    globalPin.removeListener(_onPinChanged);
    super.dispose();
  }

  Future<void> _loadScreen() async {
    await _loadSourceList();
    await _loadChordPreference();
    await _loadPinnedHymn();
    await _loadCurrentHymn();
    setState(() {
      _loading = false;
    });
  }

  Future<void> _loadSourceList() async {
    if (widget.sourceHymnIds != null && widget.sourceHymnIds!.isNotEmpty) {
      final hymns = <LocalHymn>[];
      for (final id in widget.sourceHymnIds!) {
        final hymn = await AppInitializer.isar.localHymns
            .filter()
            .hymnIdEqualTo(id)
            .findFirst();
        if (hymn != null) hymns.add(hymn);
      }
      _sourceHymns = hymns;
      _currentIndex = widget.initialIndex ?? hymns.indexWhere((h) => h.hymnId == widget.hymnId);
      if (_currentIndex < 0) _currentIndex = 0;
    }
  }

  Future<void> _loadChordPreference() async {
    final enabled = await ChordPreferenceService.loadChordEnabled();
    setState(() {
      _showChords = enabled;
    });
  }

  Future<void> _loadPinnedHymn() async {
    final pinnedId = globalPin.value;
    if (pinnedId != null) {
      _pinnedHymn = await AppInitializer.isar.localHymns
          .filter()
          .hymnIdEqualTo(pinnedId)
          .findFirst();
    } else {
      _pinnedHymn = null;
    }
  }

  Future<void> _loadCurrentHymn() async {
    final id = _sourceHymns.isNotEmpty && _currentIndex < _sourceHymns.length
        ? _sourceHymns[_currentIndex].hymnId
        : widget.hymnId;
    _currentHymn = await AppInitializer.isar.localHymns
        .filter()
        .hymnIdEqualTo(id)
        .findFirst();
    if (_currentHymn == null && _sourceHymns.isNotEmpty) {
      _currentHymn = _sourceHymns.first;
      _currentIndex = 0;
    }
    await _loadPinnedHymn();
    if (mounted) setState(() {});
  }

  void _onPinChanged() {
    _loadPinnedHymn();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.reverse && !_appBarHiddenByScroll) {
      setState(() {
        _showAppBar = false;
        _appBarHiddenByScroll = true;
      });
    } else if (direction == ScrollDirection.forward && _appBarHiddenByScroll) {
      setState(() {
        _showAppBar = true;
        _appBarHiddenByScroll = false;
      });
    }
  }

  Future<void> _toggleChords() async {
    final enabled = !_showChords;
    await ChordPreferenceService.saveChordEnabled(enabled);
    setState(() {
      _showChords = enabled;
    });
  }

  Future<void> _toggleNotepad() async {
    setState(() {
      _showNotepad = !_showNotepad;
    });
  }

  Future<void> _toggleAppBar() async {
    setState(() {
      _showAppBar = !_showAppBar;
    });
  }

  Future<void> _gotoIndex(int newIndex) async {
    if (newIndex < 0 || newIndex >= _sourceHymns.length) return;
    setState(() {
      _currentIndex = newIndex;
      _loading = true;
    });
    await _loadCurrentHymn();
    _scrollController.jumpTo(0);
    setState(() {
      _loading = false;
    });
  }

  void _openEditPage() {
    if (!AuthService.isAdmin) return;
    if (_currentHymn == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditLyricsPage(
          isar: AppInitializer.isar,
          hymnId: _currentHymn!.hymnId,
          originalLyrics: _currentHymn!.originalLyrics,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _currentHymn == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final previous = _sourceHymns.isNotEmpty && _currentIndex > 0 ? _sourceHymns[_currentIndex - 1] : null;
    final next = _sourceHymns.isNotEmpty && _currentIndex < _sourceHymns.length - 1 ? _sourceHymns[_currentIndex + 1] : null;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (_) {
              return false;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 90, bottom: 60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 90),
                    ChordLyricsWidget(
                      lyrics: _lyrics,
                      showChords: _showChords,
                    ),
                  ],
                ),
              ),
            ),
          ),
          FloatingAppInfoBar(
            visible: _showAppBar,
            onToggle: _toggleAppBar,
          ),
          Positioned(
            top: 74,
            left: 0,
            right: 0,
            child: FloatingHymnInfoBar(
              hymn: _activeHymn!,
              isar: AppInitializer.isar,
              pinned: _pinned,
              onChanged: () async {
                await _loadCurrentHymn();
                setState(() {});
              },
              onToggleChords: _toggleChords,
              onNotepadTapped: _toggleNotepad,
              onEditOpened: _openEditPage,
            ),
          ),
          Positioned(
            right: 12,
            top: 220,
            child: HymnNavigationControls(
              current: _currentHymn!,
              previous: previous,
              next: next,
              onPrevious: () => _gotoIndex(_currentIndex - 1),
              onNext: () => _gotoIndex(_currentIndex + 1),
            ),
          ),
          if (_showNotepad)
            FloatingNotepadWindow(
              isar: AppInitializer.isar,
              hymnId: _activeHymn!.hymnId,
              hymnTitle: _activeHymn!.title,
              onClosed: () {
                setState(() {
                  _showNotepad = false;
                });
              },
              onSaved: () async {},
            ),
        ],
      ),
    );
  }
}
