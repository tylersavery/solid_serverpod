import 'package:fpdart/fpdart.dart';
import 'package:spriver_flutter/core/common/entities/user.dart';
import 'package:spriver_flutter/core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, bool>> registerWithEmailPassword({
    required String username,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> confirmRegistration({
    required String email,
    required String verificationCode,
  });

  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();

  Future<Either<Failure, void>> logout();
}
