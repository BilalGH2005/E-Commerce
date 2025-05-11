import 'package:e_commerce/admin/widgets/images_picker_sheet.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  final SupabaseClient _supabase = Supabase.instance.client;
  final TextEditingController nameTextController = TextEditingController(),
      descriptionTextController = TextEditingController(),
      priceTextController = TextEditingController();
  String? selectedValue = 'Men';
  int adminStatus = 0;
  List<XFile?> selectedImages = [];

  Future<void> insertProduct({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) async {
    adminStatus = 1;
    emit(AdminStateChanged());
    if (!formKey.currentState!.validate()) {
      adminStatus = 0;
      emit(AdminStateChanged());
      return;
    }
    formKey.currentState!.save();
    try {
      final response = await _supabase.from('products').insert(
        [
          {
            'name': nameTextController.text,
            'price': priceTextController.text,
            'description': descriptionTextController.text,
            'category': selectedValue,
            'image_url': '',
          }
        ],
      );
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
    final List<XFile> image = await ImagePicker().pickMultiImage(
        maxWidth: 600, maxHeight: 600, limit: 5, imageQuality: 50);
    selectedImages.addAll(image);
    emit(ImagesStateChanged());
  }

  Future<void> showImagePickerSheet(BuildContext context) async {
    showModalBottomSheet(
        context: context, builder: (context) => const ImagesPickerSheet());
  }

  void removeImage(XFile image) {
    selectedImages.remove(image);
    emit(ImagesStateChanged());
  }

  static String? nameValidator({required BuildContext context, String? value}) {
    if (value == null || value.trim().isEmpty) {
      return localization(context).nameRequired;
    }
    return null;
  }

  static String? priceValidator(
      {required BuildContext context, String? value}) {
    if (value == null || value.trim().isEmpty) {
      return localization(context).priceRequired;
    }
    return null;
  }
}
