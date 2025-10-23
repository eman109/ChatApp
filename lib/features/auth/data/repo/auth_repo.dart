import 'package:chat/core/db/db_service.dart';
import 'package:chat/core/db/failures.dart';
import 'package:chat/features/auth/data/model/user_info_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  Future<Either<Failures, User?>> register(
    String email,
    String password,
    String name,
    String phone,
  );
  Future<Either<Failures, User?>> login(String email, String password);
}

class AuthrepoIMP implements AuthRepo {
  DbService dbService;
  AuthrepoIMP(this.dbService);

  @override
  Future<Either<Failures, User?>> login(String email, String password) async {
    try {
      final user = await dbService.signIn(email, password);
      if (user != null) {
        return Right(user);
      } else {
        return left(
          Serverfailure("User Not Found"),
        );
           }
    } on AuthApiException catch (e) {
      return Left(
        Serverfailure(
          "The error is ${e.message}, the status code is ${e.code}",
        ),
      );
    } catch (e) {
      return Left(Serverfailure("The error is $e"));
    }
  }

  @override
  Future<Either<Failures, User?>> register(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    try {
      final user = await dbService.signUp(email, password);
      if (user != null) {
        UserInfoModel userInfo = UserInfoModel(
          email: email,
          id: user.id,
          user_name: name,
          phone_number: phone,
        );
        await dbService.insert("user_info", userInfo.toJson());
        return Right(user);
      } else {
        return Left(Serverfailure("User Not Created"));
      }
    } on AuthApiException catch (e) {
      return Left(
        Serverfailure(
          "The error is ${e.message}, the status code is ${e.code}",
        ),
      );
    } catch (e) {
      return Left(Serverfailure("The error is $e"));
    }
  }
}
