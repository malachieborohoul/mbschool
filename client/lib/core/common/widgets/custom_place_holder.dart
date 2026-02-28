
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/core/constants/utils.dart';

class CunstomPlaceHolder extends StatefulWidget {
  const CunstomPlaceHolder(
      {super.key, required this.title, this.isSwitch = false});
  final String title;
  final bool isSwitch;

  @override
  CunstomPlaceHolderState createState() => CunstomPlaceHolderState();
}

class CunstomPlaceHolderState extends State<CunstomPlaceHolder> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.width * .1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 15.0,
              color: grey,
            ),
          ),
          (widget.isSwitch)
              ? CupertinoSwitch(
                  value: switchValue,
                  activeTrackColor: primary,
                  onChanged: (bool newValue) {
                    setState(() {
                      switchValue = newValue;
                    });
                  },
                )
              : SvgPicture.asset('${assetImg}arrow_up_icon.svg'),
        ],
      ),
    );
  }
}
