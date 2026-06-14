import 'package:flutter/material.dart';

class HymnTableWidget extends StatelessWidget {
  final List hymns;
  final Function(dynamic) onHymnTap;
  final Function(dynamic) onHymnLongPress;

  const HymnTableWidget({
    super.key, 
    required this.hymns, 
    required this.onHymnTap, 
    required this.onHymnLongPress
  });

  @override
  Widget build(BuildContext context) {
    if (hymns.isEmpty) {
      return const Center(child: Text('No hymns available', style: TextStyle(color: Colors.black)));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: hymns.length,
      itemBuilder: (context, index) {
        final hymn = hymns[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.purple.shade100,
            child: Text('${hymn.page ?? index + 1}', style: const TextStyle(color: Colors.purple)),
          ),
          title: Text(hymn.title ?? 'Untitled Song', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          subtitle: Text('Year: ${hymn.year ?? "N/A"}', style: TextStyle(color: Colors.grey.shade600)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: () => onHymnTap(hymn),
          onLongPress: () => onHymnLongPress(hymn),
        );
      },
    );
  }
}
