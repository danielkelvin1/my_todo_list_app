// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class QRadioCircleImage<E> extends StatelessWidget {
  const QRadioCircleImage({
    Key? key,
    required this.groupValue,
    required this.value,
    required this.imageAssetSrc,
    required this.onTapButton,
  }) : super(key: key);
  final E groupValue;
  final E value;
  final String imageAssetSrc;
  final Function(E value) onTapButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapButton(value);
      },
      child: CircleAvatar(
        backgroundColor:
            groupValue == value ? const Color(0xff4a3883) : Colors.white,
        radius: 28,
        child: Image.asset(imageAssetSrc),
      ),
    );
  }
}
