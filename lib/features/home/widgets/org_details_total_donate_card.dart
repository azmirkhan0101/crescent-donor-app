import 'package:cresent_charge_user_app/features/organization/models/organization_details_model.dart';
import 'package:flutter/material.dart';

class OrgDetailTotalDonationsCard extends StatelessWidget {
  const OrgDetailTotalDonationsCard({
    super.key,
    required this.color,
    required this.totalDonatedAmount,
    required this.totalDonors,
    required this.recentDonors,
  });
  final Color? color;
  final double totalDonatedAmount;
  final int totalDonors;
  final List<RecentDonor> recentDonors;

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
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 4,
                children: [
                  SizedBox(
                    width: 16 + (8 * (recentDonors.length - 1)),
                    height: 16,
                    child: Stack(
                      children: [
                        ...recentDonors.map((donor) {
                          int index = recentDonors.indexOf(donor);
                          return Positioned(
                            left: index * 8,
                            child: _DonatedPeoplePhoto(
                              imagePath: donor.donorImage,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),

                  if (totalDonors > recentDonors.length)
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
                  if (totalDonors <= recentDonors.length)
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
            '\$${totalDonatedAmount.toStringAsFixed(2)}',
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
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
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
