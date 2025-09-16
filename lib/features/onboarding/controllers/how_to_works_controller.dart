import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:get/get.dart';

class HowToWorksController extends GetxController {
  RxInt currentIndex = 0.obs;

  void updateIndex(int index) => currentIndex.value = index;

  List<List<String>> rewardsList = [
    [
      AppStrings.earnRewardsAtLocalAndOnlineSpots,
      AppStrings.grabACoffeeOrShopOnline,
    ],
    [
      AppStrings.redeemInStoreOrOnline,
      AppStrings.useYourPhoneToClaimRewards,
    ],
    [
      AppStrings.yourSpareChangeDoesGood,
      AppStrings.everyTransactionSupportsRealCauses,
    ],
    [
      AppStrings.chooseWhereYourImpactGoes,
      AppStrings.everyTimeYouSpend,
    ],
  ];


}
