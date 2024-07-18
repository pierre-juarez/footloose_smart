// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.schema.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetConfigurationCollection on Isar {
  IsarCollection<Configuration> get configurations => this.collection();
}

const ConfigurationSchema = CollectionSchema(
  name: r'Configuration',
  id: -1441735911786269971,
  properties: {
    r'ambiente': PropertySchema(
      id: 0,
      name: r'ambiente',
      type: IsarType.string,
    ),
    r'clave': PropertySchema(
      id: 1,
      name: r'clave',
      type: IsarType.string,
    ),
    r'idConfig': PropertySchema(
      id: 2,
      name: r'idConfig',
      type: IsarType.long,
    ),
    r'idOption': PropertySchema(
      id: 3,
      name: r'idOption',
      type: IsarType.long,
    ),
    r'typeRequest': PropertySchema(
      id: 4,
      name: r'typeRequest',
      type: IsarType.string,
    ),
    r'valor': PropertySchema(
      id: 5,
      name: r'valor',
      type: IsarType.string,
    )
  },
  estimateSize: _configurationEstimateSize,
  serialize: _configurationSerialize,
  deserialize: _configurationDeserialize,
  deserializeProp: _configurationDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _configurationGetId,
  getLinks: _configurationGetLinks,
  attach: _configurationAttach,
  version: '3.1.0+1',
);

int _configurationEstimateSize(
  Configuration object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.ambiente;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.clave;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.typeRequest;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.valor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _configurationSerialize(
  Configuration object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ambiente);
  writer.writeString(offsets[1], object.clave);
  writer.writeLong(offsets[2], object.idConfig);
  writer.writeLong(offsets[3], object.idOption);
  writer.writeString(offsets[4], object.typeRequest);
  writer.writeString(offsets[5], object.valor);
}

Configuration _configurationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Configuration();
  object.ambiente = reader.readStringOrNull(offsets[0]);
  object.clave = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.idConfig = reader.readLongOrNull(offsets[2]);
  object.idOption = reader.readLongOrNull(offsets[3]);
  object.typeRequest = reader.readStringOrNull(offsets[4]);
  object.valor = reader.readStringOrNull(offsets[5]);
  return object;
}

P _configurationDeserializeProp<P>(
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
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _configurationGetId(Configuration object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _configurationGetLinks(Configuration object) {
  return [];
}

void _configurationAttach(
    IsarCollection<dynamic> col, Id id, Configuration object) {
  object.id = id;
}

extension ConfigurationQueryWhereSort
    on QueryBuilder<Configuration, Configuration, QWhere> {
  QueryBuilder<Configuration, Configuration, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ConfigurationQueryWhere
    on QueryBuilder<Configuration, Configuration, QWhereClause> {
  QueryBuilder<Configuration, Configuration, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<Configuration, Configuration, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterWhereClause> idBetween(
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

extension ConfigurationQueryFilter
    on QueryBuilder<Configuration, Configuration, QFilterCondition> {
  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      ambienteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ambiente',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      ambienteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ambiente',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      ambienteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ambiente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      ambienteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ambiente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      ambienteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ambiente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      ambienteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ambiente',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      ambienteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ambiente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      ambienteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ambiente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      ambienteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ambiente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      ambienteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ambiente',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      ambienteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ambiente',
        value: '',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      ambienteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ambiente',
        value: '',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      claveIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'clave',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      claveIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'clave',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      claveEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clave',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      claveGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clave',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      claveLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clave',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      claveBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clave',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      claveStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clave',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      claveEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clave',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      claveContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clave',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      claveMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clave',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      claveIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clave',
        value: '',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      claveIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clave',
        value: '',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
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

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      idConfigIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idConfig',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      idConfigIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idConfig',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      idConfigEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idConfig',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      idConfigGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idConfig',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      idConfigLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idConfig',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      idConfigBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idConfig',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      idOptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idOption',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      idOptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idOption',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      idOptionEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idOption',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      idOptionGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idOption',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      idOptionLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idOption',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      idOptionBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idOption',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      typeRequestIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'typeRequest',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      typeRequestIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'typeRequest',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      typeRequestEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typeRequest',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      typeRequestGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'typeRequest',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      typeRequestLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'typeRequest',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      typeRequestBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'typeRequest',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      typeRequestStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'typeRequest',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      typeRequestEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'typeRequest',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      typeRequestContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'typeRequest',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      typeRequestMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'typeRequest',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      typeRequestIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typeRequest',
        value: '',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      typeRequestIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'typeRequest',
        value: '',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      valorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'valor',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      valorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'valor',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      valorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      valorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      valorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      valorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      valorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'valor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      valorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'valor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      valorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'valor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      valorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'valor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      valorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valor',
        value: '',
      ));
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterFilterCondition>
      valorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'valor',
        value: '',
      ));
    });
  }
}

extension ConfigurationQueryObject
    on QueryBuilder<Configuration, Configuration, QFilterCondition> {}

extension ConfigurationQueryLinks
    on QueryBuilder<Configuration, Configuration, QFilterCondition> {}

extension ConfigurationQuerySortBy
    on QueryBuilder<Configuration, Configuration, QSortBy> {
  QueryBuilder<Configuration, Configuration, QAfterSortBy> sortByAmbiente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ambiente', Sort.asc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy>
      sortByAmbienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ambiente', Sort.desc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> sortByClave() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clave', Sort.asc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> sortByClaveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clave', Sort.desc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> sortByIdConfig() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idConfig', Sort.asc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy>
      sortByIdConfigDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idConfig', Sort.desc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> sortByIdOption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idOption', Sort.asc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy>
      sortByIdOptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idOption', Sort.desc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> sortByTypeRequest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeRequest', Sort.asc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy>
      sortByTypeRequestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeRequest', Sort.desc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> sortByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.asc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> sortByValorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.desc);
    });
  }
}

extension ConfigurationQuerySortThenBy
    on QueryBuilder<Configuration, Configuration, QSortThenBy> {
  QueryBuilder<Configuration, Configuration, QAfterSortBy> thenByAmbiente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ambiente', Sort.asc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy>
      thenByAmbienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ambiente', Sort.desc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> thenByClave() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clave', Sort.asc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> thenByClaveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clave', Sort.desc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> thenByIdConfig() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idConfig', Sort.asc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy>
      thenByIdConfigDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idConfig', Sort.desc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> thenByIdOption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idOption', Sort.asc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy>
      thenByIdOptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idOption', Sort.desc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> thenByTypeRequest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeRequest', Sort.asc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy>
      thenByTypeRequestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeRequest', Sort.desc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> thenByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.asc);
    });
  }

  QueryBuilder<Configuration, Configuration, QAfterSortBy> thenByValorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.desc);
    });
  }
}

extension ConfigurationQueryWhereDistinct
    on QueryBuilder<Configuration, Configuration, QDistinct> {
  QueryBuilder<Configuration, Configuration, QDistinct> distinctByAmbiente(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ambiente', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Configuration, Configuration, QDistinct> distinctByClave(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clave', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Configuration, Configuration, QDistinct> distinctByIdConfig() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idConfig');
    });
  }

  QueryBuilder<Configuration, Configuration, QDistinct> distinctByIdOption() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idOption');
    });
  }

  QueryBuilder<Configuration, Configuration, QDistinct> distinctByTypeRequest(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'typeRequest', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Configuration, Configuration, QDistinct> distinctByValor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valor', caseSensitive: caseSensitive);
    });
  }
}

extension ConfigurationQueryProperty
    on QueryBuilder<Configuration, Configuration, QQueryProperty> {
  QueryBuilder<Configuration, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Configuration, String?, QQueryOperations> ambienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ambiente');
    });
  }

  QueryBuilder<Configuration, String?, QQueryOperations> claveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clave');
    });
  }

  QueryBuilder<Configuration, int?, QQueryOperations> idConfigProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idConfig');
    });
  }

  QueryBuilder<Configuration, int?, QQueryOperations> idOptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idOption');
    });
  }

  QueryBuilder<Configuration, String?, QQueryOperations> typeRequestProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'typeRequest');
    });
  }

  QueryBuilder<Configuration, String?, QQueryOperations> valorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valor');
    });
  }
}
