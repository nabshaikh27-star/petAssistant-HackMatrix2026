// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortcut.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuickAccessShortcutCollection on Isar {
  IsarCollection<QuickAccessShortcut> get quickAccessShortcuts =>
      this.collection();
}

const QuickAccessShortcutSchema = CollectionSchema(
  name: r'QuickAccessShortcut',
  id: 8862538096602596540,
  properties: {
    r'doubleTapTargetPath': PropertySchema(
      id: 0,
      name: r'doubleTapTargetPath',
      type: IsarType.string,
    ),
    r'iconName': PropertySchema(
      id: 1,
      name: r'iconName',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 2,
      name: r'id',
      type: IsarType.string,
    ),
    r'label': PropertySchema(
      id: 3,
      name: r'label',
      type: IsarType.string,
    ),
    r'tripleTapTargetPath': PropertySchema(
      id: 4,
      name: r'tripleTapTargetPath',
      type: IsarType.string,
    )
  },
  estimateSize: _quickAccessShortcutEstimateSize,
  serialize: _quickAccessShortcutSerialize,
  deserialize: _quickAccessShortcutDeserialize,
  deserializeProp: _quickAccessShortcutDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _quickAccessShortcutGetId,
  getLinks: _quickAccessShortcutGetLinks,
  attach: _quickAccessShortcutAttach,
  version: '3.1.0+1',
);

int _quickAccessShortcutEstimateSize(
  QuickAccessShortcut object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.doubleTapTargetPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.iconName.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.label.length * 3;
  {
    final value = object.tripleTapTargetPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _quickAccessShortcutSerialize(
  QuickAccessShortcut object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.doubleTapTargetPath);
  writer.writeString(offsets[1], object.iconName);
  writer.writeString(offsets[2], object.id);
  writer.writeString(offsets[3], object.label);
  writer.writeString(offsets[4], object.tripleTapTargetPath);
}

QuickAccessShortcut _quickAccessShortcutDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuickAccessShortcut();
  object.doubleTapTargetPath = reader.readStringOrNull(offsets[0]);
  object.iconName = reader.readString(offsets[1]);
  object.id = reader.readString(offsets[2]);
  object.isarId = id;
  object.label = reader.readString(offsets[3]);
  object.tripleTapTargetPath = reader.readStringOrNull(offsets[4]);
  return object;
}

P _quickAccessShortcutDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quickAccessShortcutGetId(QuickAccessShortcut object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _quickAccessShortcutGetLinks(
    QuickAccessShortcut object) {
  return [];
}

void _quickAccessShortcutAttach(
    IsarCollection<dynamic> col, Id id, QuickAccessShortcut object) {
  object.isarId = id;
}

extension QuickAccessShortcutByIndex on IsarCollection<QuickAccessShortcut> {
  Future<QuickAccessShortcut?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  QuickAccessShortcut? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<QuickAccessShortcut?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<QuickAccessShortcut?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(QuickAccessShortcut object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(QuickAccessShortcut object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<QuickAccessShortcut> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<QuickAccessShortcut> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension QuickAccessShortcutQueryWhereSort
    on QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QWhere> {
  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension QuickAccessShortcutQueryWhere
    on QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QWhereClause> {
  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterWhereClause>
      isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterWhereClause>
      idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterWhereClause>
      idNotEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }
}

extension QuickAccessShortcutQueryFilter on QueryBuilder<QuickAccessShortcut,
    QuickAccessShortcut, QFilterCondition> {
  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      doubleTapTargetPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'doubleTapTargetPath',
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      doubleTapTargetPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'doubleTapTargetPath',
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      doubleTapTargetPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doubleTapTargetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      doubleTapTargetPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'doubleTapTargetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      doubleTapTargetPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'doubleTapTargetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      doubleTapTargetPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'doubleTapTargetPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      doubleTapTargetPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'doubleTapTargetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      doubleTapTargetPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'doubleTapTargetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      doubleTapTargetPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'doubleTapTargetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      doubleTapTargetPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'doubleTapTargetPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      doubleTapTargetPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doubleTapTargetPath',
        value: '',
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      doubleTapTargetPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'doubleTapTargetPath',
        value: '',
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      iconNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      iconNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      iconNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      iconNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      iconNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      iconNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      iconNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      iconNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'iconName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      iconNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconName',
        value: '',
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      iconNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'iconName',
        value: '',
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      labelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      labelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      labelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      labelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'label',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      labelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      labelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'label',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      tripleTapTargetPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tripleTapTargetPath',
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      tripleTapTargetPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tripleTapTargetPath',
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      tripleTapTargetPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tripleTapTargetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      tripleTapTargetPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tripleTapTargetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      tripleTapTargetPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tripleTapTargetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      tripleTapTargetPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tripleTapTargetPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      tripleTapTargetPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tripleTapTargetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      tripleTapTargetPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tripleTapTargetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      tripleTapTargetPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tripleTapTargetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      tripleTapTargetPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tripleTapTargetPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      tripleTapTargetPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tripleTapTargetPath',
        value: '',
      ));
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterFilterCondition>
      tripleTapTargetPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tripleTapTargetPath',
        value: '',
      ));
    });
  }
}

extension QuickAccessShortcutQueryObject on QueryBuilder<QuickAccessShortcut,
    QuickAccessShortcut, QFilterCondition> {}

extension QuickAccessShortcutQueryLinks on QueryBuilder<QuickAccessShortcut,
    QuickAccessShortcut, QFilterCondition> {}

extension QuickAccessShortcutQuerySortBy
    on QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QSortBy> {
  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      sortByDoubleTapTargetPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doubleTapTargetPath', Sort.asc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      sortByDoubleTapTargetPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doubleTapTargetPath', Sort.desc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      sortByIconName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconName', Sort.asc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      sortByIconNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconName', Sort.desc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      sortByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      sortByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      sortByTripleTapTargetPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tripleTapTargetPath', Sort.asc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      sortByTripleTapTargetPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tripleTapTargetPath', Sort.desc);
    });
  }
}

extension QuickAccessShortcutQuerySortThenBy
    on QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QSortThenBy> {
  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      thenByDoubleTapTargetPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doubleTapTargetPath', Sort.asc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      thenByDoubleTapTargetPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doubleTapTargetPath', Sort.desc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      thenByIconName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconName', Sort.asc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      thenByIconNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconName', Sort.desc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      thenByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      thenByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      thenByTripleTapTargetPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tripleTapTargetPath', Sort.asc);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QAfterSortBy>
      thenByTripleTapTargetPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tripleTapTargetPath', Sort.desc);
    });
  }
}

extension QuickAccessShortcutQueryWhereDistinct
    on QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QDistinct> {
  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QDistinct>
      distinctByDoubleTapTargetPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'doubleTapTargetPath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QDistinct>
      distinctByIconName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QDistinct>
      distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QDistinct>
      distinctByLabel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'label', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QDistinct>
      distinctByTripleTapTargetPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tripleTapTargetPath',
          caseSensitive: caseSensitive);
    });
  }
}

extension QuickAccessShortcutQueryProperty
    on QueryBuilder<QuickAccessShortcut, QuickAccessShortcut, QQueryProperty> {
  QueryBuilder<QuickAccessShortcut, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<QuickAccessShortcut, String?, QQueryOperations>
      doubleTapTargetPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'doubleTapTargetPath');
    });
  }

  QueryBuilder<QuickAccessShortcut, String, QQueryOperations>
      iconNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconName');
    });
  }

  QueryBuilder<QuickAccessShortcut, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuickAccessShortcut, String, QQueryOperations> labelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'label');
    });
  }

  QueryBuilder<QuickAccessShortcut, String?, QQueryOperations>
      tripleTapTargetPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tripleTapTargetPath');
    });
  }
}
