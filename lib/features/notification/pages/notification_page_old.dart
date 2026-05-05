// import 'package:donor/utils/app_colors/app_colors.dart';
// import 'package:donor/utils/sizer/sizer.dart';
// import 'package:donor/utils/text_style/text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class NotificationsPage extends StatefulWidget {
//   const NotificationsPage({super.key});

//   @override
//   State<NotificationsPage> createState() => _NotificationsPageState();
// }

// class _NotificationsPageState extends State<NotificationsPage> {
//   int selectedCategoryIndex = 0;

//   final List<String> categories = [
//     'All',
//     'Impact',
//     'Rewards',
//     'Donations',
//     'Campaigns',
//     'System',
//   ];

//   final List<NotificationItem> notifications = [
//     NotificationItem(
//       title: 'New Campaign Alert',
//       description:
//           'Help children in need with clean water access. Your support can make a real difference.',
//       time: '2 min ago',
//       isRead: false,
//       type: NotificationType.campaigns,
//       avatarAsset: 'assets/home/user-1.png',
//     ),
//     NotificationItem(
//       title: 'Donation Successful',
//       description:
//           'Your donation of \$25 has been processed successfully. Thank you for your generosity!',
//       time: '1 hour ago',
//       isRead: false,
//       type: NotificationType.donations,
//       avatarAsset: 'assets/home/user-2.png',
//     ),
//     NotificationItem(
//       title: 'Campaign Update',
//       description:
//           'Education for All campaign has reached 80% of its goal. Keep up the amazing work!',
//       time: '3 hours ago',
//       isRead: true,
//       type: NotificationType.campaigns,
//       avatarAsset: 'assets/home/user-3.png',
//     ),
//     NotificationItem(
//       title: 'Reward Earned!',
//       description:
//           'You\'ve earned a new badge for your continued support. Check your rewards page.',
//       time: '5 hours ago',
//       isRead: true,
//       type: NotificationType.rewards,
//       avatarAsset: 'assets/home/user-4.png',
//     ),
//     NotificationItem(
//       title: 'Impact Report',
//       description:
//           'Your monthly impact report is now available. See how your donations are making a difference.',
//       time: '1 day ago',
//       isRead: true,
//       type: NotificationType.impact,
//       avatarAsset: 'assets/home/user-1.png',
//     ),
//     NotificationItem(
//       title: 'Security Alert',
//       description:
//           'Your account was accessed from a new device. If this wasn\'t you, please secure your account.',
//       time: '2 days ago',
//       isRead: true,
//       type: NotificationType.system,
//       avatarAsset: 'assets/home/user-2.png',
//     ),
//   ];

//   List<NotificationItem> get filteredNotifications {
//     if (selectedCategoryIndex == 0) return notifications; // All

//     final NotificationType filterType = switch (selectedCategoryIndex) {
//       1 => NotificationType.impact,
//       2 => NotificationType.rewards,
//       3 => NotificationType.donations,
//       4 => NotificationType.campaigns,
//       5 => NotificationType.system,
//       _ => NotificationType.campaigns,
//     };

//     return notifications
//         .where((notification) => notification.type == filterType)
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _buildAppBar(),
//       body: Column(
//         children: [
//           _buildCategoryFilter(),
//           Expanded(child: _buildNotificationList()),
//         ],
//       ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       scrolledUnderElevation: 0,
//       title: Text(
//         'Notifications',
//         style: AppTextStyles.f20w600().copyWith(
//           color: const Color(0xFF000C0B),
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//       centerTitle: true,
//       leading: IconButton(
//         onPressed: () => Navigator.pop(context),
//         icon: SvgPicture.asset(
//           'assets/common/arrow-left.svg',
//           width: 24.rw,
//           height: 24.rh,
//           colorFilter: const ColorFilter.mode(
//             Color(0xFF000C0B),
//             BlendMode.srcIn,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryFilter() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 16.rh),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         padding: EdgeInsets.symmetric(horizontal: 16.rw),
//         child: Row(
//           children: List.generate(categories.length, (index) {
//             final isSelected = selectedCategoryIndex == index;
//             return Padding(
//               padding: EdgeInsets.only(right: 8.rw),
//               child: _buildCategoryChip(
//                 categories[index],
//                 isSelected,
//                 () => setState(() => selectedCategoryIndex = index),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryChip(String label, bool isSelected, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 8.rh),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF000C0B) : Colors.white,
//           borderRadius: BorderRadius.circular(24),
//           border: isSelected
//               ? null
//               : Border.all(color: const Color(0xFFEDEDED), width: 1),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             color: isSelected ? Colors.white : const Color(0xFF000C0B),
//             fontSize: 14.rfs,
//             fontFamily: 'Inter Display',
//             fontWeight: FontWeight.w400,
//             height: 1.29,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNotificationList() {
//     final notifications = filteredNotifications;

//     if (notifications.isEmpty) {
//       return _buildEmptyState();
//     }

//     return ListView.separated(
//       padding: EdgeInsets.symmetric(horizontal: 16.rw),
//       itemCount: notifications.length,
//       separatorBuilder: (context, index) => SizedBox(height: 12.rh),
//       itemBuilder: (context, index) {
//         return _buildNotificationCard(notifications[index]);
//       },
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgPicture.asset(
//             'assets/common/alert.svg',
//             width: 64.rw,
//             height: 64.rh,
//             colorFilter: const ColorFilter.mode(
//               Color(0xFF808080),
//               BlendMode.srcIn,
//             ),
//           ),
//           SizedBox(height: 16.rh),
//           Text(
//             'No notifications yet',
//             style: AppTextStyles.f16W500().copyWith(
//               color: const Color(0xFF808080),
//             ),
//           ),
//           SizedBox(height: 8.rh),
//           Text(
//             'We\'ll notify you when something happens',
//             style: AppTextStyles.f14W400().copyWith(
//               color: const Color(0xFF808080),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNotificationCard(NotificationItem notification) {
//     return Container(
//       padding: EdgeInsets.all(16.rw),
//       decoration: BoxDecoration(
//         color: notification.isRead ? Colors.white : const Color(0xFFF8F9FA),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFEDEDED), width: 1),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildNotificationAvatar(notification),
//           SizedBox(width: 12.rw),
//           Expanded(child: _buildNotificationContent(notification)),
//           _buildNotificationIndicator(notification),
//         ],
//       ),
//     );
//   }

//   Widget _buildNotificationAvatar(NotificationItem notification) {
//     return Container(
//       width: 40.rw,
//       height: 40.rh,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         image: DecorationImage(
//           image: AssetImage(notification.avatarAsset),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   Widget _buildNotificationContent(NotificationItem notification) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           notification.title,
//           style: AppTextStyles.f16W500().copyWith(
//             color: const Color(0xFF000C0B),
//             fontWeight: notification.isRead ? FontWeight.w400 : FontWeight.w600,
//           ),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//         SizedBox(height: 4.rh),
//         Text(
//           notification.description,
//           style: AppTextStyles.f14W400().copyWith(
//             color: const Color(0xFF808080),
//             height: 1.4,
//           ),
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//         SizedBox(height: 8.rh),
//         Text(
//           notification.time,
//           style: AppTextStyles.f14W400().copyWith(
//             color: const Color(0xFF808080),
//             fontSize: 12.rfs,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildNotificationIndicator(NotificationItem notification) {
//     if (notification.isRead) return const SizedBox.shrink();

//     return Container(
//       width: 8.rw,
//       height: 8.rh,
//       decoration: BoxDecoration(
//         color: AppColors.primaryColor,
//         borderRadius: BorderRadius.circular(4),
//       ),
//     );
//   }
// }

// // Data Models
// class NotificationItem {
//   final String title;
//   final String description;
//   final String time;
//   final bool isRead;
//   final NotificationType type;
//   final String avatarAsset;

//   NotificationItem({
//     required this.title,
//     required this.description,
//     required this.time,
//     required this.isRead,
//     required this.type,
//     required this.avatarAsset,
//   });
// }

// enum NotificationType { impact, rewards, donations, campaigns, system }
