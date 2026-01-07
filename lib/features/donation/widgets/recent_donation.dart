import 'package:cresent_charge_user_app/features/donation/models/recent_donations_groupe_model.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

class RecentDonation extends StatelessWidget {
  const RecentDonation({super.key, required this.recentDonations});

  final List<RecentDonationsGroupModel> recentDonations;

  @override
  Widget build(BuildContext context) {
    if (recentDonations.isEmpty) {
      return Center(child: Text("No recent donations"));
    }
    return Container(
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE4E4E4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(recentDonations.length, (groupIndex) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recentDonations[groupIndex].title,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 8),
                ...List.generate(recentDonations[groupIndex].donations.length, (
                  donationIndex,
                ) {
                  final donation =
                      recentDonations[groupIndex].donations[donationIndex];
                  return Column(
                    children: [
                      _buildDonationItem(
                        donation.orgName,
                        donation.amount,
                        donation.timeAgo,

                        ///TODO: add network image instead of asset
                        'assets/hope_foundation_logo.png',
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }),
              ],
            );
          }),
          // TODAY Section
          // const Text(
          //   'TODAY',
          //   style: TextStyle(
          //     fontSize: 11,
          //     color: Colors.grey,
          //     fontWeight: FontWeight.w500,
          //     fontFamily: 'Inter',
          //   ),
          // ),
          // const SizedBox(height: 8),

          // // Today's donation
          // _buildDonationItem(
          //   'Hope for Learning Foundation',
          //   20.0,
          //   '4 hours ago',
          //   'assets/hope_foundation_logo.png',
          // ),

          // const SizedBox(height: 16),

          // // 20 July Section
          // const Text(
          //   '20 July',
          //   style: TextStyle(
          //     fontSize: 11,
          //     color: Colors.grey,
          //     fontWeight: FontWeight.w500,
          //     fontFamily: 'Inter',
          //   ),
          // ),
          // const SizedBox(height: 8),

          // // Previous donations
          // _buildDonationItem(
          //   'Hope for Learning Foundation',
          //   10.0,
          //   '2 days ago',
          //   'assets/hope_foundation_logo.png',
          // ),

          // const SizedBox(height: 12),

          // _buildDonationItem(
          //   'Animal Care & Shelter',
          //   20.2,
          //   '2 days ago',
          //   'assets/animal_care_logo.png',
          // ),
        ],
      ),
    );
  }

  Widget _buildDonationItem(
    String organization,
    double amount,
    String timeAgo,
    String logoPath,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(22),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Container(
                color: const Color(0xFF171717),
                child: const Icon(
                  Icons.business,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  organization,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF000C0B),
                    fontFamily: 'Inter',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      timeAgo,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Text(
                      '+\$${amount.toStringAsFixed(amount.truncateToDouble() == amount ? 0 : 2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xFF1AC461),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
