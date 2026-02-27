
import 'package:flutter/cupertino.dart';
import 'package:mbschool/core/theme/theme_helper.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required this.onChange,
    this.alignment,
    this.value,
    this.width,
    this.height,
    this.margin,
  });

  final Alignment? alignment;

  final bool? value;

  final Function(bool) onChange;

  final double? width;

  final double? height;

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        margin: margin,
        child: alignment != null
            ? Align(
                alignment: alignment ?? Alignment.center,
                child: switchWidget,
              )
            : switchWidget);
  }

  Widget get switchWidget => CupertinoSwitch(
        value: value ?? false,
        inactiveTrackColor:
            (value ?? false) ? theme.colorScheme.primary : appTheme.gray100,
        thumbColor: (value ?? false) ? appTheme.whiteA700 : appTheme.whiteA700,
        activeTrackColor: theme.colorScheme.primary,
        onChanged: (value) {
          onChange(value);
        },
      );
}
