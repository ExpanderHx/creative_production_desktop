// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skin_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSkinDataCollection on Isar {
  IsarCollection<SkinData> get skinDatas => this.collection();
}

const SkinDataSchema = CollectionSchema(
  name: r'SkinData',
  id: -847994343802826633,
  properties: {
    r'darkFontColor': PropertySchema(
      id: 0,
      name: r'darkFontColor',
      type: IsarType.long,
    ),
    r'image': PropertySchema(
      id: 1,
      name: r'image',
      type: IsarType.string,
    ),
    r'isGlobal': PropertySchema(
      id: 2,
      name: r'isGlobal',
      type: IsarType.bool,
    ),
    r'lightFontColor': PropertySchema(
      id: 3,
      name: r'lightFontColor',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 5,
      name: r'type',
      type: IsarType.long,
    )
  },
  estimateSize: _skinDataEstimateSize,
  serialize: _skinDataSerialize,
  deserialize: _skinDataDeserialize,
  deserializeProp: _skinDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _skinDataGetId,
  getLinks: _skinDataGetLinks,
  attach: _skinDataAttach,
  version: '3.1.0+1',
);

int _skinDataEstimateSize(
  SkinData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.image;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _skinDataSerialize(
  SkinData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.darkFontColor);
  writer.writeString(offsets[1], object.image);
  writer.writeBool(offsets[2], object.isGlobal);
  writer.writeLong(offsets[3], object.lightFontColor);
  writer.writeString(offsets[4], object.name);
  writer.writeLong(offsets[5], object.type);
}

SkinData _skinDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SkinData();
  object.darkFontColor = reader.readLongOrNull(offsets[0]);
  object.id = id;
  object.image = reader.readStringOrNull(offsets[1]);
  object.isGlobal = reader.readBoolOrNull(offsets[2]);
  object.lightFontColor = reader.readLongOrNull(offsets[3]);
  object.name = reader.readStringOrNull(offsets[4]);
  object.type = reader.readLongOrNull(offsets[5]);
  return object;
}

P _skinDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _skinDataGetId(SkinData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _skinDataGetLinks(SkinData object) {
  return [];
}

void _skinDataAttach(IsarCollection<dynamic> col, Id id, SkinData object) {
  object.id = id;
}

extension SkinDataQueryWhereSort on QueryBuilder<SkinData, SkinData, QWhere> {
  QueryBuilder<SkinData, SkinData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SkinDataQueryWhere on QueryBuilder<SkinData, SkinData, QWhereClause> {
  QueryBuilder<SkinData, SkinData, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<SkinData, SkinData, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterWhereClause> idBetween(
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

extension SkinDataQueryFilter
    on QueryBuilder<SkinData, SkinData, QFilterCondition> {
  QueryBuilder<SkinData, SkinData, QAfterFilterCondition>
      darkFontColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'darkFontColor',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition>
      darkFontColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'darkFontColor',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> darkFontColorEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'darkFontColor',
        value: value,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition>
      darkFontColorGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'darkFontColor',
        value: value,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> darkFontColorLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'darkFontColor',
        value: value,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> darkFontColorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'darkFontColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> imageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> imageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> imageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> imageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> imageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> imageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> imageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> imageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> imageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> imageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> isGlobalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isGlobal',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> isGlobalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isGlobal',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> isGlobalEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isGlobal',
        value: value,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition>
      lightFontColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lightFontColor',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition>
      lightFontColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lightFontColor',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> lightFontColorEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lightFontColor',
        value: value,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition>
      lightFontColorGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lightFontColor',
        value: value,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition>
      lightFontColorLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lightFontColor',
        value: value,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> lightFontColorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lightFontColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> nameEqualTo(
    String? value, {
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

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> nameGreaterThan(
    String? value, {
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

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> nameLessThan(
    String? value, {
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

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> nameContains(
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

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> typeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> typeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> typeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterFilterCondition> typeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SkinDataQueryObject
    on QueryBuilder<SkinData, SkinData, QFilterCondition> {}

extension SkinDataQueryLinks
    on QueryBuilder<SkinData, SkinData, QFilterCondition> {}

extension SkinDataQuerySortBy on QueryBuilder<SkinData, SkinData, QSortBy> {
  QueryBuilder<SkinData, SkinData, QAfterSortBy> sortByDarkFontColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkFontColor', Sort.asc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> sortByDarkFontColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkFontColor', Sort.desc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> sortByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> sortByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> sortByIsGlobal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGlobal', Sort.asc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> sortByIsGlobalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGlobal', Sort.desc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> sortByLightFontColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightFontColor', Sort.asc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> sortByLightFontColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightFontColor', Sort.desc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension SkinDataQuerySortThenBy
    on QueryBuilder<SkinData, SkinData, QSortThenBy> {
  QueryBuilder<SkinData, SkinData, QAfterSortBy> thenByDarkFontColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkFontColor', Sort.asc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> thenByDarkFontColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkFontColor', Sort.desc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> thenByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> thenByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> thenByIsGlobal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGlobal', Sort.asc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> thenByIsGlobalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGlobal', Sort.desc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> thenByLightFontColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightFontColor', Sort.asc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> thenByLightFontColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightFontColor', Sort.desc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<SkinData, SkinData, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension SkinDataQueryWhereDistinct
    on QueryBuilder<SkinData, SkinData, QDistinct> {
  QueryBuilder<SkinData, SkinData, QDistinct> distinctByDarkFontColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'darkFontColor');
    });
  }

  QueryBuilder<SkinData, SkinData, QDistinct> distinctByImage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SkinData, SkinData, QDistinct> distinctByIsGlobal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGlobal');
    });
  }

  QueryBuilder<SkinData, SkinData, QDistinct> distinctByLightFontColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lightFontColor');
    });
  }

  QueryBuilder<SkinData, SkinData, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SkinData, SkinData, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }
}

extension SkinDataQueryProperty
    on QueryBuilder<SkinData, SkinData, QQueryProperty> {
  QueryBuilder<SkinData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SkinData, int?, QQueryOperations> darkFontColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'darkFontColor');
    });
  }

  QueryBuilder<SkinData, String?, QQueryOperations> imageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image');
    });
  }

  QueryBuilder<SkinData, bool?, QQueryOperations> isGlobalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGlobal');
    });
  }

  QueryBuilder<SkinData, int?, QQueryOperations> lightFontColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lightFontColor');
    });
  }

  QueryBuilder<SkinData, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<SkinData, int?, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
