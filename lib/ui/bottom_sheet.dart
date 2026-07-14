import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/api/google_map.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBottomSheet {
  static Future<void> showMyBottomSheet(BuildContext context) async {
    // isScrollControlled true allows taller sheet and keyboard handling
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // to allow rounded corners if desired
      builder: (context) {
        // FractionallySizedBox controls overall sheet height relative to screen.
        return FractionallySizedBox(
          heightFactor: 0.72, // 72% of screen height — adjust if you want taller/shorter
          child: _BottomSheetContent(),
        );
      },
    );
  }

  static Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      double latitude = position.latitude;
      double longitude = position.longitude;
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setDouble('lat', latitude);
      await sharedPreferences.setDouble('lng', longitude);

      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String locationName = '${placemark.locality}, ${placemark.administrativeArea}';
        await sharedPreferences.setString('loc', locationName);
      }
    } catch (e) {
      // handle error (optionally show a toast/snackbar)
      debugPrint('getLocation error: $e');
    }
  }
}

class _BottomSheetContent extends StatelessWidget {
  const _BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Use theme-safe background with rounded corners
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Material(
            // use Material so InkWell/other material widgets behave correctly
            color: Colors.white,
            child: _InnerContent(),
          ),
        ),
      ),
    );
  }
}

class _InnerContent extends StatelessWidget {
  const _InnerContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Scrollable content (helps on small screens)
    return SingleChildScrollView(
      // allow the sheet to expand to full heightFactor if content needs it
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.location, size: 28.sp, color: AppColor.mainColor),
                SizedBox(width: 12.w),
                Expanded(
                  child: MyText(text: "Use my current location", color: AppColor.mainColor, size: 18.sp, bold: true),
                ),
                // optional close button
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close, size: 22.sp),
                ),
              ],
            ),

            SizedBox(height: 14.h),

            // Map area: use AspectRatio to keep predictable height and avoid overflow
            Container(
              width: double.infinity,
              // limit map height to a fraction of sheet height — menas it won't overflow
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.35,
                minHeight: 120.h,
              ),
              decoration: BoxDecoration(
                color: AppColor.mainColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: MyGoogleMap(zoom: 18.9),
              ),
            ),

            SizedBox(height: 16.h),

            // Buttons / actions
            Row(
              children: [
                Icon(CupertinoIcons.add, size: 24.sp, color: AppColor.mainColor),
                SizedBox(width: 12.w),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      // Permission flow
                      if (await Permission.location.isGranted) {
                        await MyBottomSheet.getLocation();
                        if (context.mounted) Navigator.of(context).pop();
                      } else {
                        PermissionStatus permissionStatus = await Permission.location.request();
                        if (permissionStatus.isGranted) {
                          await MyBottomSheet.getLocation();
                          if (context.mounted) Navigator.of(context).pop();
                        } else {
                          // Optionally show a message to user
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Location permission denied')),
                            );
                          }
                        }
                      }
                    },
                    child: MyText(text: "Add new location", color: AppColor.mainColor, size: 16.sp, bold: true),
                  ),
                ),
              ],
            ),

            SizedBox(height: 14.h),

            // Optional: small helper text or currently saved location preview
            FutureBuilder<SharedPreferences>(
              future: SharedPreferences.getInstance(),
              builder: (context, snap) {
                if (!snap.hasData) return const SizedBox();
                final prefs = snap.data!;
                final loc = prefs.getString('loc') ?? 'No saved location';
                return MyText(text: loc, color: Colors.black54, size: 14.sp, bold: false);
              },
            ),

            SizedBox(height: 8.h),
            // Add some bottom padding so content isn't flush with rounded corner
            SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 8.h),
          ],
        ),
      ),
    );
  }
}
