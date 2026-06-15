import 'package:flutter/material.dart';

class HymnDetailScreen extends StatefulWidget {
  final String hymnId;
  final List<Map<String, String>> hymnsList;
  final String currentUserRole;

  const HymnDetailScreen({
    Key? key,
    required this.hymnId,
    required this.hymnsList,
    required this.currentUserRole,
  }) : super(key: key);

  @override
  State<HymnDetailScreen> createState() => _HymnDetailScreenState();
}

class _HymnDetailScreenState extends State<HymnDetailScreen> {
  late PageController _pageController;
  int _fontSize = 16;
  bool _isPresentationMode = false;
  double _baseScaleFactor = 1.0;
  String _lyricsSearchQuery = '';
  bool _isInfoExpanded = false;

  bool _showEnglishColumn = true;
  bool _showHindiColumn = true;
  bool _showMalayalamColumn = true;

  @override
  void initState() {
    super.initState();
    // Find the starting page index matching the incoming hymnId
    int startIndex = widget.hymnsList.indexWhere((h) => h['sr'] == widget.hymnId);
    if (startIndex == -1) startIndex = 0;
    _pageController = PageController(initialPage: startIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) => _baseScaleFactor = _fontSize.toDouble(),
      onScaleUpdate: (details) => setState(() {
        _fontSize = (_baseScaleFactor * details.scale).clamp(12.0, 42.0).toInt();
      }),
      child: Scaffold(
        appBar: _isPresentationMode
            ? null
            : AppBar(
                backgroundColor: Colors.purple,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: 'Search matching keywords in lyric lines...',
                      hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
                      prefixIcon: Icon(Icons.search, color: Colors.white70, size: 18),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _lyricsSearchQuery = val.trim().toLowerCase();
                      });
                    },
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    tooltip: 'Edit Hymn',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Edit Hymn - Coming Soon'),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.slideshow, color: Colors.white),
                    onPressed: () => setState(() {
                      _isPresentationMode = true;
                    }),
                  ),
                ],
              ),
        body: SafeArea(
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical, // Scroll down to reach Page 2, Page 3, etc.
            itemCount: widget.hymnsList.length,
            itemBuilder: (context, pageIndex) {
              final hymn = widget.hymnsList[pageIndex];

              bool hasEnglish = (hymn['English'] ?? '').trim().isNotEmpty;
              bool hasHindi = (hymn['Hindi'] ?? '').trim().isNotEmpty;
              bool hasMalayalam = (hymn['Malayalam'] ?? '').trim().isNotEmpty;

              return Stack(
                children: [
                  Column(
                    children: [
                      if (!_isPresentationMode) ...[
                        Container(
                          width: double.infinity,
                          color: Colors.purple.withOpacity(0.05),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  hymn['title'] ?? 'No Title',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                  ),
                                ),
                                subtitle: Text('Page: ${hymn['page'] ?? 'N/A'} • Year: ${hymn['year'] ?? 'N/A'}'),
                                trailing: IconButton(
                                  icon: Icon(
                                    _isInfoExpanded ? Icons.remove_circle_outline : Icons.add_circle_outline,
                                    color: Colors.purple,
                                  ),
                                  onPressed: () => setState(() => _isInfoExpanded = !_isInfoExpanded),
                                ),
                              ),
                              if (_isInfoExpanded)
                                Padding(
                                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Key: ${hymn['Key'] ?? 'N/A'}',
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'Style: ${hymn['style'] ?? 'N/A'}',
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'Tempo: ${hymn['tempo'] ?? 'N/A'}',
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'Medley: ${hymn['medley'] ?? 'N/A'}',
                                        style: const TextStyle(fontSize: 13, color: Colors.purple, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          color: Colors.white,
                          child: Row(
                            children: [
                              const Text('Reveal Columns: ', style: TextStyle(fontSize: 11, color: Colors.grey)),
                              if (!hasEnglish || !_showEnglishColumn)
                                _buildRevealButton('ENG', () => setState(() => _showEnglishColumn = true)),
                              if (!hasHindi || !_showHindiColumn)
                                _buildRevealButton('HIN', () => setState(() => _showHindiColumn = true)),
                              if (!hasMalayalam || !_showMalayalamColumn)
                                _buildRevealButton('MAL', () => setState(() => _showMalayalamColumn = true)),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                      ],
                      Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: InteractiveViewer(
                        clipBehavior: Clip.none, // Allows zoomed lyrics to use full screen space
                        minScale: 1.0,          // Smallest size allowed
                        maxScale: 4.0,          // Zoom up to 400%
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (hasEnglish && _showEnglishColumn)
                              Expanded(
                                child: _buildLyricsViewportColumn(
                                  'ENGLISH',
                                  hymn['English']!,
                                  () => setState(() => _showEnglishColumn = false),
                                ),
                              ),
                            if (hasEnglish &&
                                _showEnglishColumn &&
                                ((hasHindi && _showHindiColumn) || (hasMalayalam && _showMalayalamColumn)))
                              _buildVerticalDivider(),
                            if (hasHindi && _showHindiColumn)
                              Expanded(
                                child: _buildLyricsViewportColumn(
                                  'HINDI',
                                  hymn['Hindi']!,
                                  () => setState(() => _showHindiColumn = false),
                                ),
                              ),
                            if (hasHindi && _showHindiColumn && (hasMalayalam && _showMalayalamColumn))
                              _buildVerticalDivider(),
                            if (hasMalayalam && _showMalayalamColumn)
                              Expanded(
                                child: _buildLyricsViewportColumn(
                                  'MALAYALAM',
                                  hymn['Malayalam']!,
                                  () => setState(() => _showMalayalamColumn = false),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                    ],
                  ),
                  if (_isPresentationMode)
                    Positioned(
                      top: 16,
                      right: 16,
                      child: FloatingActionButton.small(
                        backgroundColor: Colors.purple.withOpacity(0.6),
                        child: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => setState(() {
                          _isPresentationMode = false;
                        }),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLyricsViewportColumn(String title, String lyricsText, VoidCallback onClose) {
    List<String> textLines = lyricsText.split('\n');
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!_isPresentationMode)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    letterSpacing: 1.2,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 16, color: Colors.red),
                  onPressed: onClose,
                ),
              ],
            ),
          const SizedBox(height: 8),
          ...textLines.map((line) {
            bool matchesSearch = _lyricsSearchQuery.isNotEmpty && line.toLowerCase().contains(_lyricsSearchQuery);
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              decoration: BoxDecoration(
                color: matchesSearch ? Colors.yellow.withOpacity(0.4) : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                line,
                style: TextStyle(
                  fontSize: _fontSize.toDouble(),
                  color: Colors.black,
                  height: 1.6,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRevealButton(String label, VoidCallback onOpen) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: Colors.purple.shade50,
          visualDensity: VisualDensity.compact,
        ),
        icon: const Icon(Icons.add, size: 14, color: Colors.purple),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onOpen,
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 1200,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.grey.shade200,
    );
  }
}