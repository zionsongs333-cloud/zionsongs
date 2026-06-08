import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'hymn_model.g.dart';

@HiveType(typeId: 0)
class HymnModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String lyrics;

  @HiveField(3)
  final int? sr;

  @HiveField(4)
  final int? year;

  @HiveField(5)
  final int? page;

  @HiveField(6)
  final String? key;

  @HiveField(7)
  final int? tempo;

  @HiveField(8)
  final String? style;

  @HiveField(9)
  final String? dedicated;

  @HiveField(10)
  final String? majMin;

  @HiveField(11)
  final String? chords;

  @HiveField(12)
  final DateTime? createdAt;

  @HiveField(13)
  final DateTime? updatedAt;

  HymnModel({
    required this.id,
    required this.title,
    required this.lyrics,
    this.sr,
    this.year,
    this.page,
    this.key,
    this.tempo,
    this.style,
    this.dedicated,
    this.majMin,
    this.chords,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'lyrics': lyrics,
      'sr': sr,
      'year': year,
      'page': page,
      'key': key,
      'tempo': tempo,
      'style': style,
      'dedicated': dedicated,
      'majMin': majMin,
      'chords': chords,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory HymnModel.fromMap(Map<String, dynamic> map) {
    return HymnModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      lyrics: map['lyrics'] ?? '',
      sr: map['sr'],
      year: map['year'],
      page: map['page'],
      key: map['key'],
      tempo: map['tempo'],
      style: map['style'],
      dedicated: map['dedicated'],
      majMin: map['majMin'],
      chords: map['chords'],
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  HymnModel copyWith({
    String? id,
    String? title,
    String? lyrics,
    int? sr,
    int? year,
    int? page,
    String? key,
    int? tempo,
    String? style,
    String? dedicated,
    String? majMin,
    String? chords,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HymnModel(
      id: id ?? this.id,
      title: title ?? this.title,
      lyrics: lyrics ?? this.lyrics,
      sr: sr ?? this.sr,
      year: year ?? this.year,
      page: page ?? this.page,
      key: key ?? this.key,
      tempo: tempo ?? this.tempo,
      style: style ?? this.style,
      dedicated: dedicated ?? this.dedicated,
      majMin: majMin ?? this.majMin,
      chords: chords ?? this.chords,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
