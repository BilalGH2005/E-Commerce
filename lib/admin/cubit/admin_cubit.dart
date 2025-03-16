import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/routes/app_router.dart';
import '../../core/utils/snackbar_util.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  final SupabaseClient _supabase = Supabase.instance.client;
  String? selectedValue = 'Play Station';
  String? imageUrl;
  int adminStatus = 0;

  Future<void> insertProduct({
    required GlobalKey<FormState> formKey,
    required String name,
    required String description,
    required String price,
    required String imageUrl,
  }) async {
    adminStatus = 1;
    emit(AdminStateChanged());
    if (!formKey.currentState!.validate()) {
      adminStatus = 0;
      emit(AdminStateChanged());
      return;
    }
    formKey.currentState!.save();
    final BuildContext? context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;
    try {
      final response = await _supabase.from('products').insert([
        {
          'name': name,
          'price': price,
          'description': description,
          'category': selectedValue,
          'image_url': imageUrl,
        }
      ]);
      SnackBarUtil.showSuccessfulSnackBar(context, response);
    } catch (exception) {
      SnackBarUtil.showErrorSnackBar(context, exception.toString());
    } finally {
      adminStatus = 0;
      emit(AdminStateChanged());
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      File selectedImage = File(image.path);
      String fileName =
          'products/${DateTime.now().millisecondsSinceEpoch}_${image.name}';
      await Supabase.instance.client.storage
          .from('products_images')
          .upload(fileName, selectedImage);
      imageUrl = Supabase.instance.client.storage
          .from('products_images')
          .getPublicUrl(fileName);
    }
  }

  void Function(String?)? dropDownButtonValue(String? newValue) {
    if (newValue != null) {
      selectedValue = newValue;
      emit(AdminStateChanged());
    }
    return null;
  }

  static String? nameValidator(String? value) {
    final BuildContext? context = AppRouter.navigatorKey.currentContext;
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context!)!.nameRequired;
    }
    return null;
  }

  static String? priceValidator(String? value) {
    final BuildContext? context = AppRouter.navigatorKey.currentContext;
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context!)!.priceRequired;
    }
    return null;
  }

  static String? imageUrlValidator(String? value) {
    final BuildContext? context = AppRouter.navigatorKey.currentContext;
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context!)!.imageUrlRequired;
    }
    return null;
  }
}
