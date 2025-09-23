import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

class StoreOverviewTab extends StatelessWidget {
  const StoreOverviewTab({
    super.key,
    required this.storeName,
  });

  final String storeName;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.rw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact Information Cards
          Row(
            children: [
              // Website Card
              Expanded(
                child: _buildContactCard(
                  icon: Icons.language,
                  iconColor: const Color(0xFF6B46C1),
                  backgroundColor: const Color(0xFFEDE9FE),
                  title: 'Website',
                  subtitle: '${storeName.toLowerCase()}.com',
                ),
              ),
              
              12.rw.heightWidth,
              
              // Business Phone Card
              Expanded(
                child: _buildContactCard(
                  icon: Icons.phone,
                  iconColor: const Color(0xFF059669),
                  backgroundColor: const Color(0xFFD1FAE5),
                  title: 'Business Phone',
                  subtitle: '(555) 123-4567',
                ),
              ),
            ],
          ),
          
          12.rh.heightWidth,
          
          // Email Card (Full Width)
          _buildContactCard(
            icon: Icons.email,
            iconColor: const Color(0xFFD97706),
            backgroundColor: const Color(0xFFFEF3C7),
            title: 'Email',
            subtitle: 'contact@${storeName.toLowerCase()}.com',
            isFullWidth: true,
          ),
          
          24.rh.heightWidth,
          
          // Overview Section
          Text(
            'Overview',
            style: TextStyle(
              color: const Color(0xFF000C0B),
              fontSize: 18.rfs,
              fontFamily: 'Inter Display',
              fontWeight: FontWeight.w600,
            ),
          ),
          
          12.rh.heightWidth,
          
          Text(
            'Shop Online Today with $storeName — Browse & discover millions of products. Read customer reviews and find best sellers. Yes, we ship to you. Shop top brands in electronics, clothing, books & more.',
            style: TextStyle(
              color: const Color(0xFF515A59),
              fontSize: 14.rfs,
              fontFamily: 'Inter Display',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          
          24.rh.heightWidth,
          
          // Locations Section
          Text(
            'Locations',
            style: TextStyle(
              color: const Color(0xFF000C0B),
              fontSize: 18.rfs,
              fontFamily: 'Inter Display',
              fontWeight: FontWeight.w600,
            ),
          ),
          
          16.rh.heightWidth,
          
          // Location Items
          _buildLocationItem('Address of Store #1'),
          12.rh.heightWidth,
          _buildLocationItem('Address of Store #2'),
          
          40.rh.heightWidth,
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required String title,
    required String subtitle,
    bool isFullWidth = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.rw),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.rw,
            height: 40.rh,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.rw),
            ),
            child: Icon(
              icon,
              size: 20.rfs,
              color: iconColor,
            ),
          ),
          
          12.rh.heightWidth,
          
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF000C0B),
              fontSize: 16.rfs,
              fontFamily: 'Inter Display',
              fontWeight: FontWeight.w600,
            ),
          ),
          
          4.rh.heightWidth,
          
          Text(
            subtitle,
            style: TextStyle(
              color: const Color(0xFF515A59),
              fontSize: 12.rfs,
              fontFamily: 'Inter Display',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationItem(String address) {
    return Container(
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.rw),
        border: Border.all(
          color: const Color(0xFFEDEDED),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.rw,
            height: 40.rh,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8.rw),
            ),
            child: Icon(
              Icons.location_on_outlined,
              size: 20.rfs,
              color: const Color(0xFF6B7280),
            ),
          ),
          
          12.rw.heightWidth,
          
          Expanded(
            child: Text(
              address,
              style: TextStyle(
                color: const Color(0xFF000C0B),
                fontSize: 14.rfs,
                fontFamily: 'Inter Display',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          Icon(
            Icons.arrow_forward_ios,
            size: 16.rfs,
            color: const Color(0xFF9CA3AF),
          ),
        ],
      ),
    );
  }
}
