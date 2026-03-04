import 'package:mbschool/core/presentation/widgets/custom_elevated_button.dart';
import 'package:mbschool/core/presentation/widgets/custom_image_view.dart';
import 'package:mbschool/core/theme/app_decoration.dart';
import 'package:mbschool/core/theme/custom_text_style.dart';
import 'package:mbschool/core/theme/theme_helper.dart';
import 'package:mbschool/core/utils/image_constant.dart';
import 'package:mbschool/core/utils/size_utils.dart';

import 'package:flutter/material.dart';

class CustomPopupScreen extends StatefulWidget {
  
  const CustomPopupScreen({super.key, required this.onPressed, required this.imagePath, required this.title, required this.description, required this.buttonText});

  final VoidCallback onPressed;
  final String imagePath;
  final String title;
  final String description;
  final String buttonText;

  @override
  State<CustomPopupScreen> createState() =>
      _CustomPopupScreenState();
}

class _CustomPopupScreenState extends State<CustomPopupScreen> {
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 388.h,
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 32.v),
      decoration: AppDecoration.fillWhiteA
          .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
              imagePath: ImageConstant.passwordChanged,
              height: 116.v,
              width: 116.h,
              fit: BoxFit.contain,
              alignment: Alignment.center),
          SizedBox(height: 16.v),
          Text(widget.title,
              style: CustomTextStyles.titleLargeBlack900),
          SizedBox(height: 8.v),
          Container(
              width: 332.h,
              margin: EdgeInsets.symmetric(horizontal: 3.h),
              child: Text(widget.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge!.copyWith(height: 1.29))),
          SizedBox(height: 40.v),
          CustomElevatedButton(
            text: widget.buttonText,
            onPressed: widget.onPressed,
          ),
        ],
      ),
    );
  }
}
