import 'package:flutter/material.dart';
import 'package:notes_app/utils/app_dimensions.dart';

class NoteContainer extends StatelessWidget {
  String? title;
  String topic;

  NoteContainer({Key? key, this.title, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final squareWidth = AppDimensions.width - 12.0.wp;
    return Stack(
      children: [
        Container(
          width: squareWidth / 2,
          height: squareWidth / 2,
          margin: EdgeInsets.all(3.0.wp),
          padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10.0.wp),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 5,
                    offset: Offset(0, 5)),
                BoxShadow(
                    color: Colors.white, blurRadius: 5, offset: Offset(-5, 0)),
                BoxShadow(
                    color: Colors.white, blurRadius: 5, offset: Offset(0, -5)),
              ]),
          child: Center(
              child: Text(
            title ?? topic,
            style: TextStyle(
              fontSize: 24.0.sp,
              overflow: TextOverflow.ellipsis,
              color: Colors.black54,
            ),
          )),
        ),
        Positioned(
          bottom: AppDimensions.responsiveWidth(20),
          left: AppDimensions.responsiveWidth(30),
          child: Text(
            '12/12/2020',
            style: TextStyle(fontSize: 10.0.sp, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
