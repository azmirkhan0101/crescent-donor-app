import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/url_parser/image_url_parser.dart';
import 'package:cresent_charge_user_app/features/home/models/donor_model.dart';
import 'package:cresent_charge_user_app/features/home/widgets/org_details_total_donate_card.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';

class DonationCauseCard extends StatelessWidget {
  const DonationCauseCard({
    super.key,
    required this.causeBanner,
    required this.orgLogo,
    required this.description,
    required this.category,
    required this.amount,
    required this.totalDonors,
    required this.recentDonors,
  });

  final String causeBanner;
  final String orgLogo;
  final String description;
  final String category;
  final double amount;
  final int totalDonors;
  final List<DonorModel> recentDonors;

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
              ClipRRect(
                borderRadius: BorderRadius.circular(12.rw),
                child: Image.network(
                  parseImageUrl(causeBanner),
                  width: double.infinity,
                  height: 144.rh,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.broken_image,
                      size: 144.rh,
                      color: Colors.grey,
                    );
                  },
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
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFEAE9EB),
                      ),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: Image.network(
                      parseImageUrl(orgLogo),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.broken_image,
                          size: 80,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
              ),

              /// TODO: Category Label (removed by client)
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
          description.text(AppTextStyles.f16W500()),
          8.rh.heightWidth,
          OrgDetailTotalDonationsCard(
            color: const Color(0xFFC7ECFF),
            totalDonatedAmount: amount,
            totalDonors: totalDonors,
            recentDonorsImageUrl: [...recentDonors.map((donor) => donor.image)],
          ),
        ],
      ),
    );
  }
}
