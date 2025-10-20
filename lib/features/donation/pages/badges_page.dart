import 'package:cresent_charge_user_app/features/donation/controllers/badges_controller.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/badge_card.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BadgesPage extends StatelessWidget {
  const BadgesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BadgesController());
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 24),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Badges',
          style: TextStyle(
            color: Color(0xFF000C0B),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Familjen Grotesk',
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.rw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.rh),

            // Header text
            Text(
              'Earn your badges!',
              style: TextStyle(
                color: const Color(0xFF515A59),
                fontSize: 14.rfs,
                fontFamily: 'Inter',
              ),
            ),

            SizedBox(height: 8.rh),

            // Badges Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.rw,
                  mainAxisSpacing: 8.rh,
                  childAspectRatio: 167.5 / 214, // Width / Height from Figma
                ),
                itemCount: controller.badges.length,
                itemBuilder: (context, index) {
                  return BadgeCard(badge: controller.badges[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
