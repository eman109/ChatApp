import 'dart:io';

import 'package:chat/core/db/db_service.dart';
import 'package:chat/core/db/failures.dart';
import 'package:chat/core/db/supabase_service.dart';
import 'package:chat/features/auth/data/model/user_info_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Detailsrepo {
  Future<Either<Failures, UserInfoModel>> getMyDetails();
  Future<Either<Failures, String>> updateProfileData(String name, String phone);
  Future<Either<Failures, String>> uploadFile(File file);
  Future<Either<Failures, String>> getUrl();
}

class DetailsRepoImp implements Detailsrepo {
  DbService dbService;
  DetailsRepoImp(this.dbService);

  @override
  Future<Either<Failures, UserInfoModel>> getMyDetails() async {
    try {
      final data = await dbService.fetchBySingle(
        "user_info",
        "id",
        SupabaseService().client.auth.currentUser!.id,
      );
      final user = UserInfoModel.fromJson(data);
      return right(user);
    } catch (e) {
      return left(Serverfailure("The error is $e"));
    }
  }

  @override
  Future<Either<Failures, String>> updateProfileData(
    String name,
    String phone,
  ) async {
    try {
      await dbService.update(
        "user_info",
        "id",
        SupabaseService().client.auth.currentUser!.id,
        {"user_name": name, "phone_number": phone},
      );
      return Right("data updated");
    } catch (e) {
      return left(Serverfailure("Data not updated $e"));
    }
  }

  @override
  Future<Either<Failures, String>> uploadFile(File file) async {
    try {
      final user = SupabaseService().client.auth.currentUser!.id;
      final data = await dbService.uploadFile(
        "images",
        "images/user_profile/$user.png",
        file,
        const FileOptions(upsert: true),
      );
      return Right(data);
    } catch (e) {
      return left(Serverfailure("Upload Failed $e"));
    }
  }

  @override
  Future<Either<Failures, String>> getUrl() async {
    final user = SupabaseService().client.auth.currentUser!.id;
    try {
      final data = await dbService.retrievePublicUrl(
        "images",
        "images/user_profile/$user.png",
      );
      return Right(data);
    } catch (e) {
      return Left(Serverfailure("Retrieving Public Url failed $e"));
    }
  }
}
