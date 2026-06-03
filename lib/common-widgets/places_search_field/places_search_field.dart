
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class PlacesSearchField extends StatelessWidget {

  final String googleApiKey;
  final TextEditingController textEditingController;
  final Function(String) onItemClick;
  final FocusNode focusNode;
  final String? hintText;
  final String? prefixIconPath;
  final String? Function(String?, BuildContext)? validator;
  final Color backgroundColor;
  final List<double> padding;
  final Function(Prediction)? onPlaceSelected;


  const PlacesSearchField({
    super.key,
    required this.googleApiKey,
    required this.textEditingController,
    required this.onItemClick,
    required this.focusNode,
    this.validator,
    this.hintText,
    this.prefixIconPath,
    this.backgroundColor = Colors.white,
    this.padding = const[0, 0],
    this.onPlaceSelected
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: padding[0], vertical: padding[1]),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if( prefixIconPath != null )
          SvgPicture.asset( prefixIconPath! ),
          Expanded(
            child: IntrinsicHeight(
              child: GooglePlaceAutoCompleteTextField(
                validator: validator,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                textEditingController: textEditingController,
                googleAPIKey: googleApiKey,
                focusNode: focusNode,
                boxDecoration: const BoxDecoration(),
                inputDecoration: InputDecoration(
                  hintText: hintText,
                  errorStyle: const TextStyle(height: 0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                debounceTime: 400,
                //countries: ["in", "fr"],
                isLatLngRequired: true,
                getPlaceDetailWithLatLng: (Prediction prediction) {
                  if( onPlaceSelected != null ){
                    onPlaceSelected?.call(prediction);
                  }
                  //print("placeDetails" + prediction.lat.toString());
                },
                itemClick: (Prediction prediction) {
                  final placeName = prediction.description ?? "";
                  textEditingController.text = placeName;
                  //ADD PLACE NAME IN LOCATIONS LIST
                  onItemClick(placeName);
                  //controller.locationNames.add(placeName);
                  textEditingController.selection = TextSelection.fromPosition(
                    TextPosition(offset: prediction.description?.length ?? 0),
                  );
                  //textEditingController.clear();
                  focusNode.requestFocus();
                },
                seperatedBuilder: const Divider(),
                containerHorizontalPadding: 10,
                itemBuilder: (context, index, Prediction prediction) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 7),
                        Expanded(child: Text(prediction.description ?? "")),
                      ],
                    ),
                  );
                },
                isCrossBtnShown: true,
                // default 600 ms ,
              ),
            ),
          ),
        ],
      ),
    );
  }
}