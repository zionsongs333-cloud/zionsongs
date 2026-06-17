import 'package:flutter/material.dart';

Future<void> showHymnOptionsSheet({
  required BuildContext context,
  required Map<String, dynamic> item,
  required List<String> userFavorites,
  required List<Map<String, dynamic>> churchViewLists,
  required List<Map<String, dynamic>> publicMedleys,
  required String userChurchScope,
  required Future<void> Function() onSaveLists, // Changed to Future

}) async {
  final controller = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (_) => SafeArea(
      child: StatefulBuilder( // lets sheet rebuild
        builder: (ctx, setSheetState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Container(width: 40, height: 4, color: Colors.grey[300]),
                const SizedBox(height: 20),

                // 1. FAVORITES - Local
                ListTile(
                  leading: Icon(userFavorites.contains(item['sr'])? Icons.favorite : Icons.favorite_border, color: Colors.red),
                  title: Text(userFavorites.contains(item['sr'])? 'Remove from Favorites' : 'Add to Favorites'),
                  onTap: () async {
                    setSheetState(() {
                      userFavorites.contains(item['sr'])
                       ? userFavorites.remove(item['sr'])
                        : userFavorites.add(item['sr']);
                    });
                    await onSaveLists(); // await so save finishes before pop
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(userFavorites.contains(item['sr'])
                       ? '${item['title']} added to Favorites'
                        : '${item['title']} removed from Favorites')),
                    );
                  },
                ),

                const Divider(),

                // 2. VIEW LISTS - Church specific
               ...churchViewLists.map((list) => ListTile(
                  leading: const Icon(Icons.playlist_add),
                  title: Text(list['name']?? 'Unnamed'),
                  subtitle: Text('${list['songs']?.length?? 0} songs'),
                  onTap: () async {
                    setSheetState(() {
                      list['songs']??= [];
                      if (!list['songs'].contains(item['sr'])) list['songs'].add(item['sr']);
                    });
                    await onSaveLists();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item['title']} added to ${list['name']}')),
                    );
                  },
                )),

                ListTile(
                  leading: const Icon(Icons.add_circle_outline),
                  title: const Text('Create New View List'),
                  onTap: () => _showCreateDialog(ctx, 'View List', (name) async {
                    setSheetState(() {
                      churchViewLists.add({
                        'name': name,
                        'songs': [item['sr']],
                        'church': userChurchScope, // church specific
                      });
                    });
                    await onSaveLists();
                    Navigator.pop(ctx);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Created "$name" + added hymn')),
                    );
                  }, controller),
                ),

                const Divider(),

                // 3. MEDLEYS - Global
               ...publicMedleys.map((m) => ListTile(
                  leading: const Icon(Icons.queue_music),
                  title: Text(m['name']?? 'Unnamed'),
                  subtitle: Text('${m['songs']?.length?? 0} songs'),
                  onTap: () async {
                    setSheetState(() {
                      m['songs']??= [];
                      if (!m['songs'].contains(item['sr'])) m['songs'].add(item['sr']);
                    });
                    await onSaveLists();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item['title']} added to ${m['name']}')),
                    );
                  },
                )),

                ListTile(
                  leading: const Icon(Icons.add_circle_outline),
                  title: const Text('Create New Medley'),
                  onTap: () => _showCreateDialog(ctx, 'Medley', (name) async {
                    setSheetState(() {
                      publicMedleys.add({
                        'name': name,
                        'songs': [item['sr']], // no church field = global
                      });
                    });
                    await onSaveLists();
                    Navigator.pop(ctx);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Created medley "$name" + added hymn')),
                    );
                  }, controller),
                ),

                // Keep your PDF options
                ListTile(
                  leading: const Icon(Icons.share, color: Color(0xFF0D47A1)),
                  title: const Text('Share PDF', style: TextStyle(color: Color(0xFF0D47A1))),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.picture_as_pdf, color: Color(0xFF0D47A1)),
                  title: const Text('Export PDF', style: TextStyle(color: Color(0xFF0D47A1))),
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    ),
  );
}

// One dialog for both View + Medley
void _showCreateDialog(BuildContext ctx, String type, Function(String) onCreate, TextEditingController c) {
  showDialog(
    context: ctx,
    builder: (dialogContext) => AlertDialog(
      title: Text('New $type Name'),
      content: TextField(
        controller: c,
        decoration: const InputDecoration(hintText: 'Enter name', border: OutlineInputBorder()),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            if (c.text.trim().isEmpty) return;
            onCreate(c.text.trim());
            c.clear();
          },
          child: const Text('Create'),
        ),
      ],
    ),
  );
}