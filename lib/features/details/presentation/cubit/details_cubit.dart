import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat/features/auth/data/model/user_info_model.dart';
import 'package:chat/features/details/data/repo/detailsRepo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  Detailsrepo detailsrepo;
  DetailsCubit(this.detailsrepo) : super(DetailsInitial());
  getMyInfo() async {
    emit(DetailsLoading());
    final result = await detailsrepo.getMyDetails();
    result.fold(
      (l) => emit(DetailsError(l.failuremessage)),
      (r) => emit(DetailsSuccess(r)),
    );
  }

  updateMyInfo(String name, String phone) async {
    emit(DetailsUpdating());
    final result = await detailsrepo.updateProfileData(name, phone);
    result.fold(
      (l) => emit(DetailsError(l.failuremessage)),
      (r) => emit(DetailsUpdated(r)),
    );
    await getMyInfo();
  }

  uploadFile(File file) async {
    emit(ImageDetailsLoading());
    final result = await detailsrepo.uploadFile(file);
    result.fold(
      (l) => emit(ImageDetailsError(l.failuremessage)),
      (r) => emit(ImageDetailsSuccess(r)),
    );
    geturl();
  }

  geturl() async {
    emit(ImageDetailsLoading());
    final result = await detailsrepo.getUrl();
    result.fold(
      (l) => emit(ImageDetailsError(l.failuremessage)),
      (r) => emit(ImageDetailsSuccess(r)),
    );
    getMyInfo();
  }

  pickImage() async {
    try {
      final picker = ImagePicker();
      final imagePicked = await picker.pickImage(source: ImageSource.camera);
      if (imagePicked == null) {
        return;
      }
      final file = File(imagePicked.path);
      await uploadFile(file);
    } catch (e) {
      emit(ImageDetailsError("Image Picking Failed $e"));
    }
  }


}

