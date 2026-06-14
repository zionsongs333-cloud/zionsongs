Future<void> _loadSongsFromFirestore() async {
  final snapshot = await FirebaseFirestore.instance.collection('hymns').get();
  print("Firestore docs found: ${snapshot.docs.length}");

  final songs = snapshot.docs.map((doc) {
    final data = doc.data();
    final lyrics = data['lyrics'] ?? {};
    
    final hindiText = (lyrics['Hindi'] ?? '').toString();
    final existingEng = (lyrics['English'] ?? '').toString();
    final malayalamText = (lyrics['Malayalam'] ?? '').toString();
    
    // Generate English transliteration if empty
    final generatedEng = existingEng.isEmpty && hindiText.isNotEmpty
        ? transliterator.transliterate(text: hindiText, toLanguageCode: 'en')
        : existingEng;

    return {
      'sr': data['sr']?.toString() ?? '',
      'title': data['title']?.toString() ?? '',
      'Key': data['Key']?.toString() ?? '',
      'Dedicated': data['Dedicated']?.toString() ?? '',
      'year': data['year']?.toString() ?? '',
      'page': data['page']?.toString() ?? '',
      'style': data['style']?.toString() ?? '',
      'tempo': data['tempo']?.toString() ?? '',
      'English': generatedEng, // Now: "Taba ekmatra naam hai..."
      'Hindi': hindiText,
      'Malayalam': malayalamText,
    };
  }).toList();

  setState(() {
    staticExcelHymns = songs;
    _loadingSongs = false;
  });
}