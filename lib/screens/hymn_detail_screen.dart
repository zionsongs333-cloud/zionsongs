import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

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
    final theme = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onScaleStart: (details) => _baseScaleFactor = _fontSize.toDouble(),
      onScaleUpdate: (details) => setState(() {
        _fontSize = (_baseScaleFactor * details.scale).clamp(12.0, 42.0).toInt();
      }),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [theme.getListStart(context), theme.getListEnd(context)],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _isPresentationMode
             ? null
              : AppBar(
                  backgroundColor: theme.getZoneBg(context),
                  iconTheme: IconThemeData(color: theme.getZoneText(context)),
                  title: Text('Hymn Viewer', style: TextStyle(color: theme.getZoneText(context))),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.edit, color: theme.getZoneText(context)),
                      tooltip: 'Edit Hymn',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Edit Hymn - Coming Soon')),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.slideshow, color: theme.getZoneText(context)),
                      onPressed: () => setState(() {
                        _isPresentationMode = true;
                      }),
                    ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(50),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: theme.getZoneBg(context).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          style: TextStyle(color: theme.getZoneText(context), fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Search matching keywords in lyric lines...',
                            hintStyle: TextStyle(color: theme.getZoneTextUnselected(context), fontSize: 14),
                            prefixIcon: Icon(Icons.search, color: theme.getZoneTextUnselected(context), size: 18),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          onChanged: (val) {
                            setState(() {
                              _lyricsSearchQuery = val.trim().toLowerCase();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
          body: SafeArea(
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: widget.hymnsList.length,
              itemBuilder: (context, pageIndex) {
                final hymn = widget.hymnsList[pageIndex];
                final textColor = theme.getListText(context);

                bool hasEnglish = (hymn['English']?? '').trim().isNotEmpty;
                bool hasHindi = (hymn['Hindi']?? '').trim().isNotEmpty;
                bool hasMalayalam = (hymn['Malayalam']?? '').trim().isNotEmpty;

                return Stack(
                  children: [
                    Column(
                      children: [
                        if (!_isPresentationMode)...[
                          Container(
                            width: double.infinity,
                            color: theme.getZoneBg(context).withOpacity(0.1),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    hymn['title']?? 'No Title',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Page: ${hymn['page']?? 'N/A'} • Year: ${hymn['year']?? 'N/A'}',
                                    style: TextStyle(color: textColor.withOpacity(0.8)),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      _isInfoExpanded? Icons.remove_circle_outline : Icons.add_circle_outline,
                                      color: theme.getZoneText(context),
                                    ),
                                    onPressed: () => setState(() => _isInfoExpanded =!_isInfoExpanded),
                                  ),
                                ),
                                if (_isInfoExpanded)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                                    child: Wrap(
                                      spacing: 16,
                                      children: [
                                        Text('Key: ${hymn['Key']?? 'N/A'}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: textColor)),
                                        Text('Style: ${hymn['style']?? 'N/A'}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: textColor)),
                                        Text('Tempo: ${hymn['tempo']?? 'N/A'}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: textColor)),
                                        Text('Medley: ${hymn['medley']?? 'N/A'}', style: TextStyle(fontSize: 13, color: theme.getZoneText(context), fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            color: theme.getZoneBg(context).withOpacity(0.2),
                            child: Row(
                              children: [
                                Text('Reveal Columns: ', style: TextStyle(fontSize: 11, color: textColor.withOpacity(0.7))),
                                if (!hasEnglish ||!_showEnglishColumn)
                                  _buildRevealButton('ENG', () => setState(() => _showEnglishColumn = true), theme),
                                if (!hasHindi ||!_showHindiColumn)
                                  _buildRevealButton('HIN', () => setState(() => _showHindiColumn = true), theme),
                                if (!hasMalayalam ||!_showMalayalamColumn)
                                  _buildRevealButton('MAL', () => setState(() => _showMalayalamColumn = true), theme),
                              ],
                            ),
                          ),
                          Divider(height: 1, color: theme.getZoneTextUnselected(context)),
                        ],
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: InteractiveViewer(
                              clipBehavior: Clip.none,
                              minScale: 1.0,
                              maxScale: 4.0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (hasEnglish && _showEnglishColumn)
                                    Expanded(
                                      child: _buildLyricsViewportColumn(
                                        'ENGLISH',
                                        hymn['English']!,
                                        () => setState(() => _showEnglishColumn = false),
                                        textColor,
                                        theme,
                                      ),
                                    ),
                                  if (hasEnglish && _showEnglishColumn && ((hasHindi && _showHindiColumn) || (hasMalayalam && _showMalayalamColumn)))
                                    _buildVerticalDivider(theme),
                                  if (hasHindi && _showHindiColumn)
                                    Expanded(
                                      child: _buildLyricsViewportColumn(
                                        'HINDI',
                                        hymn['Hindi']!,
                                        () => setState(() => _showHindiColumn = false),
                                        textColor,
                                        theme,
                                      ),
                                    ),
                                  if (hasHindi && _showHindiColumn && (hasMalayalam && _showMalayalamColumn))
                                    _buildVerticalDivider(theme),
                                  if (hasMalayalam && _showMalayalamColumn)
                                    Expanded(
                                      child: _buildLyricsViewportColumn(
                                        'MALAYALAM',
                                        hymn['Malayalam']!,
                                        () => setState(() => _showMalayalamColumn = false),
                                        textColor,
                                        theme,
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
                          backgroundColor: theme.getZoneBg(context).withOpacity(0.6),
                          child: Icon(Icons.close, color: theme.getZoneText(context)),
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
      ),
    );
  }

  Widget _buildLyricsViewportColumn(String title, String lyricsText, VoidCallback onClose, Color textColor, ThemeProvider theme) {
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
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: theme.getZoneText(context),
                    letterSpacing: 1.2,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 16, color: Colors.red),
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
                color: matchesSearch? Colors.yellow.withOpacity(0.4) : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                line,
                style: TextStyle(
                  fontSize: _fontSize.toDouble(),
                  color: textColor,
                  height: 1.6,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRevealButton(String label, VoidCallback onOpen, ThemeProvider theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: theme.getZoneBg(context).withOpacity(0.3),
          visualDensity: VisualDensity.compact,
        ),
        icon: Icon(Icons.add, size: 14, color: theme.getZoneText(context)),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: theme.getZoneText(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onOpen,
      ),
    );
  }

  Widget _buildVerticalDivider(ThemeProvider theme) {
    return Container(
      width: 1,
      height: 1200,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: theme.getZoneTextUnselected(context).withOpacity(0.3),
    );
  }
}