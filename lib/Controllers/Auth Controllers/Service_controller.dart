import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ServiceController extends GetxController {

  var passwordVisible = false.obs;
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  ///on controller close
  @override
  void onClose() {

    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  ///handle password visibility
  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  /// register user method on Sign up
  Future<void> register() async {
    if(formKey.currentState!.validate()){

    }
  }

// void _validateAndSubmit() {
//   if (emailC.text.isEmpty) {
//     CustomSnackbar.show(context, 'Please Enter Email Address');
//     return;
//   }
//
//   if (passwordC.text.isEmpty) {
//     CustomSnackbar.show(context, 'Please Enter Password');
//     return;
//   }
//
//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(builder: (context) => const RegistrationScreen()),
//   );
// }
}
