import 'package:flutter/material.dart';

Future<void> showHymnOptionsSheet({
  required BuildContext context,
  required Map<String, dynamic> item,
  required List<String> userFavorites,
  required List<Map<String, dynamic>> churchViewLists,
  required List<Map<String, dynamic>> publicMedleys,
  required String userChurchScope,
  required Future<void> Function() onSaveLists,
}) async {
  final controller = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (_) => SafeArea(
      child: StatefulBuilder(
        builder: (ctx, setSheetState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Container(width: 40, height: 4, color: Colors.grey[300]),
                const SizedBox(height: 20),

                // 1. FAVORITES
                ListTile(
                  leading: Icon(userFavorites.contains(item['sr'])? Icons.favorite : Icons.favorite_border, color: Colors.red),
                  title: Text(userFavorites.contains(item['sr'])? 'Remove from Favorites' : 'Add to Favorites'),
                  onTap: () async {
                    setSheetState(() {
                      userFavorites.contains(item['sr'])
                       ? userFavorites.remove(item['sr'])
                        : userFavorites.add(item['sr']);
                    });
                    await onSaveLists();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(userFavorites.contains(item['sr'])
                       ? '${item['title']} added to Favorites'
                        : '${item['title']} removed from Favorites')),
                    );
                  },
                ),

                const Divider(),

                // 2. ADD TO VIEW LIST
                ListTile(
                  leading: const Icon(Icons.playlist_add),
                  title: const Text('Add to View List'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pop(context);
                    _showListPickerDialog(context, 'View List', churchViewLists, item, userChurchScope, onSaveLists, controller, isGlobal: false);
                  },
                ),

                // 3. ADD TO MEDLEY
                ListTile(
                  leading: const Icon(Icons.queue_music),
                  title: const Text('Add to Medley'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pop(context);
                    _showListPickerDialog(context, 'Medley', publicMedleys, item, userChurchScope, onSaveLists, controller, isGlobal: true);
                  },
                ),

                const Divider(),

                // 4. SHARE PDF
                ListTile(
                  leading: const Icon(Icons.share, color: Color(0xFF0D47A1)),
                  title: const Text('Share PDF', style: TextStyle(color: Color(0xFF0D47A1))),
                  onTap: () => Navigator.pop(context),
                ),

                // 5. EXPORT PDF
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

// Dialog with "Create New" + existing lists
void _showListPickerDialog(BuildContext context, String type, List<Map<String, dynamic>> lists, Map<String, dynamic> item, String userChurchScope, Future<void> Function() onSaveLists, TextEditingController controller, {required bool isGlobal}) {
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text('Add to $type'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Create New option
            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: Text('Create New $type'),
              onTap: () => _showCreateDialog(dialogContext, type, (name) async {
                lists.add({
                  'name': name,
                  'songs': [item['sr']],
                  if (!isGlobal) 'church': userChurchScope,
                });
                await onSaveLists();
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Created "$name" + added hymn')),
                );
              }, controller),
            ),
            const Divider(),
            // Existing lists
            Flexible(
              child: lists.isEmpty
               ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('No $type created yet', style: TextStyle(color: Colors.grey[600])),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    itemBuilder: (context, index) {
                      final list = lists[index];
                      return ListTile(
                        leading: Icon(isGlobal? Icons.queue_music : Icons.playlist_play),
                        title: Text(list['name']?? 'Unnamed'),
                        subtitle: Text('${list['songs']?.length?? 0} songs'),
                        onTap: () async {
                          list['songs']??= [];
                          if (!list['songs'].contains(item['sr'])) {
                            list['songs'].add(item['sr']);
                            await onSaveLists();
                            Navigator.pop(dialogContext);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${item['title']} added to ${list['name']}')),
                            );
                          } else {
                            Navigator.pop(dialogContext);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Already in ${list['name']}')),
                            );
                          }
                        },
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
      ],
    ),
  );
}

// One dialog for both View + Medley creation
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