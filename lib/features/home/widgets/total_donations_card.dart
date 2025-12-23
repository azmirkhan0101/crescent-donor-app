import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/home/models/donor_model.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

class TotalDonationsCard extends StatelessWidget {
  const TotalDonationsCard({
    super.key,
    required this.color,
    required this.totalAmount,
    required this.totalDonors,
    required this.recentDonors,
  });
  final Color color;
  final double totalAmount;
  final int totalDonors;
  final List<DonorModel> recentDonors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                'Total Donations',
                style: TextStyle(
                  color: const Color(0xFF000C0B) /* Colors-Off-Black */,
                  fontSize: 14,
                  fontFamily: 'Inter Display',
                  fontWeight: FontWeight.w400,
                  height: 1.29,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 4,
                children: [
                  SizedBox(
                    width: 40.rw,
                    height: 16.rh,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          child: _DonatedPeoplePhoto(
                            imagePath: Assets.home.user4.path,
                          ),
                        ),
                        Positioned(
                          right: 8,
                          child: _DonatedPeoplePhoto(
                            imagePath: Assets.home.user3.path,
                          ),
                        ),
                        Positioned(
                          right: 16,
                          child: _DonatedPeoplePhoto(
                            imagePath: Assets.home.user2.path,
                          ),
                        ),
                        _DonatedPeoplePhoto(imagePath: Assets.home.user1.path),
                      ],
                    ),
                  ),
                  Text(
                    '+${totalDonors - recentDonors.length} People have already donated',
                    style: TextStyle(
                      color: const Color(0xFF647270),
                      fontSize: 12,
                      fontFamily: 'Inter Display',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            '\$${totalAmount.toStringAsFixed(2)}',
            style: TextStyle(
              color: const Color(0xFF000C0B) /* Colors-Off-Black */,
              fontSize: 20,
              fontFamily: 'Inter Display',
              fontWeight: FontWeight.w500,
              height: 1.20,
            ),
          ),
        ],
      ),
    );
  }
}

class TotalDonationsCard2 extends StatelessWidget {
  const TotalDonationsCard2({
    super.key,
    required this.color,
    required this.totalAmount,
    required this.totalDonors,
  });
  final Color color;
  final double totalAmount;
  final int totalDonors;

  @override
  Widget build(BuildContext context) {
    List<Widget> donorsProfilePhotos = [
      Positioned(
        right: 0,
        child: _DonatedPeoplePhoto(imagePath: Assets.home.user4.path),
      ),
      Positioned(
        right: 8,
        child: _DonatedPeoplePhoto(imagePath: Assets.home.user3.path),
      ),
      Positioned(
        right: 16,
        child: _DonatedPeoplePhoto(imagePath: Assets.home.user2.path),
      ),
      _DonatedPeoplePhoto(imagePath: Assets.home.user1.path),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                'Total Donations',
                style: TextStyle(
                  color: const Color(0xFF000C0B) /* Colors-Off-Black */,
                  fontSize: 14,
                  fontFamily: 'Inter Display',
                  fontWeight: FontWeight.w400,
                  height: 1.29,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 4,
                children: [
                  SizedBox(
                    width: 40.rw,
                    height: 16.rh,
                    child: Stack(
                      children: totalDonors > 4
                          ? donorsProfilePhotos
                          // : donorsProfilePhotos.sublist(0, totalDonors),
                          : [
                              ...List.generate(totalDonors, (index) {
                                return donorsProfilePhotos[index];
                              }),
                            ],
                    ),
                  ),
                  if (totalDonors > 4)
                    Text(
                      '+${totalDonors - 4} People have already donated',
                      style: TextStyle(
                        color: const Color(0xFF647270),
                        fontSize: 12,
                        fontFamily: 'Inter Display',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  if (totalDonors <= 4)
                    Text(
                      '$totalDonors People have already donated',
                      style: TextStyle(
                        color: const Color(0xFF647270),
                        fontSize: 12,
                        fontFamily: 'Inter Display',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                ],
              ),
            ],
          ),
          Text(
            '\$${totalAmount.toStringAsFixed(2)}',
            style: TextStyle(
              color: const Color(0xFF000C0B) /* Colors-Off-Black */,
              fontSize: 20,
              fontFamily: 'Inter Display',
              fontWeight: FontWeight.w500,
              height: 1.20,
            ),
          ),
        ],
      ),
    );
  }
}

class _DonatedPeoplePhoto extends StatelessWidget {
  const _DonatedPeoplePhoto({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: const Color(0xFFE4E4E4),
          ),
          borderRadius: BorderRadius.circular(228.34),
        ),
      ),
    );
  }
}
