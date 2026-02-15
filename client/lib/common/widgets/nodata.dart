import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbschool/constants/utils.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("${assetImg}nodata.png", width: 200,),
    );
  }
}
