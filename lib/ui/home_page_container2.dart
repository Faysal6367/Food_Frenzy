import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/widget/custom_text.dart';

class MyContainer2 extends StatefulWidget {
  final double height;
  final double width;
  final String heading;
  final String text;
  final String text2;
  final String url;
  final double imgHeight;
  final double imgWidth;
  final double sizedHeight1;
  final double left;

  const MyContainer2({
    super.key,
    required this.height,
    required this.width,
    required this.heading,
    required this.text,
    required this.url,
    required this.imgHeight,
    required this.imgWidth,
    required this.sizedHeight1,
    required this.left,
    required this.text2,
  });

  @override
  State<MyContainer2> createState() => _MyContainer2State();
}

class _MyContainer2State extends State<MyContainer2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.sp),
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, top: 20.h, right: 12.w, bottom: 12.h),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // estimate available height for image: keep some room for texts
              final reservedTextHeight = (widget.sizedHeight1 +
                  50.sp + // approx heading height
                  40.sp + // approx text line
                  40.sp // approx text2 line
              )
                  .toDouble();

              final availableHeightForImage =
              (constraints.maxHeight - reservedTextHeight).clamp(0.0, widget.imgHeight);

              final maxImageWidth = (constraints.maxWidth * 0.35).clamp(0.0, widget.imgWidth);

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text column — takes remaining space
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: widget.heading,
                          color: Colors.black,
                          size: 50.sp,
                          bold: true,
                        ),
                        SizedBox(height: widget.sizedHeight1),
                        MyText(text: widget.text, color: Colors.black, size: 40.sp, bold: false),
                        MyText(text: widget.text2, color: Colors.black, size: 40.sp, bold: false),
                      ],
                    ),
                  ),

                  // gap before image (preserve your left offset)
                  SizedBox(width: widget.left),

                  // Image area: constrained so it never overflows
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: availableHeightForImage > 0 ? availableHeightForImage : widget.imgHeight,
                      maxWidth: maxImageWidth,
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.sp),
                      child: Image.asset(
                        widget.url,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Container(
                          width: widget.imgWidth,
                          height: widget.imgHeight,
                          color: Colors.grey.shade100,
                          child: const Icon(Icons.fastfood, color: Colors.black26),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
