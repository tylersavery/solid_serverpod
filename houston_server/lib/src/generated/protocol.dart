/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_server/module.dart' as _i3;
import 'food.dart' as _i4;
import 'food_list.dart' as _i5;
import 'game.dart' as _i6;
import 'game_list.dart' as _i7;
import 'movie.dart' as _i8;
import 'movie_list.dart' as _i9;
import 'protocol.dart' as _i10;
export 'food.dart';
export 'food_list.dart';
export 'game.dart';
export 'game_list.dart';
export 'movie.dart';
export 'movie_list.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'food',
      dartName: 'FoodDTO',
      schema: 'public',
      module: 'houston',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'food_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'uid',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'price',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'calories',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'food_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'game',
      dartName: 'GameDTO',
      schema: 'public',
      module: 'houston',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'game_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'uid',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'price',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'players',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'game_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'movie',
      dartName: 'MovieDTO',
      schema: 'public',
      module: 'houston',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'movie_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'uid',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'year',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'movie_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i4.FoodDTO) {
      return _i4.FoodDTO.fromJson(data, this) as T;
    }
    if (t == _i5.FoodDTOList) {
      return _i5.FoodDTOList.fromJson(data, this) as T;
    }
    if (t == _i6.GameDTO) {
      return _i6.GameDTO.fromJson(data, this) as T;
    }
    if (t == _i7.GameDTOList) {
      return _i7.GameDTOList.fromJson(data, this) as T;
    }
    if (t == _i8.MovieDTO) {
      return _i8.MovieDTO.fromJson(data, this) as T;
    }
    if (t == _i9.MovieDTOList) {
      return _i9.MovieDTOList.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i4.FoodDTO?>()) {
      return (data != null ? _i4.FoodDTO.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i5.FoodDTOList?>()) {
      return (data != null ? _i5.FoodDTOList.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i6.GameDTO?>()) {
      return (data != null ? _i6.GameDTO.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i7.GameDTOList?>()) {
      return (data != null ? _i7.GameDTOList.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i8.MovieDTO?>()) {
      return (data != null ? _i8.MovieDTO.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i9.MovieDTOList?>()) {
      return (data != null ? _i9.MovieDTOList.fromJson(data, this) : null) as T;
    }
    if (t == List<_i10.FoodDTO>) {
      return (data as List).map((e) => deserialize<_i10.FoodDTO>(e)).toList()
          as dynamic;
    }
    if (t == List<_i10.GameDTO>) {
      return (data as List).map((e) => deserialize<_i10.GameDTO>(e)).toList()
          as dynamic;
    }
    if (t == List<_i10.MovieDTO>) {
      return (data as List).map((e) => deserialize<_i10.MovieDTO>(e)).toList()
          as dynamic;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    String? className;
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is _i4.FoodDTO) {
      return 'FoodDTO';
    }
    if (data is _i5.FoodDTOList) {
      return 'FoodDTOList';
    }
    if (data is _i6.GameDTO) {
      return 'GameDTO';
    }
    if (data is _i7.GameDTOList) {
      return 'GameDTOList';
    }
    if (data is _i8.MovieDTO) {
      return 'MovieDTO';
    }
    if (data is _i9.MovieDTOList) {
      return 'MovieDTOList';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'].startsWith('serverpod_auth.')) {
      data['className'] = data['className'].substring(15);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (data['className'] == 'FoodDTO') {
      return deserialize<_i4.FoodDTO>(data['data']);
    }
    if (data['className'] == 'FoodDTOList') {
      return deserialize<_i5.FoodDTOList>(data['data']);
    }
    if (data['className'] == 'GameDTO') {
      return deserialize<_i6.GameDTO>(data['data']);
    }
    if (data['className'] == 'GameDTOList') {
      return deserialize<_i7.GameDTOList>(data['data']);
    }
    if (data['className'] == 'MovieDTO') {
      return deserialize<_i8.MovieDTO>(data['data']);
    }
    if (data['className'] == 'MovieDTOList') {
      return deserialize<_i9.MovieDTOList>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i4.FoodDTO:
        return _i4.FoodDTO.t;
      case _i6.GameDTO:
        return _i6.GameDTO.t;
      case _i8.MovieDTO:
        return _i8.MovieDTO.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'houston';
}
