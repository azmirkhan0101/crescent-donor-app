import 'package:cresent_charge_user_app/features/home/widgets/total_donations_card.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';

class DonationCauseCard extends StatelessWidget {
  const DonationCauseCard({
    super.key,
    required this.index,
    required this.title,
    required this.category,
    required this.amount,
    required this.donors,
    required this.bannerPath,
    required this.profilePath,
  });

  final int index;
  final String title;
  final String category;
  final String amount;
  final String donors;
  final String bannerPath;
  final String profilePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 322.rh,
      padding: EdgeInsets.all(8.rw),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.rw),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Campaign image, profile, and category
          Stack(
            children: [
              184.rh.heightWidth,
              Container(
                width: double.infinity,
                height: 144.rh,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.rw)),
                  image: DecorationImage(
                    image: AssetImage(bannerPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// Profile image
              Positioned(
                bottom: 0.rh,
                left: 8.rw,
                child: Container(
                  width: 80,
                  height: 80,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage(profilePath),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFEAE9EB) /* Colors-Light-Gray */,
                      ),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),
              ),

              /// Category Label
              // Positioned(
              //   bottom: 4.rh,
              //   right: 8.rw,
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 8,
              //       vertical: 4,
              //     ),
              //     clipBehavior: Clip.antiAlias,
              //     decoration: ShapeDecoration(
              //       color: index == 0
              //           ? const Color(0xFFFFE8CB)
              //           : const Color(0xFFDAFFDB),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(24),
              //       ),
              //     ),
              //     child: Text(
              //       category,
              //       style: TextStyle(
              //         color: const Color(0xFF000C0B),
              //         fontSize: 10,
              //         fontFamily: 'Inter Display',
              //         fontWeight: FontWeight.w400,
              //         height: 1.20,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),

          8.rh.heightWidth,

          /// Campaign title
          title.text(AppTextStyles.f16W500()),
          8.rh.heightWidth,

          /// Campaign details
          TotalDonationsCard(color: const Color(0xFFC7ECFF)),
        ],
      ),
    );
  }
}
