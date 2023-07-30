// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model_config.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChatModelConfigCollection on Isar {
  IsarCollection<ChatModelConfig> get chatModelConfigs => this.collection();
}

const ChatModelConfigSchema = CollectionSchema(
  name: r'ChatModelConfig',
  id: -2799598889464696024,
  properties: {
    r'baseUrl': PropertySchema(
      id: 0,
      name: r'baseUrl',
      type: IsarType.string,
    ),
    r'configName': PropertySchema(
      id: 1,
      name: r'configName',
      type: IsarType.string,
    ),
    r'historyLen': PropertySchema(
      id: 2,
      name: r'historyLen',
      type: IsarType.long,
    ),
    r'isGlobal': PropertySchema(
      id: 3,
      name: r'isGlobal',
      type: IsarType.bool,
    ),
    r'isHalf': PropertySchema(
      id: 4,
      name: r'isHalf',
      type: IsarType.bool,
    ),
    r'isLocal': PropertySchema(
      id: 5,
      name: r'isLocal',
      type: IsarType.bool,
    ),
    r'loadDevice': PropertySchema(
      id: 6,
      name: r'loadDevice',
      type: IsarType.string,
    ),
    r'maxToken': PropertySchema(
      id: 7,
      name: r'maxToken',
      type: IsarType.long,
    ),
    r'modelName': PropertySchema(
      id: 8,
      name: r'modelName',
      type: IsarType.string,
    ),
    r'modelPath': PropertySchema(
      id: 9,
      name: r'modelPath',
      type: IsarType.string,
    ),
    r'modelType': PropertySchema(
      id: 10,
      name: r'modelType',
      type: IsarType.string,
    ),
    r'temperature': PropertySchema(
      id: 11,
      name: r'temperature',
      type: IsarType.double,
    ),
    r'token': PropertySchema(
      id: 12,
      name: r'token',
      type: IsarType.string,
    ),
    r'tokenizerName': PropertySchema(
      id: 13,
      name: r'tokenizerName',
      type: IsarType.string,
    ),
    r'topP': PropertySchema(
      id: 14,
      name: r'topP',
      type: IsarType.long,
    )
  },
  estimateSize: _chatModelConfigEstimateSize,
  serialize: _chatModelConfigSerialize,
  deserialize: _chatModelConfigDeserialize,
  deserializeProp: _chatModelConfigDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _chatModelConfigGetId,
  getLinks: _chatModelConfigGetLinks,
  attach: _chatModelConfigAttach,
  version: '3.1.0+1',
);

int _chatModelConfigEstimateSize(
  ChatModelConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.baseUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.configName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.loadDevice;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.modelName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.modelPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.modelType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.token;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tokenizerName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _chatModelConfigSerialize(
  ChatModelConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.baseUrl);
  writer.writeString(offsets[1], object.configName);
  writer.writeLong(offsets[2], object.historyLen);
  writer.writeBool(offsets[3], object.isGlobal);
  writer.writeBool(offsets[4], object.isHalf);
  writer.writeBool(offsets[5], object.isLocal);
  writer.writeString(offsets[6], object.loadDevice);
  writer.writeLong(offsets[7], object.maxToken);
  writer.writeString(offsets[8], object.modelName);
  writer.writeString(offsets[9], object.modelPath);
  writer.writeString(offsets[10], object.modelType);
  writer.writeDouble(offsets[11], object.temperature);
  writer.writeString(offsets[12], object.token);
  writer.writeString(offsets[13], object.tokenizerName);
  writer.writeLong(offsets[14], object.topP);
}

ChatModelConfig _chatModelConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChatModelConfig();
  object.baseUrl = reader.readStringOrNull(offsets[0]);
  object.configName = reader.readStringOrNull(offsets[1]);
  object.historyLen = reader.readLongOrNull(offsets[2]);
  object.id = id;
  object.isGlobal = reader.readBoolOrNull(offsets[3]);
  object.isHalf = reader.readBoolOrNull(offsets[4]);
  object.isLocal = reader.readBoolOrNull(offsets[5]);
  object.loadDevice = reader.readStringOrNull(offsets[6]);
  object.maxToken = reader.readLongOrNull(offsets[7]);
  object.modelName = reader.readStringOrNull(offsets[8]);
  object.modelPath = reader.readStringOrNull(offsets[9]);
  object.modelType = reader.readStringOrNull(offsets[10]);
  object.temperature = reader.readDoubleOrNull(offsets[11]);
  object.token = reader.readStringOrNull(offsets[12]);
  object.tokenizerName = reader.readStringOrNull(offsets[13]);
  object.topP = reader.readLongOrNull(offsets[14]);
  return object;
}

P _chatModelConfigDeserializeProp<P>(
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
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readDoubleOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _chatModelConfigGetId(ChatModelConfig object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _chatModelConfigGetLinks(ChatModelConfig object) {
  return [];
}

void _chatModelConfigAttach(
    IsarCollection<dynamic> col, Id id, ChatModelConfig object) {
  object.id = id;
}

extension ChatModelConfigQueryWhereSort
    on QueryBuilder<ChatModelConfig, ChatModelConfig, QWhere> {
  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ChatModelConfigQueryWhere
    on QueryBuilder<ChatModelConfig, ChatModelConfig, QWhereClause> {
  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterWhereClause> idBetween(
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

extension ChatModelConfigQueryFilter
    on QueryBuilder<ChatModelConfig, ChatModelConfig, QFilterCondition> {
  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      baseUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'baseUrl',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      baseUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'baseUrl',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      baseUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'baseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      baseUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'baseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      baseUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'baseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      baseUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'baseUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      baseUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'baseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      baseUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'baseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      baseUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'baseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      baseUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'baseUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      baseUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'baseUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      baseUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'baseUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      configNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'configName',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      configNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'configName',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      configNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'configName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      configNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'configName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      configNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'configName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      configNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'configName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      configNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'configName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      configNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'configName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      configNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'configName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      configNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'configName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      configNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'configName',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      configNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'configName',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      historyLenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'historyLen',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      historyLenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'historyLen',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      historyLenEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'historyLen',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      historyLenGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'historyLen',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      historyLenLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'historyLen',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      historyLenBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'historyLen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      isGlobalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isGlobal',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      isGlobalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isGlobal',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      isGlobalEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isGlobal',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      isHalfIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isHalf',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      isHalfIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isHalf',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      isHalfEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isHalf',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      isLocalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isLocal',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      isLocalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isLocal',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      isLocalEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLocal',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      loadDeviceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'loadDevice',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      loadDeviceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'loadDevice',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      loadDeviceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loadDevice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      loadDeviceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loadDevice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      loadDeviceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loadDevice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      loadDeviceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loadDevice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      loadDeviceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'loadDevice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      loadDeviceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'loadDevice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      loadDeviceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'loadDevice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      loadDeviceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'loadDevice',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      loadDeviceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loadDevice',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      loadDeviceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'loadDevice',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      maxTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxToken',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      maxTokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxToken',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      maxTokenEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxToken',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      maxTokenGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxToken',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      maxTokenLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxToken',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      maxTokenBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxToken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'modelName',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'modelName',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modelName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modelName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modelName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'modelName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'modelName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'modelName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'modelName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelName',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'modelName',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'modelPath',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'modelPath',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modelPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modelPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modelPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'modelPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'modelPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'modelPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'modelPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelPath',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'modelPath',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'modelType',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'modelType',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modelType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modelType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modelType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'modelType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'modelType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'modelType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'modelType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelType',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      modelTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'modelType',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      temperatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'temperature',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      temperatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'temperature',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      temperatureEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'temperature',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      temperatureGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'temperature',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      temperatureLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'temperature',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      temperatureBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'temperature',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'token',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'token',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'token',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'token',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'token',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'token',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenizerNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tokenizerName',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenizerNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tokenizerName',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenizerNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tokenizerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenizerNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tokenizerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenizerNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tokenizerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenizerNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tokenizerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenizerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tokenizerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenizerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tokenizerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenizerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tokenizerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenizerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tokenizerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenizerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tokenizerName',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      tokenizerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tokenizerName',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      topPIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'topP',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      topPIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'topP',
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      topPEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topP',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      topPGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'topP',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      topPLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'topP',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterFilterCondition>
      topPBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'topP',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ChatModelConfigQueryObject
    on QueryBuilder<ChatModelConfig, ChatModelConfig, QFilterCondition> {}

extension ChatModelConfigQueryLinks
    on QueryBuilder<ChatModelConfig, ChatModelConfig, QFilterCondition> {}

extension ChatModelConfigQuerySortBy
    on QueryBuilder<ChatModelConfig, ChatModelConfig, QSortBy> {
  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy> sortByBaseUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseUrl', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByBaseUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseUrl', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByConfigName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configName', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByConfigNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configName', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByHistoryLen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyLen', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByHistoryLenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyLen', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByIsGlobal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGlobal', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByIsGlobalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGlobal', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy> sortByIsHalf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHalf', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByIsHalfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHalf', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy> sortByIsLocal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocal', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByIsLocalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocal', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByLoadDevice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loadDevice', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByLoadDeviceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loadDevice', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByMaxToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxToken', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByMaxTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxToken', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByModelName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelName', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByModelNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelName', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByModelPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelPath', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByModelPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelPath', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByModelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelType', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByModelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelType', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByTemperatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy> sortByToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByTokenizerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenizerName', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByTokenizerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenizerName', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy> sortByTopP() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topP', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      sortByTopPDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topP', Sort.desc);
    });
  }
}

extension ChatModelConfigQuerySortThenBy
    on QueryBuilder<ChatModelConfig, ChatModelConfig, QSortThenBy> {
  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy> thenByBaseUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseUrl', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByBaseUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseUrl', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByConfigName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configName', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByConfigNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configName', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByHistoryLen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyLen', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByHistoryLenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyLen', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByIsGlobal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGlobal', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByIsGlobalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGlobal', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy> thenByIsHalf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHalf', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByIsHalfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHalf', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy> thenByIsLocal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocal', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByIsLocalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocal', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByLoadDevice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loadDevice', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByLoadDeviceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loadDevice', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByMaxToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxToken', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByMaxTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxToken', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByModelName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelName', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByModelNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelName', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByModelPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelPath', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByModelPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelPath', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByModelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelType', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByModelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelType', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByTemperatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy> thenByToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByTokenizerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenizerName', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByTokenizerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenizerName', Sort.desc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy> thenByTopP() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topP', Sort.asc);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QAfterSortBy>
      thenByTopPDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topP', Sort.desc);
    });
  }
}

extension ChatModelConfigQueryWhereDistinct
    on QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct> {
  QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct> distinctByBaseUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'baseUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct>
      distinctByConfigName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'configName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct>
      distinctByHistoryLen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'historyLen');
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct>
      distinctByIsGlobal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGlobal');
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct> distinctByIsHalf() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isHalf');
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct>
      distinctByIsLocal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLocal');
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct>
      distinctByLoadDevice({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loadDevice', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct>
      distinctByMaxToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxToken');
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct> distinctByModelName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct> distinctByModelPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct> distinctByModelType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct>
      distinctByTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'temperature');
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct> distinctByToken(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'token', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct>
      distinctByTokenizerName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tokenizerName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatModelConfig, ChatModelConfig, QDistinct> distinctByTopP() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'topP');
    });
  }
}

extension ChatModelConfigQueryProperty
    on QueryBuilder<ChatModelConfig, ChatModelConfig, QQueryProperty> {
  QueryBuilder<ChatModelConfig, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ChatModelConfig, String?, QQueryOperations> baseUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'baseUrl');
    });
  }

  QueryBuilder<ChatModelConfig, String?, QQueryOperations>
      configNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'configName');
    });
  }

  QueryBuilder<ChatModelConfig, int?, QQueryOperations> historyLenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'historyLen');
    });
  }

  QueryBuilder<ChatModelConfig, bool?, QQueryOperations> isGlobalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGlobal');
    });
  }

  QueryBuilder<ChatModelConfig, bool?, QQueryOperations> isHalfProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isHalf');
    });
  }

  QueryBuilder<ChatModelConfig, bool?, QQueryOperations> isLocalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLocal');
    });
  }

  QueryBuilder<ChatModelConfig, String?, QQueryOperations>
      loadDeviceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loadDevice');
    });
  }

  QueryBuilder<ChatModelConfig, int?, QQueryOperations> maxTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxToken');
    });
  }

  QueryBuilder<ChatModelConfig, String?, QQueryOperations> modelNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelName');
    });
  }

  QueryBuilder<ChatModelConfig, String?, QQueryOperations> modelPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelPath');
    });
  }

  QueryBuilder<ChatModelConfig, String?, QQueryOperations> modelTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelType');
    });
  }

  QueryBuilder<ChatModelConfig, double?, QQueryOperations>
      temperatureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'temperature');
    });
  }

  QueryBuilder<ChatModelConfig, String?, QQueryOperations> tokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'token');
    });
  }

  QueryBuilder<ChatModelConfig, String?, QQueryOperations>
      tokenizerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tokenizerName');
    });
  }

  QueryBuilder<ChatModelConfig, int?, QQueryOperations> topPProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'topP');
    });
  }
}
