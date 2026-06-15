import 'package:flutter/material.dart';

class AlphabetNavigationWidget extends StatelessWidget {
  final List<String> letters;
  final Function(String) onLetterTap;

  const AlphabetNavigationWidget({
    super.key, 
    required this.letters, 
    required this.onLetterTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: letters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            key: ValueKey(letters[index]),
            child: ChoiceChip(
              label: Text(letters[index]),
              selected: false,
              onSelected: (_) => onLetterTap(letters[index]),
            ),
          );
        },
      ),
    );
  }
}
