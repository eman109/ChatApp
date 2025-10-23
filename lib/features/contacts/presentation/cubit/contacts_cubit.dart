import 'package:bloc/bloc.dart';
import 'package:chat/features/auth/data/model/user_info_model.dart';
import 'package:chat/features/contacts/data/repo/contact_repo.dart';
import 'package:meta/meta.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactRepo contactRepo;
  ContactsCubit(this.contactRepo) : super(ContactsInitial());
  fetchContact() async {
    emit(ContactsLoading());
    final result = await contactRepo.getAllContacts();
    result.fold(
      (l) => emit(ContactsError(l.failuremessage)),
      (r) => emit(ContactsSuccess(r)),
    );
  }
}
