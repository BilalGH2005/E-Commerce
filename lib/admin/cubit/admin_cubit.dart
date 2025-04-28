import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/routes/app_router.dart';
import '../../core/utils/snackbar_util.dart';
import '../widgets/images_picker_sheet.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  final SupabaseClient _supabase = Supabase.instance.client;
  String? selectedValue = 'Men';
  String? imageUrl;
  int adminStatus = 0;
  List<XFile?> selectedImages = [];

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

  void categoryValue(String? newValue) {
    selectedValue = newValue;
    emit(AdminStateChanged());
  }

  // ---------------------------------- Image Picker ---------------------------------- //
  // Future<void> pickImages() async {
  //   final List<XFile> images = await ImagePicker().pickMultiImage();
  //   if (images.isNotEmpty) {
  //     for (XFile image in images) {
  //       File selectedImage = File(image.path);
  //       String fileName =
  //           'products/${DateTime.now().millisecondsSinceEpoch}_${image.name}';
  //       await Supabase.instance.client.storage
  //           .from('products_images')
  //           .upload(fileName, selectedImage);
  //       String imageUrl = Supabase.instance.client.storage
  //           .from('products_images')
  //           .getPublicUrl(fileName);
  //       print('Uploaded: $imageUrl');
  //     }
  //   }
  // }

  Future<void> pickFromCamera() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImages.add(XFile(image.path));
    }
  }

  Future<void> pickFromGallery() async {
    final List<XFile> image = await ImagePicker().pickMultiImage();
    selectedImages.addAll(image);
    emit(ImagesStateChanged());
  }

  Future<void> showImagePickerSheet(BuildContext context) async {
    showModalBottomSheet(
        context: context, builder: (context) => ImagesPickerSheet());
  }

  void removeImage(XFile image) {
    selectedImages.remove(image);
    emit(ImagesStateChanged());
  }

  // ---------------------------------- Admin Validators ---------------------------------- //
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
}
