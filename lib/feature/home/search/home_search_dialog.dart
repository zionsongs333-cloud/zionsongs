import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'home_search_controller.dart';
import 'home_search_repository.dart';
import 'home_search_result_tile.dart';
import '../hymn/hymn_detail_page.dart';

class HomeSearchDialog extends StatefulWidget {
  const HomeSearchDialog({super.key, required this.isar});

  final Isar isar;

  @override
  State<HomeSearchDialog> createState() => _HomeSearchDialogState();
}

class _HomeSearchDialogState extends State<HomeSearchDialog> {
  late final HomeSearchController _controller;

  @override
  void initState() {
    super.initState();

    _controller = HomeSearchController(
      repository: HomeSearchRepository(isar: widget.isar),
    );

    _controller.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_refresh);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .8,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Search hymns',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: _controller.onQueryChanged,
                ),
              ),

              if (_controller.loading) const CircularProgressIndicator(),

              Expanded(
                child: ListView.builder(
                  itemCount: _controller.results.length,
                  itemBuilder: (_, index) {
                    return HomeSearchResultTile(
                      result: _controller.results[index],
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => HymnDetailPage(
                              hymnId: _controller.results[index].srNo,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
