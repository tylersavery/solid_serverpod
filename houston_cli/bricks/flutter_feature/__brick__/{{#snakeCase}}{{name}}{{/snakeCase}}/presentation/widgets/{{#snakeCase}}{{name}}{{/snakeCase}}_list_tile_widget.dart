import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/{{#snakeCase}}{{name}}{{/snakeCase}}_model.dart';
import '../screens/{{#snakeCase}}{{name}}{{/snakeCase}}_detail_screen.dart';


class {{#pascalCase}}{{name}}{{/pascalCase}}ListTileWidget extends StatelessWidget {
  final {{#pascalCase}}{{name}}{{/pascalCase}} {{#camelCase}}{{name}}{{/camelCase}};

  const {{#pascalCase}}{{name}}{{/pascalCase}}ListTileWidget({
    super.key,
    required this.{{#camelCase}}{{name}}{{/camelCase}},
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        {{#uiHeading1}}title: Text({{#camelCase}}{{name}}{{/camelCase}}.{{.}}),{{/uiHeading1}}
        {{^uiHeading1}}title: Text({{#camelCase}}{{name}}{{/camelCase}}.label),{{/uiHeading1}}
        {{#uiHeading2}}subtitle: Text({{#camelCase}}{{name}}{{/camelCase}}.{{.}}),{{/uiHeading2}}
        onTap: () {
          context.push({{#pascalCase}}{{name}}{{/pascalCase}}DetailScreen.route({{#camelCase}}{{name}}{{/camelCase}}.id));
        },
      ),
    );
  }
}
