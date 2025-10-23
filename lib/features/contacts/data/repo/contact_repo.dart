import 'package:chat/core/db/db_service.dart';
import 'package:chat/core/db/failures.dart';
import 'package:chat/core/db/supabase_service.dart';
import 'package:chat/features/auth/data/model/user_info_model.dart';
import 'package:dartz/dartz.dart';

abstract class ContactRepo {
  Future<Either<Failures, List<UserInfoModel>>> getAllContacts();
}

class contactRepoImp implements ContactRepo {
  DbService dbService;
  contactRepoImp(this.dbService);

  @override
  Future<Either<Failures, List<UserInfoModel>>> getAllContacts() async {
    try {
      final data = await dbService.fetchByFilterNeq(
        "user_info",
        "id",
        SupabaseService()
            .client
            .auth
            .currentUser!
            .id,
      );
      final user = data.map((e) => UserInfoModel.fromJson(e)).toList();
      return Right(user);
    } catch (e) {
      return Left(Serverfailure("The error is $e"));
    }
  }


}
