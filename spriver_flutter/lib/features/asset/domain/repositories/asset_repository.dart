import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spriver_flutter/core/error/failures.dart';

abstract interface class AssetRepository {
  Future<Either<Failure, String>> uploadImage({required XFile image});
}
