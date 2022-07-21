import 'package:flutter/material.dart';
import 'package:jiffy_fuels_consumer/const/screen_size.dart';

// ignore: must_be_immutable
class TitleTextField extends StatelessWidget {
  TitleTextField({
    Key? key,
    required this.title,
    this.keyboardType,
    this.customHeight,
    this.controller,
    this.padding,
    this.icon,
    this.iconData,
    this.enabled = true,
    this.hint = '',
    this.onChanged,
    this.validator,
    this.iconTap,
    this.node,
    this.onSubmit,
    this.obscure = false,
    this.maxLength
  }) : super(key: key);


  final String title;
  TextEditingController? controller;
  TextInputType? keyboardType;
  double? customHeight, padding;
  Icon? icon;
  IconData? iconData;
  bool enabled;
  String hint;
  Function(String?)? onChanged;
  Function()? iconTap;
  String? Function(String?)? validator;
  bool obscure;
  FocusNode? node;
  Function(String)? onSubmit;
  int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: padding == 0 ? 0 : 5),
          CustomTextField(
            customHeight: customHeight,
            keyboardType: keyboardType,
            controller: controller,
            hintText: hint,
            icon: icon,
            iconData: iconData,
            enabled: enabled,
            onChanged: onChanged,
            validator: validator,
            iconTap: iconTap,
            obscure: obscure,
            node: node,
            onSubmit: onSubmit,
            maxLength: maxLength,
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    this.keyboardType,
    this.customHeight,
    this.hintText = '',
    this.enabled = true,
    this.controller,
    this.icon,
    this.iconData,
    this.iconTap,
    this.obscure = false,
    this.onChanged,
    this.validator,
    this.node,
    this.onSubmit,
    this.maxLength
  }) : super(key: key);

  TextInputType? keyboardType;
  String? hintText;
  bool? enabled;
  TextEditingController? controller;
  double? customHeight, padding;
  Icon? icon;
  IconData? iconData;
  Function()? iconTap;
  Function(String?)? onChanged;
  String? Function(String?)? validator;
  bool obscure;
  FocusNode? node;
  Function(String)? onSubmit;
  int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: customHeight ?? ScreenSize.height(context) * 0.05,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(4),
        //color: Colors.grey.withOpacity(0.2),
      ),
      child: TextFormField(
        //maxLengthEnforcement: ,
        maxLength: maxLength,
        enabled: enabled,
        focusNode: node,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        onFieldSubmitted: onSubmit,
        style: const TextStyle(fontSize: 15),
        obscureText: obscure,
        keyboardType: keyboardType ?? TextInputType.name,
        decoration: InputDecoration(
          //icon: icon,
          prefixIcon: icon,
          //prefixIconConstraints: const BoxConstraints(maxHeight: double.infinity,maxWidth: double.infinity),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 15,
          ),
          suffixIcon: iconData != null
              ? GestureDetector(
                  onTap: iconTap,
                  child: Icon(
                    iconData,
                    size: 22,
                  ),
                )
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
        ),
      ),
    );
  }
}
