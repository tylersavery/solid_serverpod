import 'package:houston_cli/constants.dart';
import 'package:houston_cli/serializers/blueprint_serializer.dart';
import 'package:houston_cli/utils/string_utils.dart';

class SupabaseBlueprintSerializer extends BlueprintSerializer {
  const SupabaseBlueprintSerializer({required super.blueprint});

  String get generatedSql {
    final List<String> sql = [];

    sql.add('CREATE TABLE IF NOT EXISTS "public"."$name" (');

    final List<String> sqlProperties = [];

    sqlProperties.add('"id" bigint NOT NULL');

    // if (camelCase(name) == "profile") {
    //   sqlProperties.add('"id" "uuid" NOT NULL references auth.users ON DELETE CASCADE');
    // } else {
    //   sqlProperties.add('"id" bigint NOT NULL');
    // }

    for (final property in properties) {
      final type = property.type.toLowerCase();
      final propertyName = snakeCase(property.name);

      String? defaultValue;

      if (property.defaultValue != null) {
        if (property.defaultValue is String) {
          defaultValue = "'${property.defaultValue}'";
        }
        if (property.defaultValue is num) {
          defaultValue = "${property.defaultValue}";
        }
      } else if (property.allowBlank) {
        if (property.isStringish) {
          defaultValue = "''";
        } else if (property.isNumeric) {
          defaultValue = '0';
        }
      }

      if (propertyName == 'uid') {
        if (name == "profile") {
          sqlProperties.add('"uid" "uuid" NOT NULL references auth.users ON DELETE CASCADE');
        } else {
          sqlProperties.add('"uid" "uuid" DEFAULT "gen_random_uuid"() NOT NULL');
        }
      } else if (type == "char") {
        sqlProperties
            .add('"$propertyName" character varying${!property.allowNull ? " NOT NULL" : ""}${defaultValue != null ? ' DEFAULT $defaultValue' : ''}');
      } else if (type == "text" || type == "string" || type == "url") {
        sqlProperties.add('"$propertyName" "text"${!property.allowNull ? " NOT NULL" : ""}${defaultValue != null ? ' DEFAULT $defaultValue' : ''}');
      } else if (type == "int" || type == "double") {
        sqlProperties.add('"$propertyName" numeric${!property.allowNull ? " NOT NULL" : ""}${defaultValue != null ? ' DEFAULT $defaultValue' : ''}');
      } else if (type == "datetime") {
        if (propertyName == "created_at") {
          sqlProperties.add('"$propertyName" timestamp with time zone DEFAULT "now"() NOT NULL');
        } else {
          sqlProperties.add('"$propertyName" timestamp with time zone${!property.allowNull ? " NOT NULL" : ""}');
        }
      } else {
        sqlProperties.add('"$propertyName" bigint${!property.allowNull ? " NOT NULL" : ""}');
      }
    }

    sql.add(sqlProperties.join(",\n"));

    sql.add(');');

    sql.add('ALTER TABLE "public"."$name" OWNER TO "postgres";');

    sql.add('ALTER TABLE "public"."$name" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (');
    sql.add('SEQUENCE NAME "public"."${name}_id_seq"');
    sql.add('START WITH 1');
    sql.add('INCREMENT BY 1');
    sql.add('NO MINVALUE');
    sql.add('NO MAXVALUE');
    sql.add('CACHE 1');
    sql.add(');');

    sql.add('ALTER TABLE ONLY "public"."$name" ADD CONSTRAINT "${name}_pkey" PRIMARY KEY ("id");');

    for (final property in properties) {
      if (!Constants.primitives.contains(property.type)) {
        sql.add(
            'ALTER TABLE ONLY "public"."$name" ADD CONSTRAINT "${name}_${snakeCase(property.name)}_fkey" FOREIGN KEY ("${snakeCase(property.name)}") REFERENCES "public"."${snakeCase(property.name)}"("id") ON DELETE CASCADE;');
      }
    }

    return sql.join("\n");
  }

  @override
  Map<String, dynamic> serialize() {
    return {
      'generatedSql': generatedSql,
      'name': name,
    };
  }
}
