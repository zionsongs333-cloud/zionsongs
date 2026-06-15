class StaticHymn {
  final String id;
  final String title;
  final int page;
  final int year;
  final Map<String, String> lyrics; // Changed from String to Map
  final String dedicated;

  const StaticHymn({
    required this.id,
    required this.title,
    required this.page,
    required this.year,
    required this.lyrics,
    required this.dedicated,
  });
}

const List<StaticHymn> localHymnsDataset = [
  StaticHymn(
    id: "1", 
    title: "Amazing Grace", 
    page: 45, 
    year: 1779, 
    dedicated: "APPA",
    lyrics: {
      "English": "Amazing grace, how sweet the sound...",
      "Hindi": "अद्भुत अनुग्रह, कितना मधुर स्वर...",
      "Malayalam": "അത്ഭുത കൃപ എത്ര മധുരം..."
    }
  ),
  StaticHymn(
    id: "2", 
    title: "How Great Thou Art", 
    page: 12, 
    year: 1949, 
    dedicated: "AMMA",
    lyrics: {
      "English": "O Lord my God, when I in awesome wonder...",
      "Hindi": "हे प्रभु मेरे परमेश्वर...",
      "Malayalam": "എൻ ദൈവമേ ഞാൻ ഓർക്കുമ്പോൾ..."
    }
  ),
  // Placeholder entries for remaining slots to prevent compiling failures
  StaticHymn(id: "3", title: "Song Three", page: 3, year: 2024, dedicated: "AYYA", lyrics: {"English": "Lyrics", "Hindi": "लिरिक्स", "Malayalam": "വരികൾ"}),
  StaticHymn(id: "4", title: "Song Four", page: 4, year: 2024, dedicated: "ANNA", lyrics: {"English": "Lyrics", "Hindi": "लिरिक्स", "Malayalam": "വരികൾ"}),
  StaticHymn(id: "5", title: "Song Five", page: 5, year: 2024, dedicated: "SAR", lyrics: {"English": "Lyrics", "Hindi": "लिरिक्स", "Malayalam": "വരികൾ"}),
  StaticHymn(id: "6", title: "Song Six", page: 6, year: 2024, dedicated: "CHECHI", lyrics: {"English": "Lyrics", "Hindi": "लिरिक्स", "Malayalam": "വരികൾ"}),
  StaticHymn(id: "7", title: "Song Seven", page: 7, year: 2024, dedicated: "MIX", lyrics: {"English": "Lyrics", "Hindi": "लिरिक्स", "Malayalam": "വരികൾ"}),
  StaticHymn(id: "8", title: "Song Eight", page: 8, year: 2024, dedicated: "OTHERS", lyrics: {"English": "Lyrics", "Hindi": "लिरिक्स", "Malayalam": "വരികൾ"}),
  StaticHymn(id: "9", title: "Song Nine", page: 9, year: 2024, dedicated: "APPA", lyrics: {"English": "Lyrics", "Hindi": "लिरिक्स", "Malayalam": "വരികൾ"}),
  StaticHymn(id: "10", title: "Song Ten", page: 10, year: 2024, dedicated: "AMMA", lyrics: {"English": "Lyrics", "Hindi": "लिरिक्स", "Malayalam": "വരികൾ"}),
];
