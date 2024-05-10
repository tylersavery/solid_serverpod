import 'package:houston_cli/constants.dart';
import 'package:houston_cli/models/blueprint_property.dart';
import 'package:houston_cli/serializers/blueprint_serializer.dart';
import 'package:houston_cli/utils/string_utils.dart';
import 'package:collection/collection.dart';

class FlutterBlueprintSerializer extends BlueprintSerializer {
  const FlutterBlueprintSerializer({required super.blueprint});

  // Models
  List<String> get toJsonFunctions {
    if (Constants.serverBackend == ServerBackendOption.serverpod) {
      return [];
    }

    final List<String> items = [];

    for (final property in properties) {
      if (!Constants.primitives.contains(property.type)) {
        items.add(
            "int ${camelCase(property.type)}ToJson(${pascalCase(property.type)} ${camelCase(property.name)}) => ${camelCase(property.name)}.id ?? 0;");
      }
    }
    return items;
  }

  List<String> get modelImports {
    final List<String> items = [];
    for (final p in properties) {
      if (!Constants.primitives.contains(p.type)) {
        if (p.type == "user") {
          // items.add("import 'package:app/src/core/utils/user_utils.dart';");
          // items.add("import 'package:supabase_flutter/supabase_flutter.dart';");
        } else {
          items.add("import '../../../${snakeCase(p.type)}/domain/models/${snakeCase(p.type)}_model.dart';");
        }
      }
    }

    return items;
  }

  List<String> get emptyParams {
    final List<String> items = [];

    for (final property in properties) {
      final value = property.flutterEmptyParam;
      if (value != null) {
        items.add('${camelCase(property.name)}: $value');
      }
    }
    return items;
  }

  // Form State

  List<String> get formStateImports {
    final List<String> items = [];
    for (final p in properties) {
      if (!Constants.primitives.contains(p.type)) {
        if (p.type == "user") {
          // items.add("import 'package:app/src/core/utils/user_utils.dart';");
          // items.add("import 'package:supabase_flutter/supabase_flutter.dart';");
        } else {
          items.add("import '../../../${snakeCase(p.type)}/domain/models/${snakeCase(p.type)}_model.dart';");
        }
      }
    }

    return items;
  }

  //Form Provider
  List<String> get formProviderImports {
    final List<String> importStrings = [];
    for (final p in properties) {
      if (Constants.hiddenFields.contains(p.name)) {
        continue;
      }

      if (!Constants.primitives.contains(p.type) && p.type.toLowerCase() != "profile") {
        importStrings.add("import '../../../${snakeCase(p.type)}/domain/models/${snakeCase(p.type)}_model.dart';");
      }
    }

    return importStrings;
  }

  List<String> get formControllers {
    final List<String> items = [];
    for (final property in properties) {
      if (Constants.hiddenFields.contains(property.name)) {
        continue;
      }
      if (Constants.formElementTypes.contains(property.type)) {
        items.add("final ${camelCase(property.name)}Controller = TextEditingController();");
      }
    }
    return items;
  }

  List<String> get formValidators {
    final List<String> items = [];

    for (final property in properties) {
      if (Constants.hiddenFields.contains(property.name)) {
        continue;
      }

      if (Constants.formElementTypes.contains(property.type)) {
        if (!property.allowNull) {
          items.add(
              'String? ${camelCase(property.name)}Validator(String? value) => ValidationUtils.formValidatorNotEmpty(value, "${titleCase(property.name)}");');
        }
      }
    }
    return items;
  }

  List<String> get formSetters {
    final List<String> items = [];

    for (final property in properties) {
      if (Constants.hiddenFields.contains(property.name)) {
        continue;
      }

      if (!Constants.formElementTypes.contains(property.type)) {
        if (property.name == 'createdAt' || property.name == 'updatedAt') {
          continue;
        }

        items.add("""
  void set${pascalCase(property.name)}(${property.dartTypeAsString} value) {
    state = state.update${pascalCase(name)}(
      state.${camelCase(name)}.copyWith(${camelCase(property.name)}: value),
    );
  }

""");
      }
    }
    return items;
  }

  List<String> get formControllerRefreshers {
    final List<String> items = [];
    for (final property in properties) {
      if (Constants.hiddenFields.contains(property.name)) {
        continue;
      }
      if (Constants.formElementTypes.contains(property.type)) {
        if (property.isStringish) {
          items.add("${camelCase(property.name)}Controller.text = state.${camelCase(name)}.${camelCase(property.name)};");
        } else if (property.isNumeric) {
          items.add("${camelCase(property.name)}Controller.text = state.${camelCase(name)}.${camelCase(property.name)}.toString();");
        }
      }
    }
    return items;
  }

  List<String> get formControllerSetters {
    final List<String> items = [];
    for (final property in properties) {
      if (Constants.hiddenFields.contains(property.name)) {
        continue;
      }
      if (Constants.formElementTypes.contains(property.type)) {
        if (property.isStringish) {
          items.add("${camelCase(property.name)}: ${camelCase(property.name)}Controller.text");
        } else if (property.type == 'int') {
          items.add("${camelCase(property.name)}: int.tryParse(${camelCase(property.name)}Controller.text) ?? 0");
        } else if (property.type == 'double') {
          items.add("${camelCase(property.name)}: double.tryParse(${camelCase(property.name)}Controller.text) ?? 0.0");
        }
      }
    }
    return items;
  }

  // Form Widget

  List<String> get formImports {
    final List<String> importStrings = [];
    bool includeButton = false;
    bool includeImageUploader = false;
    for (final p in properties) {
      if (Constants.hiddenFields.contains(p.name)) {
        continue;
      }

      if (!Constants.primitives.contains(p.type) && p.type.toLowerCase() != "profile") {
        importStrings.add("import '../../../${snakeCase(p.type)}/domain/models/${snakeCase(p.type)}_model.dart';");
        importStrings.add("import '../../../${snakeCase(p.type)}/presentation/widgets/${snakeCase(p.type)}_infinite_list_widget.dart';");
        includeButton = true;
      }
      if (p.isImage) {
        includeImageUploader = true;
      }
    }
    if (includeButton) {
      importStrings.insert(0, "import '../../../../core/theme/buttons.dart';");
    }

    if (includeImageUploader) {
      importStrings.insert(0, "import '../../../asset/presentation/widgets/upload_image_widget.dart';");
    }

    return importStrings;
  }

  List<String> get formInputs {
    final List<String> items = [];
    for (final property in properties) {
      if (Constants.hiddenFields.contains(property.name)) {
        continue;
      }

      if (Constants.formElementTypes.contains(property.type)) {
        final value = property.type == 'text'
            ? """
TextFormField(
                controller: provider.${camelCase(property.name)}Controller,
                validator: provider.${camelCase(property.name)}Validator,
                decoration: const InputDecoration(label: Text("${titleCase(property.name)}")),
                minLines: 3,
                maxLines: 3,
              ),
"""
            : """
TextFormField(
                controller: provider.${camelCase(property.name)}Controller,
                validator: provider.${camelCase(property.name)}Validator,
                decoration: const InputDecoration(label: Text("${titleCase(property.name)}")),
              ),
""";
        items.add(value);
      } else if (property.type.toLowerCase() == "datetime") {
        //TODO: handle if needed
      } else if (property.isImage) {
        final value = """
Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
      child: UploadImageWidget(
        url: state.${camelCase(name)}.${property.name},
        label: "${titleCase(property.name)}",
        onComplete: (url) {
          provider.setImageUrl(url);
        },
      ),
    ),
""";
        items.add(value);
      } else if (property.type.toLowerCase() != "profile") {
        final uiHeading = properties.firstWhereOrNull((p) => p.uiHeading == 1)?.name ?? 'uuid';
        final value = """
ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("${titleCase(property.name)}"),
                subtitle: state.${camelCase(name)}.${camelCase(property.name)}.exists ? Text(state.${camelCase(name)}.${camelCase(property.name)}.$uiHeading) : const Text("-"),
                trailing: AppButton(
                  label: "Choose",
                  onPressed: () async {
                    final ${pascalCase(property.name)}? ${camelCase(property.name)} = await showModalBottomSheet(
                      context: context,
                      builder: (context){
                        return ${pascalCase(property.name)}InfiniteListWidget(
                          onPressed: (${camelCase(property.name)}) => Navigator.of(context).pop(${camelCase(property.name)}),
                        );
                      },
                    );
                    if(${camelCase(property.name)} != null) {
                      provider.set${pascalCase(property.name)}(${camelCase(property.name)});
                    }
                  },
                ),
              ),
""";
        items.add(value);
      }
    }
    return items;
  }

  // Quality of Life

  String _uiPropertyFormatted(BlueprintProperty property) {
    final name = camelCase(property.name);
    if (property.isStringish) {
      return name;
    }
    return '$name.toString()';
  }

  String? get uiHeading1 {
    final property = properties.firstWhereOrNull((p) => p.uiHeading == 1);

    if (property != null) {
      return _uiPropertyFormatted(property);
    }
    return null;
  }

  String? get uiHeading2 {
    final property = properties.firstWhereOrNull((p) => p.uiHeading == 2);

    if (property != null) {
      return _uiPropertyFormatted(property);
    }
    return null;
  }

  String? get uiDescription {
    final property = properties.firstWhereOrNull((p) => p.uiDescription);

    if (property != null) {
      return _uiPropertyFormatted(property);
    }
    return null;
  }

  // Model Mapper

  List<String> get mapperImports {
    final List<String> items = [];
    for (final p in properties) {
      if (!Constants.primitives.contains(p.type)) {
        if (p.type == "user") {
          // items.add("import 'package:app/src/core/utils/user_utils.dart';");
          // items.add("import 'package:supabase_flutter/supabase_flutter.dart';");
        } else {
          items.add("import '../../../${snakeCase(p.type)}/data/mappers/${snakeCase(p.type)}_mapper.dart';");
        }
      }
    }

    return items;
  }

  List<String> get dtoToModelFields {
    final List<String> items = [];
    for (final property in properties) {
      if (!Constants.primitives.contains(property.type)) {
        items.add("${camelCase(property.name)}: ${pascalCase(property.name)}Mapper.toModel(${camelCase(name)}DTO.${camelCase(property.name)}),");
      } else {
        items.add("${camelCase(property.name)}: ${camelCase(name)}DTO.${camelCase(property.name)},");
      }
    }

    return items;
  }

  List<String> get modelToDtoFields {
    final List<String> items = [];
    for (final property in properties) {
      if (!Constants.primitives.contains(property.type)) {
        items.add("${camelCase(property.name)}: ${pascalCase(property.name)}Mapper.toDto(${camelCase(name)}.${camelCase(property.name)}),");
      } else {
        items.add("${camelCase(property.name)}: ${camelCase(name)}.${camelCase(property.name)},");
      }
    }

    return items;
  }

  List<String> get supabaseDatasourceImports {
    if (Constants.serverBackend != ServerBackendOption.supabase) {
      return [];
    }

    final List<String> importStrings = [];
    for (final p in properties) {
      if (!Constants.primitives.contains(p.type)) {
        importStrings.add("import '../../../${snakeCase(p.type)}/data/datasources/${snakeCase(p.type)}_datasource_supabase.dart';");
      }
    }

    return importStrings;
  }

  String? get supabaseDatasourceJoins {
    if (Constants.serverBackend != ServerBackendOption.supabase) {
      return null;
    }

    final List<String> joins = [];
    for (final property in properties) {
      if (!Constants.primitives.contains(property.type)) {
        joins.add('${snakeCase(property.name)}(\${${pascalCase(property.name)}DataSourceSupabaseImpl.defaultSelect})');
      }
    }

    if (joins.isNotEmpty) {
      joins.insert(0, "");
    }

    return joins.join(",");
  }

  @override
  Map<String, dynamic> serialize() {
    return {
      "serverBackendIsServerpod": Constants.serverBackend == ServerBackendOption.serverpod,
      "serverBackendIsSupabase": Constants.serverBackend == ServerBackendOption.supabase,
      'name': name,
      'properties': properties.map<Map<String, dynamic>>((p) => p.serialize()).toList(),
      'toJsonFunctions': toJsonFunctions,
      'formStateImports': formStateImports,
      'emptyParams': emptyParams,
      'formProviderImports': formProviderImports,
      'formControllers': formControllers,
      'formValidators': formValidators,
      'formControllerRefreshers': formControllerRefreshers,
      'formControllerSetters': formControllerSetters,
      'formSetters': formSetters,
      'formImports': formImports,
      'formInputs': formInputs,
      'uiHeading1': uiHeading1,
      'uiHeading2': uiHeading2,
      'uiDescription': uiDescription,
      'mapperImports': mapperImports,
      'dtoToModelFields': dtoToModelFields,
      'modelToDtoFields': modelToDtoFields,
      'modelImports': modelImports,
      'supabaseDatasourceImports': supabaseDatasourceImports,
      'supabaseDatasourceJoins': supabaseDatasourceJoins,
    };
  }
}
