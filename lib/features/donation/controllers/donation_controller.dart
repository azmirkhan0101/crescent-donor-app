import 'package:cresent_charge_user_app/features/donation/models/client_stats_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/helper/tost_message/toast_message.dart';
import '../models/roundup_org_model.dart';

class DonationController extends GetxController {
  final RxString selectedFilter = 'This Month'.obs;
  final RxString pointsEarned = '16000'.obs;

  var clientStats = Rx<ClientStats?>(null);
  var isLoadingClientStats = false.obs;
  var errorMessageClientStats = ''.obs;

  //ROUND UP CARD DROPDOWN
  final RxString selectedTitle = ''.obs;
  final organisations = <RoundupOrgModel>[].obs;
  RxList<String> organisationNames = <String>[].obs;
  RxList<String> roundUpIds = <String>[].obs;

  final _isLoading = false.obs;
  final _errorMessage = ''.obs;

  //RxBool get isLoading => _isLoading;
  RxString get errorMessage => _errorMessage;

  Future<bool> fetchOrgs() async {
    _isLoading.value = true;
    _errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      "${ApiUrl.baseUrl}/secure-roundup/get-organizations",
      withAuth: true,
    );
    _isLoading.value = false;

    return response.fold(
          (error) {
        _errorMessage.value = error.message ?? 'Failed to fetch orgs';
        ToastMsg.error(_errorMessage.value);
        return false;
      },
          (data) {
        List<dynamic> dataList = data['data'] ?? [];

        if (dataList.isNotEmpty) {
          organisations.value = dataList
              .map((item) => RoundupOrgModel.fromJson(item))
              .toList();
          organisationNames.value = organisations.map((org) => org.orgName).toList();
          roundUpIds.value = organisations.map((org) => org.roundupId).toList();
          selectedTitle.value = organisationNames.first;
          if( roundUpIds.value.isNotEmpty ){
            fetchClientStats(roundupId: roundUpIds.first);
          }
        } else {
          selectedTitle.value = "Select";
          organisations.clear();
          organisationNames.clear();
          roundUpIds.clear();
        }
        return true;
      },
    );
  }

  //GET DONATION BY ROUNDUP ID

  // Filter options
  final List<String> filterOptions = [
    'Today',
    'Yesterday',
    'This Week',
    'Last Week',
    'This Month',
    'Last Month',
    'This Year',
    'Last Year',
  ];

  // Map display text to API parameter value
  String _getFilterValue(String displayText) {
    final Map<String, String> filterMap = {
      'Today': 'today',
      'Yesterday': 'yesterday',
      'This Week': 'this_week',
      'Last Week': 'last_week',
      'This Month': 'this_month',
      'Last Month': 'last_month',
      'This Year': 'this_year',
      'Last Year': 'last_year',
    };
    return filterMap[displayText] ?? 'this_month';
  }

  // Update selected filter and fetch new data
  void updateFilter(String filter) {
    selectedFilter.value = filter;
    fetchClientStats(roundupId: roundUpIds.value.first);
  }

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

  Future<void> fetchClientStats({required String roundupId}) async {
    isLoadingClientStats.value = true;
    errorMessageClientStats.value = '';

    final timeFilter = _getFilterValue(selectedFilter.value);

    final url = '${ApiUrl.clientStats}?timeFilter=$timeFilter&roundupId=$roundupId';

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      url,
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
        debugPrint(
          'Client stats fetched successfully with filter: $timeFilter',
        );
      },
    );
  }
}

class DonationChartPoint {
  final String label;
  final double amount;

  DonationChartPoint({required this.label, required this.amount});
}
