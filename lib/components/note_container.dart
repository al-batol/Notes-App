import 'package:flutter/material.dart';
import 'package:notes_app/utils/app_dimensions.dart';


class NoteContainer extends StatelessWidget {
  final String? title;
  final String topic;
  final String formattedTime;
  final bool isRotated;

  const NoteContainer(
      {Key? key, this.title, required this.topic, required this.formattedTime, required this.isRotated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).size.width != 0.0) {
      AppDimensions.width = MediaQuery.of(context).size.width;
      AppDimensions.height = MediaQuery.of(context).size.height;
    }
    final double square = (AppDimensions.width - 12.0.wp) / 2 ;
    final double squareR = (AppDimensions.width - 15.0.wp) / 3;
    return Container(
      margin: isRotated ? EdgeInsets.zero: EdgeInsets.all(3.0.wp),
      padding: isRotated ? EdgeInsets.all(3.0.wp): EdgeInsets.zero,
      child: Material(
        borderRadius: BorderRadius.circular(isRotated ? 4.0.wp : 10.0.wp),
        child: Stack(
          children: [
            Container(
              width: isRotated ? squareR : square,
              height: isRotated ? squareR : square,
              padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(isRotated ? 4.0.wp : 10.0.wp),
              ),
              child: Center(
                child: Text(
                  title!.trim().isEmpty ? topic: title!,
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: isRotated ? 15.0.sp : 18.0.sp,
                      overflow: TextOverflow.ellipsis,
                      color: Theme.of(context).iconTheme.color),
                ),
              ),
            ),
            Positioned(
              bottom: AppDimensions.responsiveWidth(20),
              left: AppDimensions.responsiveWidth(30),
              child: Text(
                formattedTime,
                style: TextStyle(
                    fontSize: isRotated ? 6.0.sp : 10.0.sp,
                    color: Theme.of(context).iconTheme.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
