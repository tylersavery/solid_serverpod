import 'package:fpdart/fpdart.dart';
import 'package:houston_client/houston_client.dart';
import 'package:houston_flutter/core/models/paginated_response.dart';
import '../../../../core/error/failures.dart';

abstract interface class {{#pascalCase}}{{name}}{{/pascalCase}}Repository {
  Future<Either<Failure, PaginatedResponse<{{#pascalCase}}{{name}}{{/pascalCase}}>>> list({required int page, required int limit});
  Future<Either<Failure, {{#pascalCase}}{{name}}{{/pascalCase}}>> retrieve(int id);
  Future<Either<Failure, {{#pascalCase}}{{name}}{{/pascalCase}}>> save({{#pascalCase}}{{name}}{{/pascalCase}} {{#camelCase}}{{name}}{{/camelCase}});
  Future<Either<Failure, void>> delete(int id);
}
