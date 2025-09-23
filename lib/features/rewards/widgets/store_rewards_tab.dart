import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

class StoreRewardsTab extends StatelessWidget {
  const StoreRewardsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.rw),
      child: Column(
        children: [
          // Rewards Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.rw,
              mainAxisSpacing: 12.rh,
              childAspectRatio: 0.85,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildRewardCard(index);
            },
          ),
          
          40.rh.heightWidth,
        ],
      ),
    );
  }

  Widget _buildRewardCard(int index) {
    // Sample data for different cards
    final rewards = [
      {
        'title': '10% off on Groceries',
        'points': '150',
        'status': 'available',
        'expires': '28 May 2025',
      },
      {
        'title': '10% off on Groceries',
        'points': '450',
        'status': 'available',
        'expires': '28 May 2025',
      },
      {
        'title': '10% off on Groceries',
        'points': '150',
        'status': 'claimed',
        'expires': '28 May 2025',
      },
      {
        'title': '10% off on Groceries',
        'points': '150',
        'status': 'available',
        'expires': '28 May 2025',
      },
    ];

    final reward = rewards[index];
    final isClaimed = reward['status'] == 'claimed';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.rw),
        border: Border.all(
          color: const Color(0xFFEDEDED),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Container(
            height: 100.rh,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.rw),
                topRight: Radius.circular(12.rw),
              ),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFEF4444),
                  const Color(0xFFF97316),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // Amazon logo in bottom left
                Positioned(
                  bottom: 8.rh,
                  left: 8.rw,
                  child: Container(
                    width: 24.rw,
                    height: 24.rh,
                    decoration: const BoxDecoration(
                      color: Color(0xFF000C0B),
                      shape: BoxShape.circle,
                    ),
                    child: Assets.rewards.amazonA.svg(
                      width: 12.rw,
                      height: 12.rh,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content section
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.rw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Points and heart icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 16.rfs,
                            color: const Color(0xFF000C0B),
                          ),
                          4.rw.heightWidth,
                          Text(
                            reward['points']!,
                            style: TextStyle(
                              color: const Color(0xFF000C0B),
                              fontSize: 14.rfs,
                              fontFamily: 'Inter Display',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      if (index == 1) // Show higher points for second card
                        Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 16.rfs,
                              color: const Color(0xFF000C0B),
                            ),
                            4.rw.heightWidth,
                            Text(
                              '450',
                              style: TextStyle(
                                color: const Color(0xFF000C0B),
                                fontSize: 14.rfs,
                                fontFamily: 'Inter Display',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  
                  8.rh.heightWidth,
                  
                  // Title
                  Text(
                    reward['title']!,
                    style: TextStyle(
                      color: const Color(0xFF000C0B),
                      fontSize: 14.rfs,
                      fontFamily: 'Inter Display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  4.rh.heightWidth,
                  
                  // Description
                  Text(
                    'Enjoy 10% off on your next grocery',
                    style: TextStyle(
                      color: const Color(0xFF818F8D),
                      fontSize: 12.rfs,
                      fontFamily: 'Inter Display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  
                  4.rh.heightWidth,
                  
                  // Expiry date
                  Text(
                    'Expires: ${reward['expires']}',
                    style: TextStyle(
                      color: const Color(0xFF818F8D),
                      fontSize: 10.rfs,
                      fontFamily: 'Inter Display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Action button
                  Container(
                    width: double.infinity,
                    height: 32.rh,
                    decoration: BoxDecoration(
                      color: isClaimed 
                          ? const Color(0xFF6B7280) 
                          : const Color(0xFFD1FF43),
                      borderRadius: BorderRadius.circular(6.rw),
                    ),
                    child: Center(
                      child: Text(
                        isClaimed ? 'Claimed' : 'Redeem',
                        style: TextStyle(
                          color: isClaimed 
                              ? Colors.white 
                              : const Color(0xFF000C0B),
                          fontSize: 12.rfs,
                          fontFamily: 'Inter Display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
