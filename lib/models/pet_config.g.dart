// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_config.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPetConfigCollection on Isar {
  IsarCollection<PetConfig> get petConfigs => this.collection();
}

const PetConfigSchema = CollectionSchema(
  name: r'PetConfig',
  id: 992227504113812979,
  properties: {
    r'activeAnimationSet': PropertySchema(
      id: 0,
      name: r'activeAnimationSet',
      type: IsarType.string,
    ),
    r'hotkeyJson': PropertySchema(
      id: 1,
      name: r'hotkeyJson',
      type: IsarType.string,
    ),
    r'hotkeyMode': PropertySchema(
      id: 2,
      name: r'hotkeyMode',
      type: IsarType.string,
    ),
    r'launchOnStartup': PropertySchema(
      id: 3,
      name: r'launchOnStartup',
      type: IsarType.bool,
    ),
    r'petImagePath': PropertySchema(
      id: 4,
      name: r'petImagePath',
      type: IsarType.string,
    ),
    r'positionX': PropertySchema(
      id: 5,
      name: r'positionX',
      type: IsarType.double,
    ),
    r'positionY': PropertySchema(
      id: 6,
      name: r'positionY',
      type: IsarType.double,
    ),
    r'size': PropertySchema(
      id: 7,
      name: r'size',
      type: IsarType.double,
    )
  },
  estimateSize: _petConfigEstimateSize,
  serialize: _petConfigSerialize,
  deserialize: _petConfigDeserialize,
  deserializeProp: _petConfigDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _petConfigGetId,
  getLinks: _petConfigGetLinks,
  attach: _petConfigAttach,
  version: '3.1.0+1',
);

int _petConfigEstimateSize(
  PetConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.activeAnimationSet;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.hotkeyJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.hotkeyMode.length * 3;
  {
    final value = object.petImagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _petConfigSerialize(
  PetConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activeAnimationSet);
  writer.writeString(offsets[1], object.hotkeyJson);
  writer.writeString(offsets[2], object.hotkeyMode);
  writer.writeBool(offsets[3], object.launchOnStartup);
  writer.writeString(offsets[4], object.petImagePath);
  writer.writeDouble(offsets[5], object.positionX);
  writer.writeDouble(offsets[6], object.positionY);
  writer.writeDouble(offsets[7], object.size);
}

PetConfig _petConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PetConfig();
  object.activeAnimationSet = reader.readStringOrNull(offsets[0]);
  object.hotkeyJson = reader.readStringOrNull(offsets[1]);
  object.hotkeyMode = reader.readString(offsets[2]);
  object.id = id;
  object.launchOnStartup = reader.readBool(offsets[3]);
  object.petImagePath = reader.readStringOrNull(offsets[4]);
  object.positionX = reader.readDouble(offsets[5]);
  object.positionY = reader.readDouble(offsets[6]);
  object.size = reader.readDouble(offsets[7]);
  return object;
}

P _petConfigDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _petConfigGetId(PetConfig object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _petConfigGetLinks(PetConfig object) {
  return [];
}

void _petConfigAttach(IsarCollection<dynamic> col, Id id, PetConfig object) {
  object.id = id;
}

extension PetConfigQueryWhereSort
    on QueryBuilder<PetConfig, PetConfig, QWhere> {
  QueryBuilder<PetConfig, PetConfig, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PetConfigQueryWhere
    on QueryBuilder<PetConfig, PetConfig, QWhereClause> {
  QueryBuilder<PetConfig, PetConfig, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<PetConfig, PetConfig, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterWhereClause> idBetween(
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
}

extension PetConfigQueryFilter
    on QueryBuilder<PetConfig, PetConfig, QFilterCondition> {
  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      activeAnimationSetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activeAnimationSet',
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      activeAnimationSetIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activeAnimationSet',
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      activeAnimationSetEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activeAnimationSet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      activeAnimationSetGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activeAnimationSet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      activeAnimationSetLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activeAnimationSet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      activeAnimationSetBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activeAnimationSet',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      activeAnimationSetStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'activeAnimationSet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      activeAnimationSetEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'activeAnimationSet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      activeAnimationSetContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activeAnimationSet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      activeAnimationSetMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activeAnimationSet',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      activeAnimationSetIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activeAnimationSet',
        value: '',
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      activeAnimationSetIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activeAnimationSet',
        value: '',
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> hotkeyJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hotkeyJson',
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      hotkeyJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hotkeyJson',
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> hotkeyJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hotkeyJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      hotkeyJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hotkeyJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> hotkeyJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hotkeyJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> hotkeyJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hotkeyJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      hotkeyJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hotkeyJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> hotkeyJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hotkeyJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> hotkeyJsonContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hotkeyJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> hotkeyJsonMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hotkeyJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      hotkeyJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hotkeyJson',
        value: '',
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      hotkeyJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hotkeyJson',
        value: '',
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> hotkeyModeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hotkeyMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      hotkeyModeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hotkeyMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> hotkeyModeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hotkeyMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> hotkeyModeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hotkeyMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      hotkeyModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hotkeyMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> hotkeyModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hotkeyMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> hotkeyModeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hotkeyMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> hotkeyModeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hotkeyMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      hotkeyModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hotkeyMode',
        value: '',
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      hotkeyModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hotkeyMode',
        value: '',
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      launchOnStartupEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'launchOnStartup',
        value: value,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      petImagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'petImagePath',
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      petImagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'petImagePath',
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> petImagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'petImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      petImagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'petImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      petImagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'petImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> petImagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'petImagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      petImagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'petImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      petImagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'petImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      petImagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'petImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> petImagePathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'petImagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      petImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'petImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      petImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'petImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> positionXEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'positionX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      positionXGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'positionX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> positionXLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'positionX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> positionXBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'positionX',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> positionYEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'positionY',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition>
      positionYGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'positionY',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> positionYLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'positionY',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> positionYBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'positionY',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> sizeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> sizeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> sizeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterFilterCondition> sizeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension PetConfigQueryObject
    on QueryBuilder<PetConfig, PetConfig, QFilterCondition> {}

extension PetConfigQueryLinks
    on QueryBuilder<PetConfig, PetConfig, QFilterCondition> {}

extension PetConfigQuerySortBy on QueryBuilder<PetConfig, PetConfig, QSortBy> {
  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> sortByActiveAnimationSet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeAnimationSet', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy>
      sortByActiveAnimationSetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeAnimationSet', Sort.desc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> sortByHotkeyJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotkeyJson', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> sortByHotkeyJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotkeyJson', Sort.desc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> sortByHotkeyMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotkeyMode', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> sortByHotkeyModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotkeyMode', Sort.desc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> sortByLaunchOnStartup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'launchOnStartup', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> sortByLaunchOnStartupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'launchOnStartup', Sort.desc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> sortByPetImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petImagePath', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> sortByPetImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petImagePath', Sort.desc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> sortByPositionX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionX', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> sortByPositionXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionX', Sort.desc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> sortByPositionY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionY', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> sortByPositionYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionY', Sort.desc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> sortBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> sortBySizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.desc);
    });
  }
}

extension PetConfigQuerySortThenBy
    on QueryBuilder<PetConfig, PetConfig, QSortThenBy> {
  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenByActiveAnimationSet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeAnimationSet', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy>
      thenByActiveAnimationSetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeAnimationSet', Sort.desc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenByHotkeyJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotkeyJson', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenByHotkeyJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotkeyJson', Sort.desc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenByHotkeyMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotkeyMode', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenByHotkeyModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotkeyMode', Sort.desc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenByLaunchOnStartup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'launchOnStartup', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenByLaunchOnStartupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'launchOnStartup', Sort.desc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenByPetImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petImagePath', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenByPetImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petImagePath', Sort.desc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenByPositionX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionX', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenByPositionXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionX', Sort.desc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenByPositionY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionY', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenByPositionYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionY', Sort.desc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.asc);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QAfterSortBy> thenBySizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.desc);
    });
  }
}

extension PetConfigQueryWhereDistinct
    on QueryBuilder<PetConfig, PetConfig, QDistinct> {
  QueryBuilder<PetConfig, PetConfig, QDistinct> distinctByActiveAnimationSet(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activeAnimationSet',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QDistinct> distinctByHotkeyJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hotkeyJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QDistinct> distinctByHotkeyMode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hotkeyMode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QDistinct> distinctByLaunchOnStartup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'launchOnStartup');
    });
  }

  QueryBuilder<PetConfig, PetConfig, QDistinct> distinctByPetImagePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'petImagePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PetConfig, PetConfig, QDistinct> distinctByPositionX() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'positionX');
    });
  }

  QueryBuilder<PetConfig, PetConfig, QDistinct> distinctByPositionY() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'positionY');
    });
  }

  QueryBuilder<PetConfig, PetConfig, QDistinct> distinctBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'size');
    });
  }
}

extension PetConfigQueryProperty
    on QueryBuilder<PetConfig, PetConfig, QQueryProperty> {
  QueryBuilder<PetConfig, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PetConfig, String?, QQueryOperations>
      activeAnimationSetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activeAnimationSet');
    });
  }

  QueryBuilder<PetConfig, String?, QQueryOperations> hotkeyJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hotkeyJson');
    });
  }

  QueryBuilder<PetConfig, String, QQueryOperations> hotkeyModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hotkeyMode');
    });
  }

  QueryBuilder<PetConfig, bool, QQueryOperations> launchOnStartupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'launchOnStartup');
    });
  }

  QueryBuilder<PetConfig, String?, QQueryOperations> petImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'petImagePath');
    });
  }

  QueryBuilder<PetConfig, double, QQueryOperations> positionXProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'positionX');
    });
  }

  QueryBuilder<PetConfig, double, QQueryOperations> positionYProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'positionY');
    });
  }

  QueryBuilder<PetConfig, double, QQueryOperations> sizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'size');
    });
  }
}
