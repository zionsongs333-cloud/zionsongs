import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MedleyProvider extends ChangeNotifier {
  late Box _medleyBox;
  Map<String, List<String>> _medleys = {};

  Map<String, List<String>> get medleys => _medleys;

  MedleyProvider() {
    _initMedleys();
  }

  Future<void> _initMedleys() async {
    _medleyBox = await Hive.openBox('medleys');
    _loadMedleys();
  }

  void _loadMedleys() {
    final data = _medleyBox.get('medleys', defaultValue: {});
    _medleys = Map<String, List<String>>.from(
      (data as Map).map((key, value) => MapEntry(key, List<String>.from(value)))
    );
    notifyListeners();
  }

  Future<void> createMedley(String name, List<String> hymnIds) async {
    _medleys[name] = hymnIds;
    await _medleyBox.put('medleys', _medleys);
    notifyListeners();
  }

  Future<void> addToMedley(String medleyName, String hymnId) async {
    if (_medleys.containsKey(medleyName)) {
      if (!_medleys[medleyName]!.contains(hymnId)) {
        _medleys[medleyName]!.add(hymnId);
        await _medleyBox.put('medleys', _medleys);
        notifyListeners();
      }
    }
  }

  Future<void> removeFromMedley(String medleyName, String hymnId) async {
    if (_medleys.containsKey(medleyName)) {
      _medleys[medleyName]!.remove(hymnId);
      await _medleyBox.put('medleys', _medleys);
      notifyListeners();
    }
  }

  Future<void> deleteMedley(String name) async {
    _medleys.remove(name);
    await _medleyBox.put('medleys', _medleys);
    notifyListeners();
  }

  List<String> getMedleyNames() {
    return _medleys.keys.toList();
  }
}
