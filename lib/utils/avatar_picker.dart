import 'dart:io';

import 'package:flutter/material.dart';

class AvatarPickter extends StatelessWidget{
  File? pickedImage;
  VoidCallback? onPicked;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
      SizedBox(height: 32,width: 32,child: CircleAvatar(backgroundColor: Colors.blueGrey, )),
      SizedBox(width: 10,),
      Container(
        padding: EdgeInsets.all(4),
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.secondary,
        child: Text('select image here'),
      )
    ],);
  }
}