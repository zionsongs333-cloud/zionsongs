import 'dart:convert';
import 'package:flutter_transliterator/flutter_transliterator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'hymn_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import '../widgets/hymn_options_sheet.dart'; // Keep only 1 import

String _toSimpleSound(String text) {
  return text.toLowerCase().replaceAll(RegExp(r'[^\w\s\u0900-\u097F]'), ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
}

String _romanToHindi(String text) {
  return FlutterTransliterator().transliterate(text: text, toLanguageCode: 'hi');
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _userChurchScope = 'Grace Church Mumbai';
  String _searchQuery = '';
  String _filterKey = 'All';
  String _filterDedicated = 'All';
  String _filterYear = 'All';
  String _currentSortTag = 'sr';
  bool _isAscending = true;
  bool _darkMode = true;

  final ScrollController _songScrollController = ScrollController();
  final List<String> _alphabet = '#ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

  // Lists - start empty, load from phone
  List<String> userFavorites = [];
  List<Map<String, dynamic>> churchViewLists = [];
  List<Map<String, dynamic>> publicMedleys = []; // DELETE hardcoded default

  List<Map<String, dynamic>> staticExcelHymns = [];
  bool _loadingSongs = true;

  @override
  void initState() {
    super.initState();
    print("HOME SCREEN OPENED");
    _tabController = TabController(length: 4, vsync: this);
    _loadSongsFromFirestore(); // songs from cloud
    _loadAllFromPhone(); // NEW - loads fav + view + medley
  }

  // KEEP: Load songs from Firestore
  Future<void> _loadSongsFromFirestore() async {
    final snapshot = await FirebaseFirestore.instance.collection('hymns').get();
    print("Firestore docs found: ${snapshot.docs.length}");

    final songs = snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'sr': data['sr']?.toString() ?? '',
        'title': data['title']?.toString() ?? '',
        'Key': data['Key']?.toString() ?? '',
        'Dedicated': data['Dedicated']?.toString() ?? '',
        'year': data['year']?.toString() ?? '',
        'page': data['page']?.toString() ?? '',
        'English': (data['lyrics']?['English'] ?? '').toString(),
        'Hindi': (data['lyrics']?['Hindi'] ?? '').toString(),
        'Malayalam': (data['lyrics']?['Malayalam'] ?? '').toString(),
        'searchText': data['searchText']?.toString() ?? '',
      };
    }).toList();

    setState(() {
      staticExcelHymns = songs;
      _loadingSongs = false;
    });
  }

  // ADD: Load all 3 lists from phone - instant
  Future<void> _loadAllFromPhone() async {
    final prefs = await SharedPreferences.getInstance();
    
    userFavorites = prefs.getStringList('favorites_local') ?? [];
    
    final viewSaved = prefs.getString('viewLists_$_userChurchScope');
    churchViewLists = viewSaved != null ? List<Map<String, dynamic>>.from(jsonDecode(viewSaved)) : [];
    
    final medleySaved = prefs.getString('medleys_global');
    publicMedleys = medleySaved != null ? List<Map<String, dynamic>>.from(jsonDecode(medleySaved)) : [];
    
    setState(() {});
  }

  // ADD: Save all 3 lists to phone - called by sheet
  Future<void> _saveAllToPhone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites_local', userFavorites);
    await prefs.setString('viewLists_$_userChurchScope', jsonEncode(churchViewLists));
    await prefs.setString('medleys_global', jsonEncode(publicMedleys));
    setState(() {});
  }

  void _resetAllFilters() {
    setState(() {
      _searchQuery = ''; _filterKey = 'All'; _filterDedicated = 'All';
      _filterYear = 'All'; _currentSortTag = 'sr'; _isAscending = true;
    });
  }

  void _toggleSort(String tag) {
    setState(() {
      if (_currentSortTag == tag) {
        _isAscending = !_isAscending;
      } else {
        _currentSortTag = tag;
        _isAscending = true;
      }
    });
  }

  void _jumpToAlphabetLetter(String letter, List<Map<String, dynamic>> contextHymnsList) {
    int targetIdx = contextHymnsList.indexWhere((item) {
      if (letter == '#') return true;
      final title = (item['title'] ?? '').toString().trim().toUpperCase();
      return title.startsWith(letter);
    });

    if (targetIdx != -1) {
      const double estimateRowHeight = 72.0; 
      _songScrollController.animateTo(
        targetIdx * estimateRowHeight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No hymns start with "$letter"'), duration: const Duration(milliseconds: 400)),
      );
    }
  }

 @override
  Widget build(BuildContext context) {
    // 1. Header Theme (Always remains dark/deep colored)
    const constHeaderBg = Color(0xFF1A1A2E); // Deep Navy/Dark Slate for the AppBar
    const constHeaderTextColor = Colors.white;
    const constHeaderUnselectedColor = Colors.white60;

    // 2. Body Theme (Always stays a clean, lighter shade as requested)
    final bodyBgColor = _darkMode ? const Color(0xFFF5F5F7) : Colors.white; // Soft light grey or clean white
    final bodyTextColor = _darkMode ? const Color(0xFF1C1C1E) : Colors.black87;
    final secondaryTextColor = _darkMode ? Colors.black54 : Colors.black87;

    List<String> dynamicKeys =
        ['All'] + staticExcelHymns.map((h) => h['Key'].toString()).toSet().toList();

    List<String> dynamicDedicated =
        ['All'] + staticExcelHymns.map((h) => h['Dedicated'].toString()).toSet().toList();

    List<String> dynamicYears =
        ['All'] + staticExcelHymns.map((h) => h['year'].toString()).toSet().toList();
    
    final filteredHymns = staticExcelHymns.where((h) {
      if (_filterKey != 'All' && h['Key'].toString() != _filterKey) return false;
      if (_filterDedicated != 'All' && h['Dedicated'].toString() != _filterDedicated) return false;
      if (_filterYear != 'All' && h['year'].toString() != _filterYear) return false;

      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase().trim();
        return h['title'].toString().toLowerCase().contains(q) ||
            h['English'].toString().toLowerCase().contains(q) ||
            h['Hindi'].toString().toLowerCase().contains(q) ||
            h['Malayalam'].toString().toLowerCase().contains(q) ||
            h['searchText'].toString().toLowerCase().contains(q);
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: bodyBgColor, // Set overall body to the light background
     // floatingActionButton removed - sheet handles all
      appBar: AppBar(
  title: const Text('Hymns'),
  backgroundColor: constHeaderBg,
  actions: [
    IconButton(
      icon: Icon(_darkMode ? Icons.wb_sunny : Icons.wb_sunny_outlined, color: constHeaderTextColor),
      onPressed: () => setState(() => _darkMode = !_darkMode),
    ),
    IconButton(
      icon: const Icon(Icons.refresh, color: constHeaderTextColor),
      tooltip: "Reset All Filters",
      onPressed: _resetAllFilters,
    ),
  ],

        bottom: TabBar(
          indicatorColor: Colors.amber, // High contrast pop against the dark header
          indicatorWeight: 3,
          controller: _tabController,
          labelColor: constHeaderTextColor,
          unselectedLabelColor: constHeaderUnselectedColor,
          tabs: const [
            Tab(text: 'All Hymns'),
            Tab(text: 'Favorites'),
            Tab(text: 'View Listing'),
            Tab(text: 'Medleys'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSpreadsheetTab(filteredHymns, dynamicKeys, dynamicDedicated, dynamicYears),
          _buildFavoritesTab(),
          _buildChurchListingTab(),
          _buildMedleysTab(),
        ],
      ),
    );
  }

  Widget _buildSpreadsheetTab(
  List<Map<String, dynamic>> hymns,
  List<String> keys,
  List<String> dedicated,
  List<String> years,
)
   {
    return Column(
      children: [
        Padding(
  padding: const EdgeInsets.all(12.0),
  child: TextField(
    style: TextStyle(
  color: _darkMode ? Colors.white : Colors.black,
),
  decoration: InputDecoration(
  filled: true,
  fillColor:
    _darkMode ? const Color(0xFF181818) : Colors.white,

    hintText: 'Search hymns...',

hintStyle: TextStyle(
  color: _darkMode
      ? Colors.white54
      : Colors.black54,
),
    prefixIcon: Icon(
  Icons.search,
  color: _darkMode
      ? Colors.white70
      : Colors.grey,
),
    border: OutlineInputBorder(
  borderSide: BorderSide(
    color: _darkMode
        ? Colors.white24
        : Colors.grey,
  ),
),
    suffixIcon: _searchQuery.isNotEmpty
        ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(() => _searchQuery = '');
            },
          )
        : null,
  ),
  onChanged: (val) {
    setState(() {
      _searchQuery = val;
    });
  },
),
),
                 Material(
  elevation: 8,
  child: Container(
    color: _darkMode
    ? Colors.black
    : const Color(0xFFE8E8E8),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Expanded(
  flex: 1,
  child: Container(
    decoration: BoxDecoration(
      border: Border(
        right: BorderSide(
          color: _darkMode
    ? const Color(0xFF121212)
    : Colors.white,
          width: 2,
        ),
      ),
    ),
    child: _buildHeaderCell('SR', 'sr'),
  ),
),
              Expanded(
  flex: 4,
  child: Container(
    decoration: BoxDecoration(
      border: Border(
        right: BorderSide(
          color: _darkMode ? Colors.white24 : Colors.black26,
          width: 2,
        ),
      ),
    ),
    child: _buildHeaderCell('TITLE', 'title'),
  ),
),

Expanded(
  flex: 2,
  child: Container(
    decoration: BoxDecoration(
      border: Border(
        right: BorderSide(
          color: _darkMode ? Colors.white24 : Colors.black26,
          width: 2,
        ),
      ),
    ),
    child: _buildFilterHeaderCell(
      'KEY',
      'Key',
      _filterKey,
      keys,
      (val) => setState(() {
        _filterKey = val!;
      }),
    ),
  ),
),

Expanded(
  flex: 2,
  child: Container(
    decoration: BoxDecoration(
      border: Border(
        right: BorderSide(
          color: _darkMode ? Colors.white24 : Colors.black26,
          width: 2,
        ),
      ),
    ),
    child: _buildFilterHeaderCell(
      'DEDICATED',
      'Dedicated',
      _filterDedicated,
      dedicated,
      (val) => setState(() {
        _filterDedicated = val!;
      }),
    ),
  ),
),

Expanded(
  flex: 2,
  child: Container(
    decoration: BoxDecoration(
      border: Border(
        right: BorderSide(
          color: _darkMode ? Colors.white24 : Colors.black26,
          width: 2,
        ),
      ),
    ),
    child: _buildFilterHeaderCell(
      'YEAR',
      'year',
      _filterYear,
      years,
      (val) => setState(() {
        _filterYear = val!;
      }),
    ),
  ),
),

Expanded(
  flex: 1,
  child: Align(
    alignment: Alignment.centerRight,
    child: _buildHeaderCell('PAGE', 'page'),
  ),
),
            ],
          ),
        ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 18,
                color: _darkMode ? Colors.grey.shade900.withOpacity(0.3) : Colors.purple.withOpacity(0.04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _alphabet.map((letter) {
                    return GestureDetector(
                      onTap: () => _jumpToAlphabetLetter(letter, hymns),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 1.0),
                        child: Text(
                          letter,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: _darkMode ? Colors.purple.shade200 : Colors.purple.shade700,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: hymns.isEmpty
                    ? const Center(child: Text('No matching items found.'))
                    : ListView.builder(
                        controller: _songScrollController,
                        itemCount: hymns.length,
                        itemBuilder: (context, index) {
                          final item = hymns[index];
                          String preview = '';

                          if (_searchQuery.isNotEmpty) {
                            final hindi = item['Hindi']?.toString() ?? '';
                            if (hindi.isNotEmpty) {
                              preview = hindi.length > 120 ? '${hindi.substring(0, 120)}...' : hindi;
                            }
                          }

                        return InkWell(
  onTap: () => context.push('/hymn/${item['sr']}', extra: staticExcelHymns),
  onLongPress: () => showHymnOptionsSheet(
  context: context, 
  item: item, 
  userFavorites: userFavorites, 
  churchViewLists: churchViewLists, 
  publicMedleys: publicMedleys, 
  userChurchScope: _userChurchScope, 
  onSaveLists: _saveAllToPhone, // must return Future<void>
),
  child: Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
    ),
    child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1, 
                                        child: Text(
                                          item['sr']!,
                                          style: const TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          item['title']!,
                                          style: const TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2, 
                                        child: Text(item['Key']!, style: const TextStyle(color: Color(0xFF1565C0))),
                                      ),
                                      Expanded(
                                        flex: 2, 
                                        child: Text(item['Dedicated']!, style: const TextStyle(color: Color(0xFF1565C0))),
                                      ),
                                      Expanded(
                                        flex: 2, 
                                        child: Text(item['year']!, style: const TextStyle(color: Color(0xFF1565C0))),
                                      ),
                                      Expanded(
                                        flex: 1, 
                                        child: Align(
                                          alignment: Alignment.centerRight, 
                                          child: Text(
                                            item['page']!,
                                            style: const TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (_searchQuery.isNotEmpty && preview.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6, left: 40),
                                      child: Text(
                                        preview,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 13, color: Color(0xFF3F51B5), fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildFavoritesTab() {
  final favSongs = staticExcelHymns.where((h) => userFavorites.contains(h['sr'])).toList();
  return Column(
    children: [
      const ListTile(
        title: Text('My Private Favorites (Only Visible to Me)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple))
      ),
      Expanded(
        child: favSongs.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView(
              children: favSongs.map((s) => ListTile(
                title: Text(s['title']!),
                subtitle: Text('Page: ${s['page']}'),
                onTap: () => context.push('/hymn/${s['sr']}', extra: staticExcelHymns)
              )).toList()
            ),
      )
    ],
  );
} // <-- CLOSE _buildFavoritesTab

Widget _buildChurchListingTab() {
  // Only scopes visibility to matches in the same church
  final visibleLists = churchViewLists.where((l) => l['church'] == _userChurchScope).toList();
  return Column(children: [
    ListTile(
      title: Text('Church View Listing Scope: $_userChurchScope', style: const TextStyle(fontWeight: FontWeight.bold)),
      // trailing removed - use long press sheet to create
    ),
    Expanded(
      child: visibleLists.isEmpty
        ? const Center(child: Text('No church view lists available.'))
        : ListView(
    children: visibleLists.map((l) => ListTile(
      leading: const Icon(Icons.church, color: Colors.purple),
      title: Text(l['name'].toString()),
      subtitle: Text(
        'Contains ${(l['songs'] as List).length} songs • Scoped to Church Members Only'
      ),
     onTap: () {
  final songsInList = staticExcelHymns.where(
    (song) => (l['songs'] as List).contains(song['sr']),
  ).toList();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: songsInList.length,
        itemBuilder: (_, index) {
          final song = songsInList[index];

          return ListTile(
            title: Text(song['title']),
            subtitle: Text('Page ${song['page']}'),
            onTap: () {
              Navigator.pop(context);

              context.push(
                '/hymn/${song['sr']}',
                extra: staticExcelHymns,
              );
            },
          );
        },
      ),
    ),
  );
},
    )).toList(),
)
    ),
  ]);
} // <-- CLOSE _buildChurchListingTab

Widget _buildMedleysTab() {
  return Column(
    children: [
      ListTile(
        title: const Text(
          'Public Medleys (Shared Globally with All Users)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // trailing removed - use long press sheet to create
      ),
      Expanded(
        child: publicMedleys.isEmpty
            ? const Center(child: Text('No public medleys available.'))
            : ListView(
                children: publicMedleys.map((m) => ListTile(
                  leading: const Icon(Icons.queue_music, color: Colors.blue),
                  title: Text(m['name'].toString()),
                  subtitle: Text(
                    'Contains ${(m['songs'] as List).length} songs • Visible to All Workspaces',
                  ),
                  onTap: () {
  final songsInMedley = staticExcelHymns.where(
    (song) => (m['songs'] as List).contains(song['sr']),
  ).toList();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: songsInMedley.length,
        itemBuilder: (_, index) {
          final song = songsInMedley[index];

          return ListTile(
            title: Text(song['title']),
            subtitle: Text('Page ${song['page']}'),
            onTap: () {
              Navigator.pop(context);

              context.push(
                '/hymn/${song['sr']}',
                extra: staticExcelHymns,
              );
            },
          );
        },
      ),
    ),
  );
},
                )).toList(),
              ),
      ),
    ],
  );
}

Widget _buildHeaderCell(String label, String tag) {
  return InkWell(
    onTap: () => _toggleSort(tag),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: _darkMode ? Colors.white : Colors.purple)),
        if (_currentSortTag == tag)
          Icon(_isAscending ? Icons.arrow_drop_up : Icons.arrow_drop_down, size: 16, color: _darkMode ? Colors.white : Colors.purple),
      ],
    ),
  );
}


Widget _buildFilterHeaderCell(String label, String tag, String activeValue, List options, ValueChanged<String?> onChange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      mainAxisSize: MainAxisSize.min, 
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: Color(0xFF0D47A1), // Dark blue filter titles
          ),
        ),
        DropdownButton<String>(
          value: options.contains(activeValue) ? activeValue : 'All',
          isDense: true,
          underline: Container(),
          dropdownColor: Colors.white, // Keeps the dropdown background clean white
          style: const TextStyle(color: Color(0xFF0D47A1), fontSize: 12), // Dark blue selected item
          items: options.map((opt) => DropdownMenuItem<String>(
            value: opt, 
            child: Text(opt, style: const TextStyle(color: Color(0xFF0D47A1))) // Dark blue list options
          )).toList(),
          onChanged: (val) => onChange(val as String?),
        ),
      ],
    );
  }

  Future<void> _handlePdfAction(Map<String, dynamic> item, {required bool shareViaSheet}) async {
    final pdf = pw.Document();

    // Grab the lyrics safely
    final String englishLyrics = item['English'] ?? '';
    final String hindiLyrics = item['Hindi'] ?? '';
    final String malayalamLyrics = item['Malayalam'] ?? '';

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Hymn No: ${item['sr']}', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),
              pw.Text(item['title'] ?? 'Untitled', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.Text('Key: ${item['Key']}  |  Dedicated: ${item['Dedicated']}  |  Year: ${item['year']}', style: const pw.TextStyle(fontSize: 12)),
              pw.Divider(),
              pw.SizedBox(height: 14),
              if (englishLyrics.isNotEmpty) ...[
                pw.Text('English Lyrics:', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Text(englishLyrics, style: const pw.TextStyle(fontSize: 12)),
                pw.SizedBox(height: 14),
              ],
              if (hindiLyrics.isNotEmpty) ...[
                pw.Text('Hindi Lyrics:', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Text(hindiLyrics, style: const pw.TextStyle(fontSize: 12)),
                pw.SizedBox(height: 14),
              ],
              if (malayalamLyrics.isNotEmpty) ...[
                pw.Text('Malayalam Lyrics:', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Text(malayalamLyrics, style: const pw.TextStyle(fontSize: 12)),
              ],
            ],
          );
        },
      ),
    );

    try {
      // Save the PDF as bytes
      final bytes = await pdf.save();
      final String filename = 'Hymn_${item['sr']}_${item['title']?.replaceAll(RegExp(r'[^\w\s]'), '')}.pdf';

      if (shareViaSheet) {
        // Triggers native sharing panel (WhatsApp, Telegram, etc.)
        await Share.shareXFiles(
          [XFile.fromData(bytes, mimeType: 'application/pdf', name: filename)],
          text: 'Check out this hymn: ${item['title']}',
        );
      } else {
        // Triggers save directly to device files storage system
        await Share.shareXFiles(
          [XFile.fromData(bytes, mimeType: 'application/pdf', name: filename)],
        );
      }
    } catch (e) {
      print("Error processing PDF: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate PDF: $e')),
      );
    }
  }  
}