import 'dart:convert';
import 'package:flutter_transliterator/flutter_transliterator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'hymn_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import '../widgets/hymn_options_sheet.dart';

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
  bool _isPresentationMode = false;

  final ScrollController _songScrollController = ScrollController();
  final List<String> _alphabet = '#ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

  List<String> userFavorites = [];
  List<Map<String, dynamic>> churchViewLists = [];
  List<Map<String, dynamic>> publicMedleys = [];

  List<Map<String, dynamic>> staticExcelHymns = [];
  bool _loadingSongs = true;

  @override
  void initState() {
    super.initState();
    print("HOME SCREEN OPENED");
    _tabController = TabController(length: 4, vsync: this);
    _loadSongsFromFirestore();
    _loadAllFromPhone();
  }

  Future<void> _loadSongsFromFirestore() async {
    final snapshot = await FirebaseFirestore.instance.collection('hymns').get();
    print("Firestore docs found: ${snapshot.docs.length}");

    final songs = snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'sr': data['sr']?.toString()?? '',
        'title': data['title']?.toString()?? '',
        'Key': data['Key']?.toString()?? '',
        'Dedicated': data['Dedicated']?.toString()?? '',
        'year': data['year']?.toString()?? '',
        'page': data['page']?.toString()?? '',
        'English': (data['lyrics']?['English']?? '').toString(),
        'Hindi': (data['lyrics']?['Hindi']?? '').toString(),
        'Malayalam': (data['lyrics']?['Malayalam']?? '').toString(),
        'searchText': data['searchText']?.toString()?? '',
      };
    }).toList();

    setState(() {
      staticExcelHymns = songs;
      _loadingSongs = false;
    });
  }

  Future<void> _loadAllFromPhone() async {
    final prefs = await SharedPreferences.getInstance();
    userFavorites = prefs.getStringList('favorites_local')?? [];
    final viewSaved = prefs.getString('viewLists_$_userChurchScope');
    churchViewLists = viewSaved!= null? List<Map<String, dynamic>>.from(jsonDecode(viewSaved)) : [];
    final medleySaved = prefs.getString('medleys_global');
    publicMedleys = medleySaved!= null? List<Map<String, dynamic>>.from(jsonDecode(medleySaved)) : [];
    setState(() {});
  }

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
        _isAscending =!_isAscending;
      } else {
        _currentSortTag = tag;
        _isAscending = true;
      }
    });
  }

  void _jumpToAlphabetLetter(String letter, List<Map<String, dynamic>> contextHymnsList) {
    int targetIdx = contextHymnsList.indexWhere((item) {
      if (letter == '#') return true;
      final title = (item['title']?? '').toString().trim().toUpperCase();
      return title.startsWith(letter);
    });

    if (targetIdx!= -1) {
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
    final theme = Provider.of<ThemeProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    List<String> dynamicKeys = ['All'] + staticExcelHymns.map((h) => h['Key'].toString()).toSet().toList();
    List<String> dynamicDedicated = ['All'] + staticExcelHymns.map((h) => h['Dedicated'].toString()).toSet().toList();
    List<String> dynamicYears = ['All'] + staticExcelHymns.map((h) => h['year'].toString()).toSet().toList();

    final filteredHymns = staticExcelHymns.where((h) {
      if (_filterKey!= 'All' && h['Key'].toString()!= _filterKey) return false;
      if (_filterDedicated!= 'All' && h['Dedicated'].toString()!= _filterDedicated) return false;
      if (_filterYear!= 'All' && h['year'].toString()!= _filterYear) return false;

      if (_searchQuery.isNotEmpty) {
        final q = _toSimpleSound(_searchQuery);
        return _toSimpleSound(h['title'].toString()).contains(q) ||
            _toSimpleSound(h['English'].toString()).contains(q) ||
            _toSimpleSound(h['Hindi'].toString()).contains(q) ||
            _toSimpleSound(h['Malayalam'].toString()).contains(q) ||
            _toSimpleSound(h['searchText'].toString()).contains(q);
      }
      return true;
    }).toList();

    filteredHymns.sort((a, b) {
      var aVal = a[_currentSortTag];
      var bVal = b[_currentSortTag];
      if (_currentSortTag == 'sr') {
        aVal = int.tryParse(aVal.toString())?? 0;
        bVal = int.tryParse(bVal.toString())?? 0;
      } else {
        aVal = aVal.toString().toLowerCase();
        bVal = bVal.toString().toLowerCase();
      }
      return _isAscending? aVal.compareTo(bVal) : bVal.compareTo(aVal);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.getZoneBg(context),
        title: Row(
          children: [
            Text('Hymns', style: TextStyle(color: theme.getZoneText(context))),
            const SizedBox(width: 12),
            Text(_userChurchScope, style: TextStyle(color: theme.getZoneTextUnselected(context), fontSize: 12)),
          ],
        ),
       actions: [
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Center(child: Text('Admin', style: TextStyle(color: theme.getZoneText(context), fontSize: 12))),
  ),
  
  // NEW: Color picker button
  PopupMenuButton<Color>(
    icon: Icon(Icons.palette, color: theme.getZoneText(context)),
    tooltip: 'Change theme color',
    onSelected: (color) => theme.changePrimaryColor(color),
    itemBuilder: (context) => theme.themeColors.map((color) => 
      PopupMenuItem(
        value: color,
        child: Container(
          width: 30, 
          height: 30, 
          decoration: BoxDecoration(
            color: color, 
            shape: BoxShape.circle, 
            border: Border.all(color: Colors.white, width: 2)
          )
        )
      )
    ).toList(),
  ),
  
  IconButton(
    icon: Icon(isDark? Icons.wb_sunny : Icons.nights_stay, color: theme.getZoneText(context)),
    onPressed: () => theme.toggleTheme(!isDark),
  ),
  IconButton(
    icon: Icon(_isPresentationMode? Icons.fullscreen_exit : Icons.present_to_all, color: theme.getZoneText(context)),
    onPressed: () => setState(() => _isPresentationMode =!_isPresentationMode),
  ),
  IconButton(
    icon: Icon(Icons.refresh, color: theme.getZoneText(context)),
    tooltip: "Reset All Filters",
    onPressed: _resetAllFilters,
  ),
],
        bottom: TabBar(
          controller: _tabController,
          labelColor: theme.getZoneText(context),
          unselectedLabelColor: theme.getZoneTextUnselected(context),
          indicatorColor: Colors.amber,
          tabs: const [
            Tab(text: 'All Hymns'),
            Tab(text: 'Favorites'),
            Tab(text: 'View Listing'),
            Tab(text: 'Medleys'),
          ],
        ),
      ),

      body: Row(
        children: [
          Container(
            width: 40,
            color: theme.getZoneBg(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _alphabet.map((letter) {
                return GestureDetector(
                  onTap: () => _jumpToAlphabetLetter(letter, filteredHymns),
                  child: Text(
                    letter,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: theme.getZoneText(context),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSpreadsheetTab(filteredHymns, dynamicKeys, dynamicDedicated, dynamicYears, theme),
                _buildFavoritesTab(theme),
                _buildChurchListingTab(theme),
                _buildMedleysTab(theme),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        height: 50,
        color: theme.getZoneBg(context),
        child: Row(children: []),
      ),
    );
  }

  Widget _buildSpreadsheetTab(List<Map<String, dynamic>> hymns, List<String> keys, List<String> dedicated, List<String> years, ThemeProvider theme) {
    final listTextColor = theme.getListText(context);

    return Column(
      children: [
        if (!_isPresentationMode)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              style: TextStyle(color: listTextColor),
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).cardColor,
                hintText: 'Search hymns...',
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).dividerColor)),
                suffixIcon: _searchQuery.isNotEmpty? IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() => _searchQuery = '')) : null,
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),

        Material(
          elevation: 8,
          color: theme.getZoneBg(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                Expanded(flex: 1, child: _buildHeaderCell('SR', 'sr', theme)),
                Expanded(flex: 4, child: _buildHeaderCell('TITLE', 'title', theme)),
                Expanded(flex: 2, child: _buildFilterHeaderCell('KEY', 'Key', _filterKey, keys, (val) => setState(() => _filterKey = val!), theme)),
                Expanded(flex: 2, child: _buildFilterHeaderCell('DEDICATED', 'Dedicated', _filterDedicated, dedicated, (val) => setState(() => _filterDedicated = val!), theme)),
                Expanded(flex: 2, child: _buildFilterHeaderCell('YEAR', 'year', _filterYear, years, (val) => setState(() => _filterYear = val!), theme)),
                Expanded(flex: 1, child: Align(alignment: Alignment.centerRight, child: _buildHeaderCell('PAGE', 'page', theme))),
              ],
            ),
          ),
        ),

        Expanded(
          child: Container(
            decoration: BoxDecoration(color: theme.getZoneBg(context)),
            child: hymns.isEmpty
            ? Center(child: Text('No matching items found.', style: TextStyle(color: listTextColor)))
              : ListView.builder(
                  controller: _songScrollController,
                  itemCount: hymns.length,
                  itemBuilder: (context, index) {
                    final item = hymns[index];
                    String preview = '';
                    if (_searchQuery.isNotEmpty) {
                      final hindi = item['Hindi']?.toString()?? '';
                      if (hindi.isNotEmpty) {
                        preview = hindi.length > 120? '${hindi.substring(0, 120)}...' : hindi;
                      }
                    }
                    return _HymnCard(
                      item: item,
                      preview: preview,
                      textColor: listTextColor,
                      theme: theme,
                      onTap: () => context.push('/hymn/${item['sr']}', extra: staticExcelHymns),
                      onLongPress: () => showHymnOptionsSheet(
                        context: context,
                        item: item,
                        userFavorites: userFavorites,
                        churchViewLists: churchViewLists,
                        publicMedleys: publicMedleys,
                        userChurchScope: _userChurchScope,
                        onSaveLists: _saveAllToPhone,
                      ),
                    );
                  },
                ),
          ),
        ),
      ],
    );
  }

  Widget _HymnCard({required Map item, required String preview, required Color textColor, required ThemeProvider theme, required VoidCallback onTap, required VoidCallback onLongPress}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: theme.getCardDecoration(context),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(flex: 1, child: Text(item['sr']!, style: TextStyle(color: textColor, fontWeight: FontWeight.bold))),
                    Expanded(flex: 4, child: Text(item['title']!, style: TextStyle(color: textColor, fontWeight: FontWeight.w600))),
                    Expanded(flex: 2, child: Text(item['Key']!, style: TextStyle(color: textColor))),
                    Expanded(flex: 2, child: Text(item['Dedicated']!, style: TextStyle(color: textColor))),
                    Expanded(flex: 2, child: Text(item['year']!, style: TextStyle(color: textColor))),
                    Expanded(flex: 1, child: Align(alignment: Alignment.centerRight, child: Text(item['page']!, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)))),
                  ],
                ),
                if (preview.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 40),
                    child: Text(preview, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: textColor.withOpacity(0.8), fontStyle: FontStyle.italic)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoritesTab(ThemeProvider theme) {
    final favHymns = staticExcelHymns.where((h) => userFavorites.contains(h['sr'].toString())).toList();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: theme.getZoneBg(context)),
        child: favHymns.isEmpty
        ? Center(child: Text('No favorite hymns yet', style: TextStyle(color: theme.getListText(context))))
          : ListView.builder(
              itemCount: favHymns.length,
              itemBuilder: (context, index) {
                final song = favHymns[index];
                return _HymnCard(
                  item: song,
                  preview: '',
                  textColor: theme.getListText(context),
                  theme: theme,
                  onTap: () => context.push('/hymn/${song['sr']}', extra: staticExcelHymns),
                  onLongPress: () => showHymnOptionsSheet(
                    context: context,
                    item: song,
                    userFavorites: userFavorites,
                    churchViewLists: churchViewLists,
                    publicMedleys: publicMedleys,
                    userChurchScope: _userChurchScope,
                    onSaveLists: _saveAllToPhone,
                  ),
                );
              },
            ),
      ),
    );
  }

  Widget _buildChurchListingTab(ThemeProvider theme) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: theme.getZoneBg(context)),
        child: churchViewLists.isEmpty
        ? Center(child: Text('No church lists available', style: TextStyle(color: theme.getListText(context))))
          : ListView.builder(
              itemCount: churchViewLists.length,
              itemBuilder: (context, index) {
                final list = churchViewLists[index];
                final songSrs = List<String>.from(list['songs']?? []);
                final hymnsInList = staticExcelHymns.where((h) => songSrs.contains(h['sr'].toString())).toList();

                return ExpansionTile(
                  title: Text(list['name']?? '', style: TextStyle(color: theme.getListText(context), fontWeight: FontWeight.bold)),
                  subtitle: Text('${hymnsInList.length} hymns', style: TextStyle(color: theme.getListText(context).withOpacity(0.7))),
                  iconColor: theme.getListText(context),
                  collapsedIconColor: theme.getListText(context),
                  children: hymnsInList.isEmpty
                  ? [ListTile(title: Text('No hymns in this list', style: TextStyle(color: theme.getListText(context).withOpacity(0.6))))]
                    : hymnsInList.map((item) => _HymnCard(
                        item: item,
                        preview: '',
                        textColor: theme.getListText(context),
                        theme: theme,
                        onTap: () => context.push('/hymn/${item['sr']}', extra: staticExcelHymns),
                        onLongPress: () => showHymnOptionsSheet(
                          context: context,
                          item: item,
                          userFavorites: userFavorites,
                          churchViewLists: churchViewLists,
                          publicMedleys: publicMedleys,
                          userChurchScope: _userChurchScope,
                          onSaveLists: _saveAllToPhone,
                        ),
                      )).toList(),
                );
              },
            ),
      ),
    );
  }

  Widget _buildMedleysTab(ThemeProvider theme) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: theme.getZoneBg(context)),
        child: publicMedleys.isEmpty
        ? Center(child: Text('No medleys found', style: TextStyle(color: theme.getListText(context))))
          : ListView.builder(
              itemCount: publicMedleys.length,
              itemBuilder: (context, index) {
                final medley = publicMedleys[index];
                final songSrs = List<String>.from(medley['songs']?? []);
                final hymnsInMedley = staticExcelHymns.where((h) => songSrs.contains(h['sr'].toString())).toList();

                return ExpansionTile(
                  title: Text(medley['name']?? '', style: TextStyle(color: theme.getListText(context), fontWeight: FontWeight.bold)),
                  subtitle: Text('${hymnsInMedley.length} hymns', style: TextStyle(color: theme.getListText(context).withOpacity(0.7))),
                  iconColor: theme.getListText(context),
                  collapsedIconColor: theme.getListText(context),
                  children: hymnsInMedley.isEmpty
                  ? [ListTile(title: Text('No hymns in this medley', style: TextStyle(color: theme.getListText(context).withOpacity(0.6))))]
                    : hymnsInMedley.map((item) => _HymnCard(
                        item: item,
                        preview: '',
                        textColor: theme.getListText(context),
                        theme: theme,
                        onTap: () => context.push('/hymn/${item['sr']}', extra: staticExcelHymns),
                        onLongPress: () => showHymnOptionsSheet(
                          context: context,
                          item: item,
                          userFavorites: userFavorites,
                          churchViewLists: churchViewLists,
                          publicMedleys: publicMedleys,
                          userChurchScope: _userChurchScope,
                          onSaveLists: _saveAllToPhone,
                        ),
                      )).toList(),
                );
              },
            ),
      ),
    );
  }

  Widget _buildHeaderCell(String label, String tag, ThemeProvider theme) {
    return InkWell(
      onTap: () => _toggleSort(tag),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: theme.getZoneText(context))),
          if (_currentSortTag == tag)
            Icon(_isAscending? Icons.arrow_drop_up : Icons.arrow_drop_down, size: 16, color: theme.getZoneText(context)),
        ],
      ),
    );
  }

  Widget _buildFilterHeaderCell(String label, String tag, String activeValue, List options, ValueChanged<String?> onChange, ThemeProvider theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: theme.getZoneText(context))),
        DropdownButton<String>(
          value: options.contains(activeValue)? activeValue : 'All',
          isDense: true,
          underline: Container(),
          dropdownColor: Theme.of(context).cardColor,
          style: TextStyle(color: theme.getListText(context), fontSize: 12),
          items: options.map((opt) => DropdownMenuItem<String>(
            value: opt,
            child: Text(opt, style: TextStyle(color: theme.getListText(context)))
          )).toList(),
          onChanged: (val) => onChange(val as String?),
        ),
      ],
    );
  }

  Future<void> _handlePdfAction(Map<String, dynamic> item, {required bool shareViaSheet}) async {
    final pdf = pw.Document();
    final String englishLyrics = item['English']?? '';
    final String hindiLyrics = item['Hindi']?? '';
    final String malayalamLyrics = item['Malayalam']?? '';

    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Hymn No: ${item['sr']}', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 8),
          pw.Text(item['title']?? 'Untitled', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.Text('Key: ${item['Key']} | Dedicated: ${item['Dedicated']} | Year: ${item['year']}', style: const pw.TextStyle(fontSize: 12)),
          pw.Divider(),
          pw.SizedBox(height: 14),
          if (englishLyrics.isNotEmpty)...[
            pw.Text('English Lyrics:', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.Text(englishLyrics, style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 14),
          ],
          if (hindiLyrics.isNotEmpty)...[
            pw.Text('Hindi Lyrics:', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.Text(hindiLyrics, style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 14),
          ],
          if (malayalamLyrics.isNotEmpty)...[
            pw.Text('Malayalam Lyrics:', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.Text(malayalamLyrics, style: const pw.TextStyle(fontSize: 12)),
          ],
        ],
      );
    }));

    try {
      final bytes = await pdf.save();
      final String filename = 'Hymn_${item['sr']}_${item['title']?.replaceAll(RegExp(r'[^\w\s]'), '')}.pdf';
      await Share.shareXFiles([XFile.fromData(bytes, mimeType: 'application/pdf', name: filename)], text: shareViaSheet? 'Check out this hymn: ${item['title']}' : null);
    } catch (e) {
      print("Error processing PDF: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to generate PDF: $e')));
    }
  }
}