// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:plantix_app/app/core/widgets/custom_snackbar.dart';
import 'package:plantix_app/app/data/models/field_model.dart';
import 'package:plantix_app/app/modules/lahan_tanam/lahan_tanam_controller.dart';

class DetailLahanController extends GetxController {
  Lahan lahan = Get.arguments;
  final isScrolled = false.obs;
  // Fungsi untuk memperbarui status scroll
  void updateScrollStatus(bool scrolled) {
    isScrolled.value = scrolled;
  }

  // Fungsi untuk mengedit lahan yang sudah ada
  editLahan(int index) {
    CustomSnackBar.showCustomSuccessSnackBar(
        title: 'Sukses', message: 'Lahan berhasil diperbarui');
  }

  // Fungsi untuk menghapus lahan
  void deleteLahan(int index) {
    Get.find<LahanTanamController>().deleteLahan(index);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
