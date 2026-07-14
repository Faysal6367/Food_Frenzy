import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/widget/custom_text.dart';

class MyContainer extends StatefulWidget {
  final double height;
  final double width;
  final String heading;
  final String text;
  final String url;
  final double imgHeight;
  final double imgWidth;
  final double sizedHeight1;
  final double sizedHeight2;
  final double left;

  const MyContainer({
    super.key,
    required this.height,
    required this.width,
    required this.heading,
    required this.text,
    required this.url,
    required this.imgHeight,
    required this.imgWidth,
    required this.sizedHeight1,
    required this.sizedHeight2,
    required this.left,
  });

  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  @override
  Widget build(BuildContext context) {
    // Outer box: keep the same explicit size you already pass, but make inner content responsive.
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.sp),
        ),
        clipBehavior: Clip.antiAlias, // IMPORTANT: prevents painting outside rounded corners
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Estimate reserved vertical space needed by texts + spacers.
              // We keep a small buffer to avoid tight fits.
              final double reservedForText =
              // approximate space for heading + sized gaps + body text
              (50.sp /* heading text approx height */) +
                  widget.sizedHeight1 +
                  (40.sp /* body text approx height */) +
                  widget.sizedHeight2 +
                  24.h; // padding buffer

              // available height left for the image
              final double availableImageHeight =
              (constraints.maxHeight - reservedForText).clamp(0.0, widget.imgHeight);

              // also compute a reasonable max image width (don't exceed container width)
              final double maxImageWidth = (constraints.maxWidth * 0.6).clamp(0.0, widget.imgWidth);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top texts block
                  MyText(
                    text: widget.heading,
                    color: Colors.black,
                    size: 50.sp,
                    bold: true,
                  ),
                  SizedBox(height: widget.sizedHeight1),
                  MyText(
                    text: widget.text,
                    color: Colors.black,
                    size: 40.sp,
                    bold: false,
                  ),
                  SizedBox(height: widget.sizedHeight2),
                  // Spacer to push image to bottom-right if there's extra space
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: widget.left),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            // ensure the image never exceeds calculated bounds
                            maxHeight: availableImageHeight > 0 ? availableImageHeight : widget.imgHeight,
                            maxWidth: maxImageWidth,
                          ),
                          child: _buildImage(widget.url),
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

  Widget _buildImage(String asset) {
    // Use BoxFit.contain so image scales down without cropping (use cover if you prefer crop)
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.sp),
      child: Image.asset(
        asset,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Container(
          color: Colors.grey.shade100,
          width: widget.imgWidth,
          height: widget.imgHeight,
          child: const Icon(Icons.fastfood, color: Colors.black26),
        ),
      ),
    );
  }
}
