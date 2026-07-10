// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymn_models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalHymnCollection on Isar {
  IsarCollection<LocalHymn> get localHymns => this.collection();
}

const LocalHymnSchema = CollectionSchema(
  name: r'LocalHymn',
  id: -2966682661491146710,
  properties: {
    r'createdOn': PropertySchema(
      id: 0,
      name: r'createdOn',
      type: IsarType.long,
    ),
    r'hymnId': PropertySchema(
      id: 1,
      name: r'hymnId',
      type: IsarType.string,
    ),
    r'modifiedOn': PropertySchema(
      id: 2,
      name: r'modifiedOn',
      type: IsarType.long,
    ),
    r'originalLyrics': PropertySchema(
      id: 3,
      name: r'originalLyrics',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 4,
      name: r'title',
      type: IsarType.string,
    ),
    r'version': PropertySchema(
      id: 5,
      name: r'version',
      type: IsarType.long,
    )
  },
  estimateSize: _localHymnEstimateSize,
  serialize: _localHymnSerialize,
  deserialize: _localHymnDeserialize,
  deserializeProp: _localHymnDeserializeProp,
  idName: r'id',
  indexes: {
    r'hymnId': IndexSchema(
      id: -3067022437716651328,
      name: r'hymnId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'hymnId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _localHymnGetId,
  getLinks: _localHymnGetLinks,
  attach: _localHymnAttach,
  version: '3.1.0+1',
);

int _localHymnEstimateSize(
  LocalHymn object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.hymnId.length * 3;
  bytesCount += 3 + object.originalLyrics.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _localHymnSerialize(
  LocalHymn object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.createdOn);
  writer.writeString(offsets[1], object.hymnId);
  writer.writeLong(offsets[2], object.modifiedOn);
  writer.writeString(offsets[3], object.originalLyrics);
  writer.writeString(offsets[4], object.title);
  writer.writeLong(offsets[5], object.version);
}

LocalHymn _localHymnDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalHymn();
  object.createdOn = reader.readLong(offsets[0]);
  object.hymnId = reader.readString(offsets[1]);
  object.id = id;
  object.modifiedOn = reader.readLong(offsets[2]);
  object.originalLyrics = reader.readString(offsets[3]);
  object.title = reader.readString(offsets[4]);
  object.version = reader.readLong(offsets[5]);
  return object;
}

P _localHymnDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _localHymnGetId(LocalHymn object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _localHymnGetLinks(LocalHymn object) {
  return [];
}

void _localHymnAttach(IsarCollection<dynamic> col, Id id, LocalHymn object) {
  object.id = id;
}

extension LocalHymnByIndex on IsarCollection<LocalHymn> {
  Future<LocalHymn?> getByHymnId(String hymnId) {
    return getByIndex(r'hymnId', [hymnId]);
  }

  LocalHymn? getByHymnIdSync(String hymnId) {
    return getByIndexSync(r'hymnId', [hymnId]);
  }

  Future<bool> deleteByHymnId(String hymnId) {
    return deleteByIndex(r'hymnId', [hymnId]);
  }

  bool deleteByHymnIdSync(String hymnId) {
    return deleteByIndexSync(r'hymnId', [hymnId]);
  }

  Future<List<LocalHymn?>> getAllByHymnId(List<String> hymnIdValues) {
    final values = hymnIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'hymnId', values);
  }

  List<LocalHymn?> getAllByHymnIdSync(List<String> hymnIdValues) {
    final values = hymnIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'hymnId', values);
  }

  Future<int> deleteAllByHymnId(List<String> hymnIdValues) {
    final values = hymnIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'hymnId', values);
  }

  int deleteAllByHymnIdSync(List<String> hymnIdValues) {
    final values = hymnIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'hymnId', values);
  }

  Future<Id> putByHymnId(LocalHymn object) {
    return putByIndex(r'hymnId', object);
  }

  Id putByHymnIdSync(LocalHymn object, {bool saveLinks = true}) {
    return putByIndexSync(r'hymnId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByHymnId(List<LocalHymn> objects) {
    return putAllByIndex(r'hymnId', objects);
  }

  List<Id> putAllByHymnIdSync(List<LocalHymn> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'hymnId', objects, saveLinks: saveLinks);
  }
}

extension LocalHymnQueryWhereSort
    on QueryBuilder<LocalHymn, LocalHymn, QWhere> {
  QueryBuilder<LocalHymn, LocalHymn, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LocalHymnQueryWhere
    on QueryBuilder<LocalHymn, LocalHymn, QWhereClause> {
  QueryBuilder<LocalHymn, LocalHymn, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterWhereClause> hymnIdEqualTo(
      String hymnId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'hymnId',
        value: [hymnId],
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterWhereClause> hymnIdNotEqualTo(
      String hymnId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId',
              lower: [],
              upper: [hymnId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId',
              lower: [hymnId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId',
              lower: [hymnId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId',
              lower: [],
              upper: [hymnId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension LocalHymnQueryFilter
    on QueryBuilder<LocalHymn, LocalHymn, QFilterCondition> {
  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> createdOnEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition>
      createdOnGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> createdOnLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> createdOnBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> hymnIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> hymnIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> hymnIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> hymnIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hymnId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> hymnIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> hymnIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> hymnIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> hymnIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hymnId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> hymnIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hymnId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> hymnIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hymnId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> modifiedOnEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modifiedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition>
      modifiedOnGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modifiedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> modifiedOnLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modifiedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> modifiedOnBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modifiedOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition>
      originalLyricsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition>
      originalLyricsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'originalLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition>
      originalLyricsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'originalLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition>
      originalLyricsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'originalLyrics',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition>
      originalLyricsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'originalLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition>
      originalLyricsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'originalLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition>
      originalLyricsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'originalLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition>
      originalLyricsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'originalLyrics',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition>
      originalLyricsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalLyrics',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition>
      originalLyricsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'originalLyrics',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> versionEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> versionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> versionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterFilterCondition> versionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'version',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LocalHymnQueryObject
    on QueryBuilder<LocalHymn, LocalHymn, QFilterCondition> {}

extension LocalHymnQueryLinks
    on QueryBuilder<LocalHymn, LocalHymn, QFilterCondition> {}

extension LocalHymnQuerySortBy on QueryBuilder<LocalHymn, LocalHymn, QSortBy> {
  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> sortByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.asc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> sortByCreatedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.desc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> sortByHymnId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.asc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> sortByHymnIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.desc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> sortByModifiedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.asc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> sortByModifiedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.desc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> sortByOriginalLyrics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalLyrics', Sort.asc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> sortByOriginalLyricsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalLyrics', Sort.desc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension LocalHymnQuerySortThenBy
    on QueryBuilder<LocalHymn, LocalHymn, QSortThenBy> {
  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> thenByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.asc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> thenByCreatedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.desc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> thenByHymnId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.asc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> thenByHymnIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.desc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> thenByModifiedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.asc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> thenByModifiedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.desc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> thenByOriginalLyrics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalLyrics', Sort.asc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> thenByOriginalLyricsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalLyrics', Sort.desc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QAfterSortBy> thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension LocalHymnQueryWhereDistinct
    on QueryBuilder<LocalHymn, LocalHymn, QDistinct> {
  QueryBuilder<LocalHymn, LocalHymn, QDistinct> distinctByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdOn');
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QDistinct> distinctByHymnId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hymnId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QDistinct> distinctByModifiedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modifiedOn');
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QDistinct> distinctByOriginalLyrics(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originalLyrics',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalHymn, LocalHymn, QDistinct> distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version');
    });
  }
}

extension LocalHymnQueryProperty
    on QueryBuilder<LocalHymn, LocalHymn, QQueryProperty> {
  QueryBuilder<LocalHymn, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LocalHymn, int, QQueryOperations> createdOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdOn');
    });
  }

  QueryBuilder<LocalHymn, String, QQueryOperations> hymnIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hymnId');
    });
  }

  QueryBuilder<LocalHymn, int, QQueryOperations> modifiedOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modifiedOn');
    });
  }

  QueryBuilder<LocalHymn, String, QQueryOperations> originalLyricsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originalLyrics');
    });
  }

  QueryBuilder<LocalHymn, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<LocalHymn, int, QQueryOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserHymnPrefCollection on Isar {
  IsarCollection<UserHymnPref> get userHymnPrefs => this.collection();
}

const UserHymnPrefSchema = CollectionSchema(
  name: r'UserHymnPref',
  id: 6114642155807445448,
  properties: {
    r'beat': PropertySchema(
      id: 0,
      name: r'beat',
      type: IsarType.string,
    ),
    r'createdOn': PropertySchema(
      id: 1,
      name: r'createdOn',
      type: IsarType.long,
    ),
    r'hymnId': PropertySchema(
      id: 2,
      name: r'hymnId',
      type: IsarType.string,
    ),
    r'manualKey': PropertySchema(
      id: 3,
      name: r'manualKey',
      type: IsarType.string,
    ),
    r'modifiedOn': PropertySchema(
      id: 4,
      name: r'modifiedOn',
      type: IsarType.long,
    ),
    r'preferFlats': PropertySchema(
      id: 5,
      name: r'preferFlats',
      type: IsarType.bool,
    ),
    r'style': PropertySchema(
      id: 6,
      name: r'style',
      type: IsarType.string,
    ),
    r'tempo': PropertySchema(
      id: 7,
      name: r'tempo',
      type: IsarType.long,
    ),
    r'transposeOffset': PropertySchema(
      id: 8,
      name: r'transposeOffset',
      type: IsarType.long,
    ),
    r'userId': PropertySchema(
      id: 9,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _userHymnPrefEstimateSize,
  serialize: _userHymnPrefSerialize,
  deserialize: _userHymnPrefDeserialize,
  deserializeProp: _userHymnPrefDeserializeProp,
  idName: r'id',
  indexes: {
    r'hymnId_userId': IndexSchema(
      id: 2260673514327050739,
      name: r'hymnId_userId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'hymnId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _userHymnPrefGetId,
  getLinks: _userHymnPrefGetLinks,
  attach: _userHymnPrefAttach,
  version: '3.1.0+1',
);

int _userHymnPrefEstimateSize(
  UserHymnPref object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.beat.length * 3;
  bytesCount += 3 + object.hymnId.length * 3;
  {
    final value = object.manualKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.style.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _userHymnPrefSerialize(
  UserHymnPref object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.beat);
  writer.writeLong(offsets[1], object.createdOn);
  writer.writeString(offsets[2], object.hymnId);
  writer.writeString(offsets[3], object.manualKey);
  writer.writeLong(offsets[4], object.modifiedOn);
  writer.writeBool(offsets[5], object.preferFlats);
  writer.writeString(offsets[6], object.style);
  writer.writeLong(offsets[7], object.tempo);
  writer.writeLong(offsets[8], object.transposeOffset);
  writer.writeString(offsets[9], object.userId);
}

UserHymnPref _userHymnPrefDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserHymnPref();
  object.beat = reader.readString(offsets[0]);
  object.createdOn = reader.readLong(offsets[1]);
  object.hymnId = reader.readString(offsets[2]);
  object.id = id;
  object.manualKey = reader.readStringOrNull(offsets[3]);
  object.modifiedOn = reader.readLong(offsets[4]);
  object.preferFlats = reader.readBool(offsets[5]);
  object.style = reader.readString(offsets[6]);
  object.tempo = reader.readLong(offsets[7]);
  object.transposeOffset = reader.readLong(offsets[8]);
  object.userId = reader.readString(offsets[9]);
  return object;
}

P _userHymnPrefDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userHymnPrefGetId(UserHymnPref object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userHymnPrefGetLinks(UserHymnPref object) {
  return [];
}

void _userHymnPrefAttach(
    IsarCollection<dynamic> col, Id id, UserHymnPref object) {
  object.id = id;
}

extension UserHymnPrefByIndex on IsarCollection<UserHymnPref> {
  Future<UserHymnPref?> getByHymnIdUserId(String hymnId, String userId) {
    return getByIndex(r'hymnId_userId', [hymnId, userId]);
  }

  UserHymnPref? getByHymnIdUserIdSync(String hymnId, String userId) {
    return getByIndexSync(r'hymnId_userId', [hymnId, userId]);
  }

  Future<bool> deleteByHymnIdUserId(String hymnId, String userId) {
    return deleteByIndex(r'hymnId_userId', [hymnId, userId]);
  }

  bool deleteByHymnIdUserIdSync(String hymnId, String userId) {
    return deleteByIndexSync(r'hymnId_userId', [hymnId, userId]);
  }

  Future<List<UserHymnPref?>> getAllByHymnIdUserId(
      List<String> hymnIdValues, List<String> userIdValues) {
    final len = hymnIdValues.length;
    assert(userIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([hymnIdValues[i], userIdValues[i]]);
    }

    return getAllByIndex(r'hymnId_userId', values);
  }

  List<UserHymnPref?> getAllByHymnIdUserIdSync(
      List<String> hymnIdValues, List<String> userIdValues) {
    final len = hymnIdValues.length;
    assert(userIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([hymnIdValues[i], userIdValues[i]]);
    }

    return getAllByIndexSync(r'hymnId_userId', values);
  }

  Future<int> deleteAllByHymnIdUserId(
      List<String> hymnIdValues, List<String> userIdValues) {
    final len = hymnIdValues.length;
    assert(userIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([hymnIdValues[i], userIdValues[i]]);
    }

    return deleteAllByIndex(r'hymnId_userId', values);
  }

  int deleteAllByHymnIdUserIdSync(
      List<String> hymnIdValues, List<String> userIdValues) {
    final len = hymnIdValues.length;
    assert(userIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([hymnIdValues[i], userIdValues[i]]);
    }

    return deleteAllByIndexSync(r'hymnId_userId', values);
  }

  Future<Id> putByHymnIdUserId(UserHymnPref object) {
    return putByIndex(r'hymnId_userId', object);
  }

  Id putByHymnIdUserIdSync(UserHymnPref object, {bool saveLinks = true}) {
    return putByIndexSync(r'hymnId_userId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByHymnIdUserId(List<UserHymnPref> objects) {
    return putAllByIndex(r'hymnId_userId', objects);
  }

  List<Id> putAllByHymnIdUserIdSync(List<UserHymnPref> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'hymnId_userId', objects, saveLinks: saveLinks);
  }
}

extension UserHymnPrefQueryWhereSort
    on QueryBuilder<UserHymnPref, UserHymnPref, QWhere> {
  QueryBuilder<UserHymnPref, UserHymnPref, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserHymnPrefQueryWhere
    on QueryBuilder<UserHymnPref, UserHymnPref, QWhereClause> {
  QueryBuilder<UserHymnPref, UserHymnPref, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterWhereClause>
      hymnIdEqualToAnyUserId(String hymnId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'hymnId_userId',
        value: [hymnId],
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterWhereClause>
      hymnIdNotEqualToAnyUserId(String hymnId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_userId',
              lower: [],
              upper: [hymnId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_userId',
              lower: [hymnId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_userId',
              lower: [hymnId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_userId',
              lower: [],
              upper: [hymnId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterWhereClause>
      hymnIdUserIdEqualTo(String hymnId, String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'hymnId_userId',
        value: [hymnId, userId],
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterWhereClause>
      hymnIdEqualToUserIdNotEqualTo(String hymnId, String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_userId',
              lower: [hymnId],
              upper: [hymnId, userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_userId',
              lower: [hymnId, userId],
              includeLower: false,
              upper: [hymnId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_userId',
              lower: [hymnId, userId],
              includeLower: false,
              upper: [hymnId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_userId',
              lower: [hymnId],
              upper: [hymnId, userId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension UserHymnPrefQueryFilter
    on QueryBuilder<UserHymnPref, UserHymnPref, QFilterCondition> {
  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> beatEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'beat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      beatGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'beat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> beatLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'beat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> beatBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'beat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      beatStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'beat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> beatEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'beat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> beatContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'beat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> beatMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'beat',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      beatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'beat',
        value: '',
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      beatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'beat',
        value: '',
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      createdOnEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      createdOnGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      createdOnLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      createdOnBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> hymnIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      hymnIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      hymnIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> hymnIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hymnId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      hymnIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      hymnIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      hymnIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> hymnIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hymnId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      hymnIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hymnId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      hymnIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hymnId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      manualKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'manualKey',
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      manualKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'manualKey',
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      manualKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'manualKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      manualKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'manualKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      manualKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'manualKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      manualKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'manualKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      manualKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'manualKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      manualKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'manualKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      manualKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'manualKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      manualKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'manualKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      manualKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'manualKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      manualKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'manualKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      modifiedOnEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modifiedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      modifiedOnGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modifiedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      modifiedOnLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modifiedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      modifiedOnBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modifiedOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      preferFlatsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preferFlats',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> styleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'style',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      styleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'style',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> styleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'style',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> styleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'style',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      styleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'style',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> styleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'style',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> styleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'style',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> styleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'style',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      styleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'style',
        value: '',
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      styleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'style',
        value: '',
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> tempoEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tempo',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      tempoGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tempo',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> tempoLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tempo',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> tempoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tempo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      transposeOffsetEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transposeOffset',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      transposeOffsetGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transposeOffset',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      transposeOffsetLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transposeOffset',
        value: value,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      transposeOffsetBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transposeOffset',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension UserHymnPrefQueryObject
    on QueryBuilder<UserHymnPref, UserHymnPref, QFilterCondition> {}

extension UserHymnPrefQueryLinks
    on QueryBuilder<UserHymnPref, UserHymnPref, QFilterCondition> {}

extension UserHymnPrefQuerySortBy
    on QueryBuilder<UserHymnPref, UserHymnPref, QSortBy> {
  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByBeat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beat', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByBeatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beat', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByCreatedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByHymnId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByHymnIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByManualKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualKey', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByManualKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualKey', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByModifiedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy>
      sortByModifiedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByPreferFlats() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferFlats', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy>
      sortByPreferFlatsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferFlats', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByTempo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempo', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByTempoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempo', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy>
      sortByTransposeOffset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transposeOffset', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy>
      sortByTransposeOffsetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transposeOffset', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UserHymnPrefQuerySortThenBy
    on QueryBuilder<UserHymnPref, UserHymnPref, QSortThenBy> {
  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByBeat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beat', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByBeatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beat', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByCreatedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByHymnId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByHymnIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByManualKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualKey', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByManualKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualKey', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByModifiedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy>
      thenByModifiedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByPreferFlats() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferFlats', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy>
      thenByPreferFlatsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferFlats', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByTempo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempo', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByTempoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempo', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy>
      thenByTransposeOffset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transposeOffset', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy>
      thenByTransposeOffsetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transposeOffset', Sort.desc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UserHymnPrefQueryWhereDistinct
    on QueryBuilder<UserHymnPref, UserHymnPref, QDistinct> {
  QueryBuilder<UserHymnPref, UserHymnPref, QDistinct> distinctByBeat(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'beat', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QDistinct> distinctByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdOn');
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QDistinct> distinctByHymnId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hymnId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QDistinct> distinctByManualKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'manualKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QDistinct> distinctByModifiedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modifiedOn');
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QDistinct> distinctByPreferFlats() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'preferFlats');
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QDistinct> distinctByStyle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'style', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QDistinct> distinctByTempo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tempo');
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QDistinct>
      distinctByTransposeOffset() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transposeOffset');
    });
  }

  QueryBuilder<UserHymnPref, UserHymnPref, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension UserHymnPrefQueryProperty
    on QueryBuilder<UserHymnPref, UserHymnPref, QQueryProperty> {
  QueryBuilder<UserHymnPref, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserHymnPref, String, QQueryOperations> beatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'beat');
    });
  }

  QueryBuilder<UserHymnPref, int, QQueryOperations> createdOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdOn');
    });
  }

  QueryBuilder<UserHymnPref, String, QQueryOperations> hymnIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hymnId');
    });
  }

  QueryBuilder<UserHymnPref, String?, QQueryOperations> manualKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'manualKey');
    });
  }

  QueryBuilder<UserHymnPref, int, QQueryOperations> modifiedOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modifiedOn');
    });
  }

  QueryBuilder<UserHymnPref, bool, QQueryOperations> preferFlatsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preferFlats');
    });
  }

  QueryBuilder<UserHymnPref, String, QQueryOperations> styleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'style');
    });
  }

  QueryBuilder<UserHymnPref, int, QQueryOperations> tempoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tempo');
    });
  }

  QueryBuilder<UserHymnPref, int, QQueryOperations> transposeOffsetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transposeOffset');
    });
  }

  QueryBuilder<UserHymnPref, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNoteFolderCollection on Isar {
  IsarCollection<NoteFolder> get noteFolders => this.collection();
}

const NoteFolderSchema = CollectionSchema(
  name: r'NoteFolder',
  id: 2473896476860190738,
  properties: {
    r'createdOn': PropertySchema(
      id: 0,
      name: r'createdOn',
      type: IsarType.long,
    ),
    r'depth': PropertySchema(
      id: 1,
      name: r'depth',
      type: IsarType.long,
    ),
    r'folderId': PropertySchema(
      id: 2,
      name: r'folderId',
      type: IsarType.string,
    ),
    r'lastSyncedOn': PropertySchema(
      id: 3,
      name: r'lastSyncedOn',
      type: IsarType.long,
    ),
    r'modifiedOn': PropertySchema(
      id: 4,
      name: r'modifiedOn',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'parentId': PropertySchema(
      id: 6,
      name: r'parentId',
      type: IsarType.string,
    ),
    r'syncStatus': PropertySchema(
      id: 7,
      name: r'syncStatus',
      type: IsarType.byte,
      enumMap: _NoteFoldersyncStatusEnumValueMap,
    ),
    r'type': PropertySchema(
      id: 8,
      name: r'type',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 9,
      name: r'userId',
      type: IsarType.string,
    ),
    r'version': PropertySchema(
      id: 10,
      name: r'version',
      type: IsarType.long,
    )
  },
  estimateSize: _noteFolderEstimateSize,
  serialize: _noteFolderSerialize,
  deserialize: _noteFolderDeserialize,
  deserializeProp: _noteFolderDeserializeProp,
  idName: r'id',
  indexes: {
    r'folderId': IndexSchema(
      id: 6340065978996931043,
      name: r'folderId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'folderId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _noteFolderGetId,
  getLinks: _noteFolderGetLinks,
  attach: _noteFolderAttach,
  version: '3.1.0+1',
);

int _noteFolderEstimateSize(
  NoteFolder object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.folderId.length * 3;
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.parentId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.type.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _noteFolderSerialize(
  NoteFolder object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.createdOn);
  writer.writeLong(offsets[1], object.depth);
  writer.writeString(offsets[2], object.folderId);
  writer.writeLong(offsets[3], object.lastSyncedOn);
  writer.writeLong(offsets[4], object.modifiedOn);
  writer.writeString(offsets[5], object.name);
  writer.writeString(offsets[6], object.parentId);
  writer.writeByte(offsets[7], object.syncStatus.index);
  writer.writeString(offsets[8], object.type);
  writer.writeString(offsets[9], object.userId);
  writer.writeLong(offsets[10], object.version);
}

NoteFolder _noteFolderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NoteFolder();
  object.createdOn = reader.readLong(offsets[0]);
  object.depth = reader.readLong(offsets[1]);
  object.folderId = reader.readString(offsets[2]);
  object.id = id;
  object.lastSyncedOn = reader.readLongOrNull(offsets[3]);
  object.modifiedOn = reader.readLong(offsets[4]);
  object.name = reader.readString(offsets[5]);
  object.parentId = reader.readStringOrNull(offsets[6]);
  object.syncStatus =
      _NoteFoldersyncStatusValueEnumMap[reader.readByteOrNull(offsets[7])] ??
          SyncStatus.local;
  object.type = reader.readString(offsets[8]);
  object.userId = reader.readString(offsets[9]);
  object.version = reader.readLong(offsets[10]);
  return object;
}

P _noteFolderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (_NoteFoldersyncStatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          SyncStatus.local) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _NoteFoldersyncStatusEnumValueMap = {
  'local': 0,
  'pending': 1,
  'synced': 2,
  'error': 3,
};
const _NoteFoldersyncStatusValueEnumMap = {
  0: SyncStatus.local,
  1: SyncStatus.pending,
  2: SyncStatus.synced,
  3: SyncStatus.error,
};

Id _noteFolderGetId(NoteFolder object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _noteFolderGetLinks(NoteFolder object) {
  return [];
}

void _noteFolderAttach(IsarCollection<dynamic> col, Id id, NoteFolder object) {
  object.id = id;
}

extension NoteFolderByIndex on IsarCollection<NoteFolder> {
  Future<NoteFolder?> getByFolderId(String folderId) {
    return getByIndex(r'folderId', [folderId]);
  }

  NoteFolder? getByFolderIdSync(String folderId) {
    return getByIndexSync(r'folderId', [folderId]);
  }

  Future<bool> deleteByFolderId(String folderId) {
    return deleteByIndex(r'folderId', [folderId]);
  }

  bool deleteByFolderIdSync(String folderId) {
    return deleteByIndexSync(r'folderId', [folderId]);
  }

  Future<List<NoteFolder?>> getAllByFolderId(List<String> folderIdValues) {
    final values = folderIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'folderId', values);
  }

  List<NoteFolder?> getAllByFolderIdSync(List<String> folderIdValues) {
    final values = folderIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'folderId', values);
  }

  Future<int> deleteAllByFolderId(List<String> folderIdValues) {
    final values = folderIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'folderId', values);
  }

  int deleteAllByFolderIdSync(List<String> folderIdValues) {
    final values = folderIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'folderId', values);
  }

  Future<Id> putByFolderId(NoteFolder object) {
    return putByIndex(r'folderId', object);
  }

  Id putByFolderIdSync(NoteFolder object, {bool saveLinks = true}) {
    return putByIndexSync(r'folderId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByFolderId(List<NoteFolder> objects) {
    return putAllByIndex(r'folderId', objects);
  }

  List<Id> putAllByFolderIdSync(List<NoteFolder> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'folderId', objects, saveLinks: saveLinks);
  }
}

extension NoteFolderQueryWhereSort
    on QueryBuilder<NoteFolder, NoteFolder, QWhere> {
  QueryBuilder<NoteFolder, NoteFolder, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NoteFolderQueryWhere
    on QueryBuilder<NoteFolder, NoteFolder, QWhereClause> {
  QueryBuilder<NoteFolder, NoteFolder, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterWhereClause> folderIdEqualTo(
      String folderId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'folderId',
        value: [folderId],
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterWhereClause> folderIdNotEqualTo(
      String folderId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'folderId',
              lower: [],
              upper: [folderId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'folderId',
              lower: [folderId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'folderId',
              lower: [folderId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'folderId',
              lower: [],
              upper: [folderId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension NoteFolderQueryFilter
    on QueryBuilder<NoteFolder, NoteFolder, QFilterCondition> {
  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> createdOnEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      createdOnGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> createdOnLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> createdOnBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> depthEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'depth',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> depthGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'depth',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> depthLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'depth',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> depthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'depth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> folderIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'folderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      folderIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'folderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> folderIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'folderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> folderIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'folderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      folderIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'folderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> folderIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'folderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> folderIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'folderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> folderIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'folderId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      folderIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'folderId',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      folderIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'folderId',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      lastSyncedOnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastSyncedOn',
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      lastSyncedOnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastSyncedOn',
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      lastSyncedOnEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSyncedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      lastSyncedOnGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSyncedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      lastSyncedOnLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSyncedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      lastSyncedOnBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSyncedOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> modifiedOnEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modifiedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      modifiedOnGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modifiedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      modifiedOnLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modifiedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> modifiedOnBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modifiedOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> parentIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentId',
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      parentIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentId',
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> parentIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      parentIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> parentIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> parentIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      parentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> parentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> parentIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> parentIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      parentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentId',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      parentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentId',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> syncStatusEqualTo(
      SyncStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      syncStatusGreaterThan(
    SyncStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      syncStatusLessThan(
    SyncStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> syncStatusBetween(
    SyncStatus lower,
    SyncStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> userIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> versionEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition>
      versionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> versionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterFilterCondition> versionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'version',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension NoteFolderQueryObject
    on QueryBuilder<NoteFolder, NoteFolder, QFilterCondition> {}

extension NoteFolderQueryLinks
    on QueryBuilder<NoteFolder, NoteFolder, QFilterCondition> {}

extension NoteFolderQuerySortBy
    on QueryBuilder<NoteFolder, NoteFolder, QSortBy> {
  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByCreatedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByDepth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'depth', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByDepthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'depth', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByFolderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderId', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByFolderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderId', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByLastSyncedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncedOn', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByLastSyncedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncedOn', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByModifiedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByModifiedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByParentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByParentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension NoteFolderQuerySortThenBy
    on QueryBuilder<NoteFolder, NoteFolder, QSortThenBy> {
  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByCreatedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByDepth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'depth', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByDepthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'depth', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByFolderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderId', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByFolderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderId', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByLastSyncedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncedOn', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByLastSyncedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncedOn', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByModifiedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByModifiedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByParentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByParentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QAfterSortBy> thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension NoteFolderQueryWhereDistinct
    on QueryBuilder<NoteFolder, NoteFolder, QDistinct> {
  QueryBuilder<NoteFolder, NoteFolder, QDistinct> distinctByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdOn');
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QDistinct> distinctByDepth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'depth');
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QDistinct> distinctByFolderId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'folderId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QDistinct> distinctByLastSyncedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSyncedOn');
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QDistinct> distinctByModifiedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modifiedOn');
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QDistinct> distinctByParentId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QDistinct> distinctBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatus');
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteFolder, NoteFolder, QDistinct> distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version');
    });
  }
}

extension NoteFolderQueryProperty
    on QueryBuilder<NoteFolder, NoteFolder, QQueryProperty> {
  QueryBuilder<NoteFolder, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NoteFolder, int, QQueryOperations> createdOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdOn');
    });
  }

  QueryBuilder<NoteFolder, int, QQueryOperations> depthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'depth');
    });
  }

  QueryBuilder<NoteFolder, String, QQueryOperations> folderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'folderId');
    });
  }

  QueryBuilder<NoteFolder, int?, QQueryOperations> lastSyncedOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSyncedOn');
    });
  }

  QueryBuilder<NoteFolder, int, QQueryOperations> modifiedOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modifiedOn');
    });
  }

  QueryBuilder<NoteFolder, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<NoteFolder, String?, QQueryOperations> parentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentId');
    });
  }

  QueryBuilder<NoteFolder, SyncStatus, QQueryOperations> syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatus');
    });
  }

  QueryBuilder<NoteFolder, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<NoteFolder, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<NoteFolder, int, QQueryOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserNoteCollection on Isar {
  IsarCollection<UserNote> get userNotes => this.collection();
}

const UserNoteSchema = CollectionSchema(
  name: r'UserNote',
  id: -2131981069326579742,
  properties: {
    r'approvalStatus': PropertySchema(
      id: 0,
      name: r'approvalStatus',
      type: IsarType.string,
    ),
    r'approverId': PropertySchema(
      id: 1,
      name: r'approverId',
      type: IsarType.string,
    ),
    r'content': PropertySchema(
      id: 2,
      name: r'content',
      type: IsarType.string,
    ),
    r'createdOn': PropertySchema(
      id: 3,
      name: r'createdOn',
      type: IsarType.long,
    ),
    r'folderId': PropertySchema(
      id: 4,
      name: r'folderId',
      type: IsarType.string,
    ),
    r'hymnId': PropertySchema(
      id: 5,
      name: r'hymnId',
      type: IsarType.string,
    ),
    r'lastSyncedOn': PropertySchema(
      id: 6,
      name: r'lastSyncedOn',
      type: IsarType.long,
    ),
    r'modifiedOn': PropertySchema(
      id: 7,
      name: r'modifiedOn',
      type: IsarType.long,
    ),
    r'noteId': PropertySchema(
      id: 8,
      name: r'noteId',
      type: IsarType.string,
    ),
    r'noteType': PropertySchema(
      id: 9,
      name: r'noteType',
      type: IsarType.string,
    ),
    r'syncStatus': PropertySchema(
      id: 10,
      name: r'syncStatus',
      type: IsarType.byte,
      enumMap: _UserNotesyncStatusEnumValueMap,
    ),
    r'title': PropertySchema(
      id: 11,
      name: r'title',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 12,
      name: r'userId',
      type: IsarType.string,
    ),
    r'version': PropertySchema(
      id: 13,
      name: r'version',
      type: IsarType.long,
    )
  },
  estimateSize: _userNoteEstimateSize,
  serialize: _userNoteSerialize,
  deserialize: _userNoteDeserialize,
  deserializeProp: _userNoteDeserializeProp,
  idName: r'id',
  indexes: {
    r'noteId': IndexSchema(
      id: -9014133502494436840,
      name: r'noteId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'noteId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'hymnId_folderId_userId': IndexSchema(
      id: 6854657643197082208,
      name: r'hymnId_folderId_userId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'hymnId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'folderId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _userNoteGetId,
  getLinks: _userNoteGetLinks,
  attach: _userNoteAttach,
  version: '3.1.0+1',
);

int _userNoteEstimateSize(
  UserNote object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.approvalStatus.length * 3;
  {
    final value = object.approverId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.content.length * 3;
  bytesCount += 3 + object.folderId.length * 3;
  bytesCount += 3 + object.hymnId.length * 3;
  bytesCount += 3 + object.noteId.length * 3;
  bytesCount += 3 + object.noteType.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _userNoteSerialize(
  UserNote object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.approvalStatus);
  writer.writeString(offsets[1], object.approverId);
  writer.writeString(offsets[2], object.content);
  writer.writeLong(offsets[3], object.createdOn);
  writer.writeString(offsets[4], object.folderId);
  writer.writeString(offsets[5], object.hymnId);
  writer.writeLong(offsets[6], object.lastSyncedOn);
  writer.writeLong(offsets[7], object.modifiedOn);
  writer.writeString(offsets[8], object.noteId);
  writer.writeString(offsets[9], object.noteType);
  writer.writeByte(offsets[10], object.syncStatus.index);
  writer.writeString(offsets[11], object.title);
  writer.writeString(offsets[12], object.userId);
  writer.writeLong(offsets[13], object.version);
}

UserNote _userNoteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserNote();
  object.approvalStatus = reader.readString(offsets[0]);
  object.approverId = reader.readStringOrNull(offsets[1]);
  object.content = reader.readString(offsets[2]);
  object.createdOn = reader.readLong(offsets[3]);
  object.folderId = reader.readString(offsets[4]);
  object.hymnId = reader.readString(offsets[5]);
  object.id = id;
  object.lastSyncedOn = reader.readLongOrNull(offsets[6]);
  object.modifiedOn = reader.readLong(offsets[7]);
  object.noteId = reader.readString(offsets[8]);
  object.noteType = reader.readString(offsets[9]);
  object.syncStatus =
      _UserNotesyncStatusValueEnumMap[reader.readByteOrNull(offsets[10])] ??
          SyncStatus.local;
  object.title = reader.readString(offsets[11]);
  object.userId = reader.readString(offsets[12]);
  object.version = reader.readLong(offsets[13]);
  return object;
}

P _userNoteDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (_UserNotesyncStatusValueEnumMap[reader.readByteOrNull(offset)] ??
          SyncStatus.local) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UserNotesyncStatusEnumValueMap = {
  'local': 0,
  'pending': 1,
  'synced': 2,
  'error': 3,
};
const _UserNotesyncStatusValueEnumMap = {
  0: SyncStatus.local,
  1: SyncStatus.pending,
  2: SyncStatus.synced,
  3: SyncStatus.error,
};

Id _userNoteGetId(UserNote object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userNoteGetLinks(UserNote object) {
  return [];
}

void _userNoteAttach(IsarCollection<dynamic> col, Id id, UserNote object) {
  object.id = id;
}

extension UserNoteByIndex on IsarCollection<UserNote> {
  Future<UserNote?> getByNoteId(String noteId) {
    return getByIndex(r'noteId', [noteId]);
  }

  UserNote? getByNoteIdSync(String noteId) {
    return getByIndexSync(r'noteId', [noteId]);
  }

  Future<bool> deleteByNoteId(String noteId) {
    return deleteByIndex(r'noteId', [noteId]);
  }

  bool deleteByNoteIdSync(String noteId) {
    return deleteByIndexSync(r'noteId', [noteId]);
  }

  Future<List<UserNote?>> getAllByNoteId(List<String> noteIdValues) {
    final values = noteIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'noteId', values);
  }

  List<UserNote?> getAllByNoteIdSync(List<String> noteIdValues) {
    final values = noteIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'noteId', values);
  }

  Future<int> deleteAllByNoteId(List<String> noteIdValues) {
    final values = noteIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'noteId', values);
  }

  int deleteAllByNoteIdSync(List<String> noteIdValues) {
    final values = noteIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'noteId', values);
  }

  Future<Id> putByNoteId(UserNote object) {
    return putByIndex(r'noteId', object);
  }

  Id putByNoteIdSync(UserNote object, {bool saveLinks = true}) {
    return putByIndexSync(r'noteId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByNoteId(List<UserNote> objects) {
    return putAllByIndex(r'noteId', objects);
  }

  List<Id> putAllByNoteIdSync(List<UserNote> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'noteId', objects, saveLinks: saveLinks);
  }
}

extension UserNoteQueryWhereSort on QueryBuilder<UserNote, UserNote, QWhere> {
  QueryBuilder<UserNote, UserNote, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserNoteQueryWhere on QueryBuilder<UserNote, UserNote, QWhereClause> {
  QueryBuilder<UserNote, UserNote, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterWhereClause> noteIdEqualTo(
      String noteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'noteId',
        value: [noteId],
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterWhereClause> noteIdNotEqualTo(
      String noteId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'noteId',
              lower: [],
              upper: [noteId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'noteId',
              lower: [noteId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'noteId',
              lower: [noteId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'noteId',
              lower: [],
              upper: [noteId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterWhereClause>
      hymnIdEqualToAnyFolderIdUserId(String hymnId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'hymnId_folderId_userId',
        value: [hymnId],
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterWhereClause>
      hymnIdNotEqualToAnyFolderIdUserId(String hymnId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_folderId_userId',
              lower: [],
              upper: [hymnId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_folderId_userId',
              lower: [hymnId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_folderId_userId',
              lower: [hymnId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_folderId_userId',
              lower: [],
              upper: [hymnId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterWhereClause>
      hymnIdFolderIdEqualToAnyUserId(String hymnId, String folderId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'hymnId_folderId_userId',
        value: [hymnId, folderId],
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterWhereClause>
      hymnIdEqualToFolderIdNotEqualToAnyUserId(String hymnId, String folderId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_folderId_userId',
              lower: [hymnId],
              upper: [hymnId, folderId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_folderId_userId',
              lower: [hymnId, folderId],
              includeLower: false,
              upper: [hymnId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_folderId_userId',
              lower: [hymnId, folderId],
              includeLower: false,
              upper: [hymnId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_folderId_userId',
              lower: [hymnId],
              upper: [hymnId, folderId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterWhereClause>
      hymnIdFolderIdUserIdEqualTo(
          String hymnId, String folderId, String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'hymnId_folderId_userId',
        value: [hymnId, folderId, userId],
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterWhereClause>
      hymnIdFolderIdEqualToUserIdNotEqualTo(
          String hymnId, String folderId, String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_folderId_userId',
              lower: [hymnId, folderId],
              upper: [hymnId, folderId, userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_folderId_userId',
              lower: [hymnId, folderId, userId],
              includeLower: false,
              upper: [hymnId, folderId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_folderId_userId',
              lower: [hymnId, folderId, userId],
              includeLower: false,
              upper: [hymnId, folderId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hymnId_folderId_userId',
              lower: [hymnId, folderId],
              upper: [hymnId, folderId, userId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension UserNoteQueryFilter
    on QueryBuilder<UserNote, UserNote, QFilterCondition> {
  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> approvalStatusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'approvalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition>
      approvalStatusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'approvalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition>
      approvalStatusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'approvalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> approvalStatusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'approvalStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition>
      approvalStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'approvalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition>
      approvalStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'approvalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition>
      approvalStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'approvalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> approvalStatusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'approvalStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition>
      approvalStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'approvalStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition>
      approvalStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'approvalStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> approverIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'approverId',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition>
      approverIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'approverId',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> approverIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'approverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> approverIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'approverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> approverIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'approverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> approverIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'approverId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> approverIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'approverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> approverIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'approverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> approverIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'approverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> approverIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'approverId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> approverIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'approverId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition>
      approverIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'approverId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> contentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> contentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> contentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> contentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> contentContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> contentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> createdOnEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> createdOnGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> createdOnLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> createdOnBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> folderIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'folderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> folderIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'folderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> folderIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'folderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> folderIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'folderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> folderIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'folderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> folderIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'folderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> folderIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'folderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> folderIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'folderId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> folderIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'folderId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> folderIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'folderId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> hymnIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> hymnIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> hymnIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> hymnIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hymnId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> hymnIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> hymnIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> hymnIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> hymnIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hymnId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> hymnIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hymnId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> hymnIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hymnId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> lastSyncedOnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastSyncedOn',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition>
      lastSyncedOnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastSyncedOn',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> lastSyncedOnEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSyncedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition>
      lastSyncedOnGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSyncedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> lastSyncedOnLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSyncedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> lastSyncedOnBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSyncedOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> modifiedOnEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modifiedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> modifiedOnGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modifiedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> modifiedOnLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modifiedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> modifiedOnBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modifiedOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'noteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'noteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'noteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'noteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'noteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'noteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'noteId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'noteId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'noteType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'noteType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'noteType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'noteType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'noteType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'noteType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'noteType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteType',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> noteTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'noteType',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> syncStatusEqualTo(
      SyncStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> syncStatusGreaterThan(
    SyncStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> syncStatusLessThan(
    SyncStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> syncStatusBetween(
    SyncStatus lower,
    SyncStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> userIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> versionEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> versionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> versionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterFilterCondition> versionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'version',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserNoteQueryObject
    on QueryBuilder<UserNote, UserNote, QFilterCondition> {}

extension UserNoteQueryLinks
    on QueryBuilder<UserNote, UserNote, QFilterCondition> {}

extension UserNoteQuerySortBy on QueryBuilder<UserNote, UserNote, QSortBy> {
  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByApprovalStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvalStatus', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByApprovalStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvalStatus', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByApproverId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approverId', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByApproverIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approverId', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByCreatedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByFolderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderId', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByFolderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderId', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByHymnId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByHymnIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByLastSyncedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncedOn', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByLastSyncedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncedOn', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByModifiedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByModifiedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByNoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteId', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByNoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteId', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByNoteType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteType', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByNoteTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteType', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension UserNoteQuerySortThenBy
    on QueryBuilder<UserNote, UserNote, QSortThenBy> {
  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByApprovalStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvalStatus', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByApprovalStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvalStatus', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByApproverId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approverId', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByApproverIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approverId', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByCreatedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByFolderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderId', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByFolderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderId', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByHymnId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByHymnIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByLastSyncedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncedOn', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByLastSyncedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncedOn', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByModifiedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByModifiedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedOn', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByNoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteId', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByNoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteId', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByNoteType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteType', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByNoteTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteType', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<UserNote, UserNote, QAfterSortBy> thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension UserNoteQueryWhereDistinct
    on QueryBuilder<UserNote, UserNote, QDistinct> {
  QueryBuilder<UserNote, UserNote, QDistinct> distinctByApprovalStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'approvalStatus',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserNote, UserNote, QDistinct> distinctByApproverId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'approverId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserNote, UserNote, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserNote, UserNote, QDistinct> distinctByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdOn');
    });
  }

  QueryBuilder<UserNote, UserNote, QDistinct> distinctByFolderId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'folderId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserNote, UserNote, QDistinct> distinctByHymnId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hymnId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserNote, UserNote, QDistinct> distinctByLastSyncedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSyncedOn');
    });
  }

  QueryBuilder<UserNote, UserNote, QDistinct> distinctByModifiedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modifiedOn');
    });
  }

  QueryBuilder<UserNote, UserNote, QDistinct> distinctByNoteId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'noteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserNote, UserNote, QDistinct> distinctByNoteType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'noteType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserNote, UserNote, QDistinct> distinctBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatus');
    });
  }

  QueryBuilder<UserNote, UserNote, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserNote, UserNote, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserNote, UserNote, QDistinct> distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version');
    });
  }
}

extension UserNoteQueryProperty
    on QueryBuilder<UserNote, UserNote, QQueryProperty> {
  QueryBuilder<UserNote, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserNote, String, QQueryOperations> approvalStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'approvalStatus');
    });
  }

  QueryBuilder<UserNote, String?, QQueryOperations> approverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'approverId');
    });
  }

  QueryBuilder<UserNote, String, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<UserNote, int, QQueryOperations> createdOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdOn');
    });
  }

  QueryBuilder<UserNote, String, QQueryOperations> folderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'folderId');
    });
  }

  QueryBuilder<UserNote, String, QQueryOperations> hymnIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hymnId');
    });
  }

  QueryBuilder<UserNote, int?, QQueryOperations> lastSyncedOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSyncedOn');
    });
  }

  QueryBuilder<UserNote, int, QQueryOperations> modifiedOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modifiedOn');
    });
  }

  QueryBuilder<UserNote, String, QQueryOperations> noteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'noteId');
    });
  }

  QueryBuilder<UserNote, String, QQueryOperations> noteTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'noteType');
    });
  }

  QueryBuilder<UserNote, SyncStatus, QQueryOperations> syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatus');
    });
  }

  QueryBuilder<UserNote, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<UserNote, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<UserNote, int, QQueryOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEditProposalCollection on Isar {
  IsarCollection<EditProposal> get editProposals => this.collection();
}

const EditProposalSchema = CollectionSchema(
  name: r'EditProposal',
  id: 7668808993021203945,
  properties: {
    r'createdOn': PropertySchema(
      id: 0,
      name: r'createdOn',
      type: IsarType.long,
    ),
    r'hymnId': PropertySchema(
      id: 1,
      name: r'hymnId',
      type: IsarType.string,
    ),
    r'originalLyrics': PropertySchema(
      id: 2,
      name: r'originalLyrics',
      type: IsarType.string,
    ),
    r'proposalId': PropertySchema(
      id: 3,
      name: r'proposalId',
      type: IsarType.string,
    ),
    r'proposedLyrics': PropertySchema(
      id: 4,
      name: r'proposedLyrics',
      type: IsarType.string,
    ),
    r'syncStatus': PropertySchema(
      id: 5,
      name: r'syncStatus',
      type: IsarType.byte,
      enumMap: _EditProposalsyncStatusEnumValueMap,
    ),
    r'userId': PropertySchema(
      id: 6,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _editProposalEstimateSize,
  serialize: _editProposalSerialize,
  deserialize: _editProposalDeserialize,
  deserializeProp: _editProposalDeserializeProp,
  idName: r'id',
  indexes: {
    r'proposalId': IndexSchema(
      id: -3329764516456808925,
      name: r'proposalId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'proposalId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _editProposalGetId,
  getLinks: _editProposalGetLinks,
  attach: _editProposalAttach,
  version: '3.1.0+1',
);

int _editProposalEstimateSize(
  EditProposal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.hymnId.length * 3;
  bytesCount += 3 + object.originalLyrics.length * 3;
  bytesCount += 3 + object.proposalId.length * 3;
  bytesCount += 3 + object.proposedLyrics.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _editProposalSerialize(
  EditProposal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.createdOn);
  writer.writeString(offsets[1], object.hymnId);
  writer.writeString(offsets[2], object.originalLyrics);
  writer.writeString(offsets[3], object.proposalId);
  writer.writeString(offsets[4], object.proposedLyrics);
  writer.writeByte(offsets[5], object.syncStatus.index);
  writer.writeString(offsets[6], object.userId);
}

EditProposal _editProposalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EditProposal();
  object.createdOn = reader.readLong(offsets[0]);
  object.hymnId = reader.readString(offsets[1]);
  object.id = id;
  object.originalLyrics = reader.readString(offsets[2]);
  object.proposalId = reader.readString(offsets[3]);
  object.proposedLyrics = reader.readString(offsets[4]);
  object.syncStatus =
      _EditProposalsyncStatusValueEnumMap[reader.readByteOrNull(offsets[5])] ??
          SyncStatus.local;
  object.userId = reader.readString(offsets[6]);
  return object;
}

P _editProposalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (_EditProposalsyncStatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          SyncStatus.local) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _EditProposalsyncStatusEnumValueMap = {
  'local': 0,
  'pending': 1,
  'synced': 2,
  'error': 3,
};
const _EditProposalsyncStatusValueEnumMap = {
  0: SyncStatus.local,
  1: SyncStatus.pending,
  2: SyncStatus.synced,
  3: SyncStatus.error,
};

Id _editProposalGetId(EditProposal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _editProposalGetLinks(EditProposal object) {
  return [];
}

void _editProposalAttach(
    IsarCollection<dynamic> col, Id id, EditProposal object) {
  object.id = id;
}

extension EditProposalByIndex on IsarCollection<EditProposal> {
  Future<EditProposal?> getByProposalId(String proposalId) {
    return getByIndex(r'proposalId', [proposalId]);
  }

  EditProposal? getByProposalIdSync(String proposalId) {
    return getByIndexSync(r'proposalId', [proposalId]);
  }

  Future<bool> deleteByProposalId(String proposalId) {
    return deleteByIndex(r'proposalId', [proposalId]);
  }

  bool deleteByProposalIdSync(String proposalId) {
    return deleteByIndexSync(r'proposalId', [proposalId]);
  }

  Future<List<EditProposal?>> getAllByProposalId(
      List<String> proposalIdValues) {
    final values = proposalIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'proposalId', values);
  }

  List<EditProposal?> getAllByProposalIdSync(List<String> proposalIdValues) {
    final values = proposalIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'proposalId', values);
  }

  Future<int> deleteAllByProposalId(List<String> proposalIdValues) {
    final values = proposalIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'proposalId', values);
  }

  int deleteAllByProposalIdSync(List<String> proposalIdValues) {
    final values = proposalIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'proposalId', values);
  }

  Future<Id> putByProposalId(EditProposal object) {
    return putByIndex(r'proposalId', object);
  }

  Id putByProposalIdSync(EditProposal object, {bool saveLinks = true}) {
    return putByIndexSync(r'proposalId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByProposalId(List<EditProposal> objects) {
    return putAllByIndex(r'proposalId', objects);
  }

  List<Id> putAllByProposalIdSync(List<EditProposal> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'proposalId', objects, saveLinks: saveLinks);
  }
}

extension EditProposalQueryWhereSort
    on QueryBuilder<EditProposal, EditProposal, QWhere> {
  QueryBuilder<EditProposal, EditProposal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EditProposalQueryWhere
    on QueryBuilder<EditProposal, EditProposal, QWhereClause> {
  QueryBuilder<EditProposal, EditProposal, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterWhereClause> proposalIdEqualTo(
      String proposalId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'proposalId',
        value: [proposalId],
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterWhereClause>
      proposalIdNotEqualTo(String proposalId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'proposalId',
              lower: [],
              upper: [proposalId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'proposalId',
              lower: [proposalId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'proposalId',
              lower: [proposalId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'proposalId',
              lower: [],
              upper: [proposalId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension EditProposalQueryFilter
    on QueryBuilder<EditProposal, EditProposal, QFilterCondition> {
  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      createdOnEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      createdOnGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      createdOnLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      createdOnBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition> hymnIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      hymnIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      hymnIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition> hymnIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hymnId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      hymnIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      hymnIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      hymnIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hymnId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition> hymnIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hymnId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      hymnIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hymnId',
        value: '',
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      hymnIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hymnId',
        value: '',
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      originalLyricsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      originalLyricsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'originalLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      originalLyricsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'originalLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      originalLyricsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'originalLyrics',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      originalLyricsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'originalLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      originalLyricsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'originalLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      originalLyricsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'originalLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      originalLyricsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'originalLyrics',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      originalLyricsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalLyrics',
        value: '',
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      originalLyricsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'originalLyrics',
        value: '',
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposalIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proposalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposalIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proposalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposalIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proposalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposalIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proposalId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposalIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'proposalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposalIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'proposalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposalIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'proposalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposalIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'proposalId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proposalId',
        value: '',
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'proposalId',
        value: '',
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposedLyricsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proposedLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposedLyricsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proposedLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposedLyricsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proposedLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposedLyricsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proposedLyrics',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposedLyricsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'proposedLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposedLyricsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'proposedLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposedLyricsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'proposedLyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposedLyricsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'proposedLyrics',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposedLyricsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proposedLyrics',
        value: '',
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      proposedLyricsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'proposedLyrics',
        value: '',
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      syncStatusEqualTo(SyncStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      syncStatusGreaterThan(
    SyncStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      syncStatusLessThan(
    SyncStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      syncStatusBetween(
    SyncStatus lower,
    SyncStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension EditProposalQueryObject
    on QueryBuilder<EditProposal, EditProposal, QFilterCondition> {}

extension EditProposalQueryLinks
    on QueryBuilder<EditProposal, EditProposal, QFilterCondition> {}

extension EditProposalQuerySortBy
    on QueryBuilder<EditProposal, EditProposal, QSortBy> {
  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> sortByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.asc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> sortByCreatedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.desc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> sortByHymnId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.asc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> sortByHymnIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.desc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy>
      sortByOriginalLyrics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalLyrics', Sort.asc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy>
      sortByOriginalLyricsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalLyrics', Sort.desc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> sortByProposalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposalId', Sort.asc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy>
      sortByProposalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposalId', Sort.desc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy>
      sortByProposedLyrics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposedLyrics', Sort.asc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy>
      sortByProposedLyricsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposedLyrics', Sort.desc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy>
      sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension EditProposalQuerySortThenBy
    on QueryBuilder<EditProposal, EditProposal, QSortThenBy> {
  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> thenByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.asc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> thenByCreatedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.desc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> thenByHymnId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.asc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> thenByHymnIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hymnId', Sort.desc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy>
      thenByOriginalLyrics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalLyrics', Sort.asc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy>
      thenByOriginalLyricsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalLyrics', Sort.desc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> thenByProposalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposalId', Sort.asc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy>
      thenByProposalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposalId', Sort.desc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy>
      thenByProposedLyrics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposedLyrics', Sort.asc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy>
      thenByProposedLyricsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposedLyrics', Sort.desc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy>
      thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension EditProposalQueryWhereDistinct
    on QueryBuilder<EditProposal, EditProposal, QDistinct> {
  QueryBuilder<EditProposal, EditProposal, QDistinct> distinctByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdOn');
    });
  }

  QueryBuilder<EditProposal, EditProposal, QDistinct> distinctByHymnId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hymnId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QDistinct> distinctByOriginalLyrics(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originalLyrics',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QDistinct> distinctByProposalId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proposalId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QDistinct> distinctByProposedLyrics(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proposedLyrics',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EditProposal, EditProposal, QDistinct> distinctBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatus');
    });
  }

  QueryBuilder<EditProposal, EditProposal, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension EditProposalQueryProperty
    on QueryBuilder<EditProposal, EditProposal, QQueryProperty> {
  QueryBuilder<EditProposal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EditProposal, int, QQueryOperations> createdOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdOn');
    });
  }

  QueryBuilder<EditProposal, String, QQueryOperations> hymnIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hymnId');
    });
  }

  QueryBuilder<EditProposal, String, QQueryOperations>
      originalLyricsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originalLyrics');
    });
  }

  QueryBuilder<EditProposal, String, QQueryOperations> proposalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proposalId');
    });
  }

  QueryBuilder<EditProposal, String, QQueryOperations>
      proposedLyricsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proposedLyrics');
    });
  }

  QueryBuilder<EditProposal, SyncStatus, QQueryOperations>
      syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatus');
    });
  }

  QueryBuilder<EditProposal, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
