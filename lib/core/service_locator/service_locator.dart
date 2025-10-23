import 'package:chat/core/db/db_service.dart';
import 'package:chat/core/db/supabase_service.dart';
import 'package:chat/features/auth/data/repo/auth_repo.dart';
import 'package:chat/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:chat/features/contacts/data/repo/contact_repo.dart';
import 'package:chat/features/contacts/presentation/cubit/contacts_cubit.dart';
import 'package:chat/features/details/data/repo/detailsRepo.dart';
import 'package:chat/features/details/presentation/cubit/details_cubit.dart';
import 'package:chat/features/room/data/repo/room_repo.dart';
import 'package:chat/features/room/presentation/cubit/message_cubit.dart';
import 'package:chat/features/room/presentation/cubit/room_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt getit = GetIt.instance;

void setUpServiceLocator() {
  // db
  getit.registerSingleton<DbService>(SupabaseService());

  // repo
  getit.registerLazySingleton<AuthRepo>(
    () => AuthrepoIMP(getit.get<DbService>()),
  );
  getit.registerLazySingleton<ContactRepo>(
    () => contactRepoImp(getit.get<DbService>()),
  );
  getit.registerLazySingleton<Detailsrepo>(
    () => DetailsRepoImp(getit.get<DbService>()),
  );
  getit.registerLazySingleton<RoomRepo>(
    () => RoomRepoImpl(getit.get<DbService>()),
  );

  // cubit
  getit.registerFactory<AuthCubit>(() => AuthCubit(getit.get<AuthRepo>()));
  getit.registerFactory<ContactsCubit>(
    () => ContactsCubit(getit.get<ContactRepo>()),
  );
  getit.registerFactory<DetailsCubit>(
    () => DetailsCubit(getit.get<Detailsrepo>()),
  );
  getit.registerFactory<RoomCubit>(() => RoomCubit(getit.get<RoomRepo>()));
  getit.registerFactory<MessageCubit>(
    () => MessageCubit(getit.get<RoomRepo>()),
  );
}
