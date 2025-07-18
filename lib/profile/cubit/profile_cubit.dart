import 'package:e_commerce/profile/data/repos/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();

  @override
  Future<void> close() {
    nameTextController.dispose();
    emailTextController.dispose();
    return super.close();
  }
}
