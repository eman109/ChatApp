import 'package:bloc/bloc.dart';
import 'package:chat/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitial());
  registerUser(String email, String password, String name, String phone) async {
    emit(AuthLoading());
    final result = await authRepo.register(email, password, name, phone);
    result.fold(
      (l) => emit(AuthError(l.failuremessage)),
      (r) => emit(RegSuccess(r!.email!)),
    );
  }

  loginUser(String email, String password) async {
    emit(AuthLoading());
    final result = await authRepo.login(email, password);
    result.fold(
      (l) => emit(AuthError(l.failuremessage)),
      (r) => emit(LoginSuccess(r!.email!)),
    );
  }
}
