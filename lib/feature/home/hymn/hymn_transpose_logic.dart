import 'hymn_models.dart';

class HymnTransposeLogic { 
  static const List<String> _chromaticSharps = ['C','C#','D','D#','E','F','F#','G','G#','A','A#','B']; 
  static const List<String> _chromaticFlats = ['C','Db','D','Eb','E','F','Gb','G','Ab','A','Bb','B']; 
  static const Map<String,String> _flatToSharp = {'Db':'C#','Eb':'D#','Gb':'F#','Ab':'G#','Bb':'A#'}; 
  static const Map<String,String> _sharpToFlat = {'C#':'Db','D#':'Eb','F#':'Gb','G#':'Ab','A#':'Bb'}; 
  static final RegExp _chordLineRegex = RegExp(r'^\s*([A-G][#b]?(m|min|maj|dim|aug|sus|add)?[0-9]*(maj|min)?[0-9]?(/[A-G][#b]?)?\s*)+$'); 
  static final RegExp _headingRegex = RegExp(r'^(Intro|Verse|Chorus|Bridge|Tag|Ending|Interlude|Pre-Chorus)', caseSensitive: false); 
  static final RegExp _chordRegex = RegExp(r'([A-G][#b]?)(m|min|maj|dim|aug|sus|add)?[0-9]*(maj|min)?[0-9]*(/[A-G][#b]?)?'); 
  
  static Future<void> savePref(UserHymnPref pref) async { 
    pref.modifiedOn = now(); 
    await pref.isar!.writeTxn(() => pref.isar!.userHymnPrefs.put(pref)); 
  } 
  
  static String? detectKey(String lyrics) { 
    for (var line in lyrics.split('\n').skip(4)) { 
      if(_headingRegex.hasMatch(line)) continue; 
      if(_chordLineRegex.hasMatch(line)) { 
        var m = _chordRegex.allMatches(line); 
        if(m.isNotEmpty) return _normalize(m.first.group(1)!, false); 
      } 
      return null; 
    } 
    return null;
  } 
  
  static String _normalize(String key, bool preferFlats) => 
    preferFlats? _sharpToFlat[key]?? key : _flatToSharp[key]?? key; 
  
  static String transpose(String key, int offset, bool preferFlats) { 
    key = _flatToSharp[key]?? key; 
    int i = _chromaticSharps.indexOf(key); 
    if(i == -1) return key; 
    int n = (i + offset) % 12; 
    if(n < 0) n += 12; 
    return _normalize(_chromaticSharps[n], preferFlats); 
  } 
  
  static String reverseTranspose(String displayedKey, int offset, bool preferFlats) => 
    transpose(displayedKey, -offset, preferFlats); 
  
  static String transposeLyrics(String lyrics, int offset, bool preferFlats) => 
    lyrics.split('\n').map((line){ 
      if(_headingRegex.hasMatch(line)) return line; 
      if(_chordLineRegex.hasMatch(line)) { 
        return line.replaceAllMapped(_chordRegex, (m){ 
          String r = m.group(1)!; 
          String s = m.group(2)??''; 
          String n = m.group(3)??''; 
          String b = m.group(4)??''; 
          return '${transpose(r, offset, preferFlats)}$s$n${b.isEmpty? '' : '/${transpose(b.substring(1), offset, preferFlats)}'}'; 
        }); 
      } 
      return line; 
    }).join('\n'); 
  
  static List<String> getScale(bool preferFlats) => 
    preferFlats? _chromaticFlats : _chromaticSharps; 
}