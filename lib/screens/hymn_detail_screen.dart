import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/hymn_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/hymn_display_widget.dart';

class HymnDetailScreen extends StatefulWidget {
  final String hymnId;

  const HymnDetailScreen({Key? key, required this.hymnId}) : super(key: key);

  @override
  State<HymnDetailScreen> createState() => _HymnDetailScreenState();
}

class _HymnDetailScreenState extends State<HymnDetailScreen> {
  int _fontSize = 16;
  bool _showChords = false;
  int _transpose = 0;

  @override
  Widget build(BuildContext context) {
    final hymn = context.read<HymnProvider>().getHymnById(widget.hymnId);

    if (hymn == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Hymn Not Found')),
        body: const Center(child: Text('Hymn not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(hymn.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            icon: Icon(
              context.read<FavoritesProvider>().isFavorite(hymn.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: () {
              context.read<FavoritesProvider>().toggleFavorite(hymn.id);
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hymn Metadata
            Container(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hymn.sr != null)
                    Text('SR: ${hymn.sr}', style: const TextStyle(fontSize: 14)),
                  if (hymn.year != null)
                    Text('Year: ${hymn.year}', style: const TextStyle(fontSize: 14)),
                  if (hymn.dedicated != null)
                    Text('Dedicated: ${hymn.dedicated}', style: const TextStyle(fontSize: 14)),
                  if (hymn.tempo != null)
                    Text('Tempo: ${hymn.tempo}', style: const TextStyle(fontSize: 14)),
                  if (hymn.key != null)
                    Text('Key: ${hymn.key}', style: const TextStyle(fontSize: 14)),
                  if (hymn.page != null)
                    Text('Page: ${hymn.page}', style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Font Size Controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_fontSize > 12) _fontSize--;
                      });
                    },
                  ),
                  Expanded(
                    child: Slider(
                      value: _fontSize.toDouble(),
                      min: 12,
                      max: 32,
                      divisions: 20,
                      label: '$_fontSize',
                      onChanged: (value) {
                        setState(() {
                          _fontSize = value.toInt();
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        if (_fontSize < 32) _fontSize++;
                      });
                    },
                  ),
                ],
              ),
            ),
            // Transpose Controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text('Transpose:'),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_transpose > -12) _transpose--;
                      });
                    },
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      _transpose > 0 ? '+$_transpose' : '$_transpose',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        if (_transpose < 12) _transpose++;
                      });
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      _showChords ? Icons.visibility : Icons.visibility_off,
                    ),
                    tooltip: _showChords ? 'Hide Chords' : 'Show Chords',
                    onPressed: () {
                      setState(() {
                        _showChords = !_showChords;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Hymn Display
            HymnDisplayWidget(
              hymn: hymn,
              fontSize: _fontSize,
              showChords: _showChords,
              transpose: _transpose,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
