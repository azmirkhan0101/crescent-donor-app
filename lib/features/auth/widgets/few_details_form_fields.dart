import 'dart:convert';

import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/profile_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/custom_input_field.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../../../common-widgets/places_search_field/places_search_field.dart';

class FewDetailFormFields extends StatefulWidget {
  const FewDetailFormFields({super.key});

  @override
  State<FewDetailFormFields> createState() => _FewDetailFormFieldsState();
}

class _FewDetailFormFieldsState extends State<FewDetailFormFields> {
  late final ProfileController controller;
  final String googleApiKey = dotenv.env['GOOGLE_API_KEY']!;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // spacing: 16.rh, // If needed, add SizedBox for spacing between children
      children: [
        // Full Name field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStrings.fullName
                .text(AppTextStyles.baseStyle())
                .color("#000C0B".hexColor),

            8.rh.heightWidth,
            CustomInputField(
              controller: controller.nameController,
              hintText: AppStrings.enterName,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              isPrefixIcon: false,
              validator: controller.validateName,
            ),
          ],
        ),

        // Address field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStrings.address
                .text(AppTextStyles.baseStyle())
                .color("#000C0B".hexColor),

            8.rh.heightWidth,

            // CustomInputField(
            //   controller: controller.addressController,
            //   hintText: AppStrings.enterAddress,
            //   textInputAction: TextInputAction.next,
            //   keyboardType: TextInputType.text,
            //   isPrefixIcon: false,
            //   minLines: 2,
            //   validator: controller.validateAddress,
            // ),
            PlacesSearchField(
                googleApiKey: googleApiKey,
                textEditingController: controller.addressController,
                hintText: "Address",
                onPlaceSelected: (prediction){
                  _fillFromPlaceDetails(prediction);
                },
                onItemClick: (value){
                  controller.addressController.text = value;
                  controller.addressController.selection = TextSelection.fromPosition(
                    TextPosition(offset: controller.addressController.text.length),
                  );
                },
                focusNode: focusNode
            ),
          ],
        ),

        // State and Postal code fields
        Row(
          children: [
            // State field
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStrings.state
                      .text(AppTextStyles.baseStyle())
                      .color("#000C0B".hexColor),

                  8.rh.heightWidth,
                  CustomInputField(
                    controller: controller.stateController,
                    hintText: AppStrings.state,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    isPrefixIcon: false,
                    validator: controller.validateState
                  ),
                ],
              ),
            ),

            16.rw.heightWidth,

            // Postal Code field
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStrings.postalCode
                      .text(AppTextStyles.baseStyle())
                      .color("#000C0B".hexColor),

                  8.rh.heightWidth,
                  CustomInputField(
                    controller: controller.postalCodeController,
                    hintText: AppStrings.postalCode,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    isPrefixIcon: false,
                    validator: controller.validatePostalCode,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Extract address from Google Places details - state, postal code
  Future<void> _fillFromPlaceDetails(Prediction prediction) async {
    final placeId = prediction.placeId;
    if (placeId == null) return;

    final url =
        'https://maps.googleapis.com/maps/api/place/details/json'
        '?place_id=$placeId'
        '&fields=address_component'
        '&key=$googleApiKey';

    final uri = Uri.parse(url);
    final res = await NetworkAssetBundle(uri).load("");
    final json = jsonDecode(utf8.decode(res.buffer.asUint8List()));

    final components = json['result']['address_components'] as List;

    for (var c in components) {
      final types = List<String>.from(c['types']);

      if (types.contains('administrative_area_level_1')) {
        controller.stateController.text = c['short_name'];
      } else if (types.contains('postal_code')) {
        controller.postalCodeController.text = c['long_name'];
      }
    }
  }
}
