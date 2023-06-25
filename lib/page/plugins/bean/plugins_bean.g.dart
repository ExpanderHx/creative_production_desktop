// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugins_bean.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPluginsBeanCollection on Isar {
  IsarCollection<PluginsBean> get pluginsBeans => this.collection();
}

const PluginsBeanSchema = CollectionSchema(
  name: r'PluginsBean',
  id: 6260237489655869346,
  properties: {
    r'hotKeyJsonString': PropertySchema(
      id: 0,
      name: r'hotKeyJsonString',
      type: IsarType.string,
    ),
    r'isOpenShortcutKeys': PropertySchema(
      id: 1,
      name: r'isOpenShortcutKeys',
      type: IsarType.bool,
    ),
    r'prompt': PropertySchema(
      id: 2,
      name: r'prompt',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 3,
      name: r'title',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 4,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _pluginsBeanEstimateSize,
  serialize: _pluginsBeanSerialize,
  deserialize: _pluginsBeanDeserialize,
  deserializeProp: _pluginsBeanDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _pluginsBeanGetId,
  getLinks: _pluginsBeanGetLinks,
  attach: _pluginsBeanAttach,
  version: '3.1.0+1',
);

int _pluginsBeanEstimateSize(
  PluginsBean object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.hotKeyJsonString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.prompt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _pluginsBeanSerialize(
  PluginsBean object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.hotKeyJsonString);
  writer.writeBool(offsets[1], object.isOpenShortcutKeys);
  writer.writeString(offsets[2], object.prompt);
  writer.writeString(offsets[3], object.title);
  writer.writeString(offsets[4], object.type);
}

PluginsBean _pluginsBeanDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PluginsBean();
  object.hotKeyJsonString = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.isOpenShortcutKeys = reader.readBoolOrNull(offsets[1]);
  object.prompt = reader.readStringOrNull(offsets[2]);
  object.title = reader.readStringOrNull(offsets[3]);
  object.type = reader.readStringOrNull(offsets[4]);
  return object;
}

P _pluginsBeanDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pluginsBeanGetId(PluginsBean object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pluginsBeanGetLinks(PluginsBean object) {
  return [];
}

void _pluginsBeanAttach(
    IsarCollection<dynamic> col, Id id, PluginsBean object) {
  object.id = id;
}

extension PluginsBeanQueryWhereSort
    on QueryBuilder<PluginsBean, PluginsBean, QWhere> {
  QueryBuilder<PluginsBean, PluginsBean, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PluginsBeanQueryWhere
    on QueryBuilder<PluginsBean, PluginsBean, QWhereClause> {
  QueryBuilder<PluginsBean, PluginsBean, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterWhereClause> idBetween(
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

extension PluginsBeanQueryFilter
    on QueryBuilder<PluginsBean, PluginsBean, QFilterCondition> {
  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      hotKeyJsonStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hotKeyJsonString',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      hotKeyJsonStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hotKeyJsonString',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      hotKeyJsonStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hotKeyJsonString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      hotKeyJsonStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hotKeyJsonString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      hotKeyJsonStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hotKeyJsonString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      hotKeyJsonStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hotKeyJsonString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      hotKeyJsonStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hotKeyJsonString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      hotKeyJsonStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hotKeyJsonString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      hotKeyJsonStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hotKeyJsonString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      hotKeyJsonStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hotKeyJsonString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      hotKeyJsonStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hotKeyJsonString',
        value: '',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      hotKeyJsonStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hotKeyJsonString',
        value: '',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      isOpenShortcutKeysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isOpenShortcutKeys',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      isOpenShortcutKeysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isOpenShortcutKeys',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      isOpenShortcutKeysEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOpenShortcutKeys',
        value: value,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> promptIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'prompt',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      promptIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'prompt',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> promptEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prompt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      promptGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prompt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> promptLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prompt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> promptBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prompt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      promptStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'prompt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> promptEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'prompt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> promptContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'prompt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> promptMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'prompt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      promptIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prompt',
        value: '',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      promptIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'prompt',
        value: '',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> titleEqualTo(
    String? value, {
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      titleGreaterThan(
    String? value, {
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> titleLessThan(
    String? value, {
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> titleBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> titleStartsWith(
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> titleEndsWith(
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> titleContains(
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> titleMatches(
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> typeEqualTo(
    String? value, {
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> typeGreaterThan(
    String? value, {
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> typeLessThan(
    String? value, {
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> typeBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> typeStartsWith(
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> typeEndsWith(
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> typeContains(
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> typeMatches(
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

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension PluginsBeanQueryObject
    on QueryBuilder<PluginsBean, PluginsBean, QFilterCondition> {}

extension PluginsBeanQueryLinks
    on QueryBuilder<PluginsBean, PluginsBean, QFilterCondition> {}

extension PluginsBeanQuerySortBy
    on QueryBuilder<PluginsBean, PluginsBean, QSortBy> {
  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy>
      sortByHotKeyJsonString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotKeyJsonString', Sort.asc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy>
      sortByHotKeyJsonStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotKeyJsonString', Sort.desc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy>
      sortByIsOpenShortcutKeys() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOpenShortcutKeys', Sort.asc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy>
      sortByIsOpenShortcutKeysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOpenShortcutKeys', Sort.desc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy> sortByPrompt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prompt', Sort.asc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy> sortByPromptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prompt', Sort.desc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension PluginsBeanQuerySortThenBy
    on QueryBuilder<PluginsBean, PluginsBean, QSortThenBy> {
  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy>
      thenByHotKeyJsonString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotKeyJsonString', Sort.asc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy>
      thenByHotKeyJsonStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotKeyJsonString', Sort.desc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy>
      thenByIsOpenShortcutKeys() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOpenShortcutKeys', Sort.asc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy>
      thenByIsOpenShortcutKeysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOpenShortcutKeys', Sort.desc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy> thenByPrompt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prompt', Sort.asc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy> thenByPromptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prompt', Sort.desc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension PluginsBeanQueryWhereDistinct
    on QueryBuilder<PluginsBean, PluginsBean, QDistinct> {
  QueryBuilder<PluginsBean, PluginsBean, QDistinct> distinctByHotKeyJsonString(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hotKeyJsonString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QDistinct>
      distinctByIsOpenShortcutKeys() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOpenShortcutKeys');
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QDistinct> distinctByPrompt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prompt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PluginsBean, PluginsBean, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension PluginsBeanQueryProperty
    on QueryBuilder<PluginsBean, PluginsBean, QQueryProperty> {
  QueryBuilder<PluginsBean, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PluginsBean, String?, QQueryOperations>
      hotKeyJsonStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hotKeyJsonString');
    });
  }

  QueryBuilder<PluginsBean, bool?, QQueryOperations>
      isOpenShortcutKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOpenShortcutKeys');
    });
  }

  QueryBuilder<PluginsBean, String?, QQueryOperations> promptProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prompt');
    });
  }

  QueryBuilder<PluginsBean, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<PluginsBean, String?, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
