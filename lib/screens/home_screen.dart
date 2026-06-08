import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/hymn_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/hymn_table_widget.dart';
import '../widgets/alphabet_navigation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HymnProvider>().fetchHymnsFromFirebase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zion Songs'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => _showFilterDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => context.push('/favorites'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: Consumer<HymnProvider>(builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null && provider.filteredHymns.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${provider.error}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => provider.fetchHymnsFromFirebase(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return Row(
          children: [
            if (provider.filteredHymns.isNotEmpty)
              AlphabetNavigationWidget(
                letters: provider.getAlphabetLetters(),
                onLetterTap: (letter) {},
              ),
            Expanded(
              child: provider.filteredHymns.isEmpty
                  ? const Center(child: Text('No hymns found'))
                  : HymnTableWidget(
                      hymns: provider.filteredHymns,
                      onHymnTap: (hymn) {
                        context.push('/hymn/${hymn.id}');
                      },
                      onHymnLongPress: (hymn) {
                        _showHymnOptionsMenu(context, hymn.id);
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }

  void _showSearchDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Hymns'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Search by title or lyrics',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            context.read<HymnProvider>().setSearchQuery(value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<HymnProvider>().setSearchQuery('');
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Hymns'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Dedicated To:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Consumer<HymnProvider>(
                builder: (context, provider, _) {
                  final dedicatedOptions = ['APPA', 'AMMA', 'AYYA', 'ANNA', 'SAR', 'CHECHI', 'MIX', 'OTHERS'];
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: dedicatedOptions
                        .map((dedicated) => FilterChip(
                              label: Text(dedicated),
                              selected: provider.filteredHymns.any((h) => h.dedicated == dedicated),
                              onSelected: (_) => provider.toggleDedicatedFilter(dedicated),
                            ))
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text('Sort By:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Consumer<HymnProvider>(
                builder: (context, provider, _) {
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () => provider.setSortBy('title'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: provider.sortBy == 'title' ? Colors.blue : Colors.grey,
                        ),
                        child: const Text('Title'),
                      ),
                      ElevatedButton(
                        onPressed: () => provider.setSortBy('year'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: provider.sortBy == 'year' ? Colors.blue : Colors.grey,
                        ),
                        child: const Text('Year'),
                      ),
                      ElevatedButton(
                        onPressed: () => provider.setSortBy('page'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: provider.sortBy == 'page' ? Colors.blue : Colors.grey,
                        ),
                        child: const Text('Page'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.read<HymnProvider>().clearFilters(),
            child: const Text('Clear All'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showHymnOptionsMenu(BuildContext context, String hymnId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(
                context.read<FavoritesProvider>().isFavorite(hymnId)
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
              title: const Text('Add to Favorites'),
              onTap: () {
                context.read<FavoritesProvider>().toggleFavorite(hymnId);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Favorite updated')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('Export PDF'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
