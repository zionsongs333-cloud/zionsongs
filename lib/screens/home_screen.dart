import 'dart:convert';
import 'package:flutter_transliterator/flutter_transliterator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'hymn_detail_screen.dart';

String _toSimpleSound(String text) {
  return text
    .toLowerCase()
    .replaceAll(RegExp(r'[^\w\s\u0900-\u097F]'), ' ')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();
}

String _romanToHindi(String text) {
  return FlutterTransliterator().transliterate(
    text: text,
    toLanguageCode: 'hi',
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _currentUserRole = 'Admin'; 
  String _userChurchScope = 'Grace Church Mumbai';
  String _searchQuery = '';
  String _filterKey = 'All';
  String _filterDedicated = 'All';
  String _filterYear = 'All';
  String _currentSortTag = 'sr';
  bool _isAscending = true;

  List<String> userFavorites = ['1'];
  List<Map<String, dynamic>> churchViewLists = [
    {'name': 'Sunday Morning Praise', 'church': 'Grace Church Mumbai', 'songs': ['2', '3']},
  ];
  List<Map<String, dynamic>> publicMedleys = [
    {'name': 'Cross & Grace Medley', 'songs': ['1', '3']},
  ];

  List<Map<String, dynamic>> staticExcelHymns = [];
  bool _loadingSongs = true;
  Future<void> _loadSongsFromFirestore() async {
  final snapshot =
      await FirebaseFirestore.instance.collection('hymns').get();
      print("Firestore docs found: ${snapshot.docs.length}");

  final songs = snapshot.docs.map((doc) {
    print(doc.data());
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
  print(staticExcelHymns.first);
}
     @override
void initState() {
  super.initState();
    print("HOME SCREEN OPENED");
  _tabController = TabController(length: 4, vsync: this);
  _loadSongsFromFirestore();
}

  void _resetAllFilters() {
    setState(() {
      _searchQuery = ''; _filterKey = 'All'; _filterDedicated = 'All';
      _filterYear = 'All'; _currentSortTag = 'sr'; _isAscending = true;
    });
  }

  void _createNewListDialog(String listType) {
    if (_currentUserRole == 'Viewer' && listType == 'Medley') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('❌ Error: Viewers cannot create Public Medleys.')));
      return;
    }
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create New $listType'),
        content: TextField(controller: controller, decoration: const InputDecoration(hintText: 'Enter list name...')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  if (listType == 'View Listing') {
                    churchViewLists.add({'name': controller.text.trim(), 'church': _userChurchScope, 'songs': <String>[]});
                  } else if (listType == 'Medley') {
                    publicMedleys.add({'name': controller.text.trim(), 'songs': <String>[]});
                  }
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
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
  @override
  Widget build(BuildContext context) {
    List<String> dynamicKeys =
    ['All'] + staticExcelHymns.map((h) => h['Key'].toString()).toSet().toList();

List<String> dynamicDedicated =
    ['All'] + staticExcelHymns.map((h) => h['Dedicated'].toString()).toSet().toList();

List<String> dynamicYears =
    ['All'] + staticExcelHymns.map((h) => h['year'].toString()).toSet().toList();
    
    final filteredHymns = staticExcelHymns.where((h) {
  if (_filterKey != 'All' &&
      h['Key'].toString() != _filterKey) {
    return false;
  }

  if (_filterDedicated != 'All' &&
      h['Dedicated'].toString() != _filterDedicated) {
    return false;
  }

  if (_filterYear != 'All' &&
      h['year'].toString() != _filterYear) {
    return false;
  }

  if (_searchQuery.isNotEmpty) {
    final q = _searchQuery.toLowerCase().trim();

    return h['title']
            .toString()
            .toLowerCase()
            .contains(q) ||
        h['English']
            .toString()
            .toLowerCase()
            .contains(q) ||
        h['Hindi']
            .toString()
            .toLowerCase()
            .contains(q) ||
        h['Malayalam']
    .toString()
    .toLowerCase()
    .contains(q) ||
h['searchText']
    .toString()
    .toLowerCase()
    .contains(q);
  }

  return true;
}).toList();

  
    return Scaffold(
      floatingActionButton:
    (_currentUserRole == 'Admin' || _currentUserRole == 'Super Admin')
        ? FloatingActionButton(
            backgroundColor: Colors.purple,
            child: const Icon(Icons.add),
            onPressed: () async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        _currentUserRole == 'Super Admin'
            ? 'Import JSON feature will be connected here'
            : 'Add New Hymn feature coming soon',
      ),
    ),
  );
},
          )
        : null,
      appBar: AppBar(
        title: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _currentUserRole,
            dropdownColor: Colors.purple,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            items: ['Viewer', 'Admin', 'Super Admin'].map((r) => DropdownMenuItem(value: r, child: Text('Role: $r'))).toList(),
            onChanged: (val) => setState(() => _currentUserRole = val!),
          ),
        ),
        backgroundColor: Colors.purple,
        actions: [
          if (_currentUserRole == 'Super Admin')
            IconButton(
              icon: const Icon(Icons.history, color: Colors.white),
              tooltip: "Restore Version History",
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('⏳ Restoring to last valid backup log point...'))),
            ),
          IconButton(icon: const Icon(Icons.refresh, color: Colors.white), tooltip: "Reset All Filters", onPressed: _resetAllFilters),
        IconButton(
  icon: const Icon(Icons.bug_report, color: Colors.white),
 onPressed: () {
  final t = FlutterTransliterator();

  final result = t.transliterate(
  text: 'sab',
  toLanguageCode: 'hi',
);

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(result)),
);

  print(
    t.transliterate(
      text: 'sabse',
      toLanguageCode: 'hi',
    ),
  );
},
),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [Tab(text: 'All Hymns'), Tab(text: 'Favorites'), Tab(text: 'View Listing'), Tab(text: 'Medleys')],
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
  decoration: InputDecoration(
    hintText: 'Search hymns...',
    prefixIcon: const Icon(Icons.search),
    border: const OutlineInputBorder(),
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
          Padding(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  child: Text('Results: ${hymns.length}', style: const TextStyle(color: Colors.red, fontSize: 14)),
),
        Container(
          color: Colors.purple.shade50,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Expanded(flex: 1, child: _buildHeaderCell('SR', 'sr')),
              Expanded(flex: 4, child: _buildHeaderCell('TITLE', 'title')),
              Expanded(flex: 2, child: _buildFilterHeaderCell('KEY', 'Key', _filterKey, keys, (val) => setState(() { _filterKey = val!; }))),
              Expanded(flex: 2, child: _buildFilterHeaderCell('DEDICATED', 'Dedicated', _filterDedicated, dedicated, (val) => setState(() { _filterDedicated = val!; }))),
              Expanded(flex: 2, child: _buildFilterHeaderCell('YEAR', 'year', _filterYear, years, (val) => setState(() { _filterYear = val!; }))),
              Expanded(flex: 1, child: Align(alignment: Alignment.centerRight, child: _buildHeaderCell('PAGE', 'page'))),
            ],
          ),
        ),
        Expanded(
          child: hymns.isEmpty
              ? const Center(child: Text('No matching items found.'))
              : ListView.builder(
                  itemCount: hymns.length,
                  itemBuilder: (context, index) {
                    final item = hymns[index];
                    
                    // Get 2 line preview from Hindi lyrics when searching
String preview = '';

if (_searchQuery.isNotEmpty) {
  final hindi = item['Hindi']?.toString() ?? '';

  if (hindi.isNotEmpty) {
    preview = hindi.length > 120
        ? '${hindi.substring(0, 120)}...'
        : hindi;
  }
}


return InkWell(
  onTap: () => context.push('/hymn/${item['sr']}', extra: staticExcelHymns),
  child: Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(flex: 1, child: Text(item['sr']!, style: const TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 4, child: Text(item['title']!, style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.w500))),
            Expanded(flex: 2, child: Text(item['Key']!)),
            Expanded(flex: 2, child: Text(item['Dedicated']!)),
            Expanded(flex: 2, child: Text(item['year']!)),
            Expanded(flex: 1, child: Align(alignment: Alignment.centerRight, child: Text(item['page']!, style: const TextStyle(fontWeight: FontWeight.bold)))),
          ],
        ),
        if (_searchQuery.isNotEmpty && preview.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 40),
            child: Text(
              preview,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: Colors.grey[600], fontStyle: FontStyle.italic),
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
      trailing: ElevatedButton.icon(
        onPressed: () => _createNewListDialog('View Listing'), 
        icon: const Icon(Icons.add), 
        label: const Text('New List')
      ),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Clicked ${l['name']}')),
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
        trailing: ElevatedButton.icon(
          onPressed: () => _createNewListDialog('Medley'),
          icon: const Icon(Icons.add),
          label: const Text('New Medley'),
        ),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Clicked ${m['name']}')),
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
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.purple)),
      if (_currentSortTag == tag) Icon(_isAscending ? Icons.arrow_drop_up : Icons.arrow_drop_down, size: 16, color: Colors.purple),
    ]),
  );
} // <-- CLOSE _buildHeaderCell

Widget _buildFilterHeaderCell(String label, String tag, String activeValue, List options, ValueChanged<String?> onChange) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
    Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.purple)),
    DropdownButton<String>(  // <-- Add <String> here
      value: options.contains(activeValue) ? activeValue : 'All',
      isDense: true,
      underline: Container(),
      items: options.map((opt) => DropdownMenuItem<String>(value: opt, child: Text(opt, style: const TextStyle(fontSize: 12)))).toList(), // <-- Add <String> here too
      onChanged: (val) => onChange(val as String?), // <-- Change this line
    ),
  ]);
}// <-- CLOSE _buildFilterHeaderCell

} // <-- ADD THIS: CLOSES _HomeScreenState class