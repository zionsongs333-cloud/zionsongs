
import 'package:flutter/material.dart';
import 'home_search_models.dart';

class HomeSearchResultTile extends StatelessWidget {
  final HomeSearchResult result;
  final VoidCallback? onTap;

  const HomeSearchResultTile({
    super.key,
    required this.result,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          result.srNo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        result.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: result.snippet != null
          ? Text(
              result.snippet!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            )
          : null,
    );
  }
}