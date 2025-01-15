import 'package:fitness/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness/Controllers/HomeController/change_themes_controller.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData? secondaryIcon;
  final bool obscureText;
  final bool readOnly;
  final int? maxLength;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.readOnly = false,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.secondaryIcon,
    this.obscureText = false,
    required this.onChanged,
    this.validator,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = false;

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check the current theme mode (dark or light)
    bool isDarkMode = themeController.isDarkMode.value;

    return SizedBox(
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        cursorColor: isDarkMode ? Colors.white : Colors.black,  // Change cursor color based on theme
        readOnly: widget.readOnly,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        maxLines: 1,
        minLines: 1,
        decoration: InputDecoration(
          counterText: "",
          hintText: widget.hintText,
          filled: true,
          fillColor: isDarkMode
              ? Colors.grey[700]?.withOpacity(0.15)  // Dark mode fill color
              : FitnessColor.primaryLite.withOpacity(0.15),  // Light mode fill color
          suffixIcon: widget.obscureText
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: _togglePasswordVisibility,
          )
              : (widget.secondaryIcon != null
              ? Icon(widget.secondaryIcon)
              : null),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.white : Colors.grey[400]!,  // Border color based on theme
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.white : Colors.grey[400]!,  // Border color based on theme
            ),
          ),
        ),
        onChanged: widget.onChanged,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
