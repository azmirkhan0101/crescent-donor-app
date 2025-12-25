import 'package:get/get.dart';

class BadgesController extends GetxController {
  final List<String> _badgeList = ['bronze', 'silver', 'gold', 'platinum'];
  final List<String> _tierList = ['colour', 'bronze', 'silver', 'gold'];

  List<String> get badgeList => _badgeList;
  List<String> get tierList => _tierList;

  int getBadgeIndex(String badge) {
    int index = _badgeList.indexOf(badge.toLowerCase());
    if (index == -1) return 0;
    return index;
  }

  int getTierIndex(String tier) {
    int index = _tierList.indexOf(tier.toLowerCase());
    if (index == -1) return 0;
    return index;
  }

  double getTierProgress(String currentTier, double percent) {
    final index = getTierIndex(currentTier.toLowerCase());
    if (index == -1) return 0.0;
    double progress = index + (percent / 100);
    if (progress > _tierList.length - 1) {
      progress = (_tierList.length - 1).toDouble();
    }
    return progress;
  }
}
