import 'package:explore_places/utils/AppConstant.dart';
import 'package:explore_places/utils/Extensions/AppButton.dart';
import 'package:explore_places/utils/Extensions/Widget_extensions.dart';
import 'package:explore_places/utils/Extensions/int_extensions.dart';
import 'package:explore_places/utils/Extensions/string_extensions.dart';
import 'package:explore_places/utils/Extensions/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main_temp.dart';
import '../models/CategoryModel.dart';
import '../utils/AppColor.dart';
import '../utils/Common.dart';
import '../utils/Extensions/AppTextField.dart';
import '../utils/Extensions/Colors.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/decorations.dart';
import 'ViewAllScreen.dart';

class PlaceFinderScreen extends StatefulWidget {
  @override
  PlaceFinderScreenState createState() => PlaceFinderScreenState();
}

class PlaceFinderScreenState extends State<PlaceFinderScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController distanceCont = TextEditingController();

  List<CategoryModel> categoryList = [];
  String? categoryId;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    categoryList = await categoryService.getCategories();
    await getCurrentPosition();
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(language.placeFinder)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(language.selectYrPreference, style: boldTextStyle(size: 18)),
              30.height,
              Text(language.selectCategory, style: primaryTextStyle()),
              8.height,
              DropdownButtonFormField<String>(
                dropdownColor: Theme.of(context).cardColor,
                value: categoryId,
                decoration: commonInputDecoration(),
                items: categoryList.map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem(
                    value: item.id,
                    child: Text(item.name.validate(), style: primaryTextStyle()),
                  );
                }).toList(),
                onChanged: (value) {
                  categoryId = value!;
                  setState(() {});
                },
                validator: (s) {
                  return null;
                },
              ),
              16.height,
              Text(language.distanceKm, style: primaryTextStyle()),
              SizedBox(height: 8),
              AppTextField(
                controller: distanceCont,
                textFieldType: TextFieldType.OTHER,
                decoration: commonInputDecoration(),
                textInputAction: TextInputAction.next,
                maxLength: 5,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9 .]')),
                ],
                validator: (value) {
                  if (value.validate().isEmpty) return errorThisFieldRequired;
                  return null;
                },
              ),
              30.height,
              AppButtonWidget(
                text: language.search,
                textStyle: boldTextStyle(color: whiteColor),
                color: primaryColor,
                shapeBorder: RoundedRectangleBorder(borderRadius: radius(defaultRadius)),
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    if (appStore.currentPosition == null) {
                      getCurrentPosition().then((value) {
                        if (appStore.currentPosition != null) {
                          ViewAllScreen(name: language.nearByPlaces, placesType: placesTypeNearBy, catId: categoryId, distance: distanceCont.text.toDouble()).launch(context);
                        }
                      });
                    } else {
                      ViewAllScreen(name: language.nearByPlaces, placesType: placesTypeNearBy, catId: categoryId, distance: distanceCont.text.toDouble()).launch(context);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
