import 'package:cresent_charge_user_app/features/donation/models/client_stats_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DonationController extends GetxController {
  final RxString selectedFilter = 'Last 30 Days'.obs;
  final RxString pointsEarned = '16000'.obs;

  var clientStats = Rx<ClientStats?>(null);
  var isLoadingClientStats = false.obs;
  var errorMessageClientStats = ''.obs;

  List<DonationChartPoint> get donationChartPoints {
    final stats = clientStats.value;
    if (stats == null || stats.donationDates.isEmpty) return [];

    final Map<DateTime, double> aggregated = {};
    for (final donation in stats.donationDates) {
      final parsedDate = DateTime.tryParse(donation.date);
      if (parsedDate == null) continue;
      final dayKey = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
      );
      aggregated[dayKey] = (aggregated[dayKey] ?? 0) + donation.amount;
    }

    final sortedKeys = aggregated.keys.toList()..sort();
    return sortedKeys
        .map(
          (date) => DonationChartPoint(
            label: DateFormat('d').format(date),
            amount: aggregated[date] ?? 0,
          ),
        )
        .toList();
  }

  List<double> get donationChartData =>
      donationChartPoints.map((point) => point.amount).toList();

  List<String> get donationChartLabels =>
      donationChartPoints.map((point) => point.label).toList();

  Future<void> fetchClientStats() async {
    isLoadingClientStats.value = true;
    errorMessageClientStats.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      ApiUrl.clientStats,
      withAuth: true,
    );
    isLoadingClientStats.value = false;

    response.fold(
      (error) {
        errorMessageClientStats.value = error.message ?? 'An error occurred';
        debugPrint('Error fetching client stats: ${error.message}');
      },
      (data) {
        final clientStatsResponse = ClientStatsResponse.fromJson(data);
        clientStats.value = clientStatsResponse.data;
        debugPrint('Client stats fetched successfully');
      },
    );
  }
}

class DonationChartPoint {
  final String label;
  final double amount;

  DonationChartPoint({required this.label, required this.amount});
}
