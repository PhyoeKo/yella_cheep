import 'dart:convert';

import 'package:explore_places/utils/Extensions/shared_pref.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../main_temp.dart';
import '../screens/ViewAllScreen.dart';
import '../utils/Common.dart';
import '../utils/Extensions/string_extensions.dart';
import '../components/HomeCategoryWidget.dart';
import '../models/DashboardResponse.dart';
import '../models/PlaceModel.dart';
import '../utils/AppConstant.dart';
import '../utils/Extensions/HorizontalList.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import 'package:flutter/material.dart';
import '../components/PlacesComponent.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchCont = TextEditingController();
  DashboardResponse? dashboardResponse;

  @override
  void initState() {
    super.initState();
    _fetchData();
    init();
  }

  Future<void> _fetchData() async {
    const apiUrl = 'https://yalla.cheap/version.txt';

    final response = await http.get(Uri.parse(apiUrl));
    final data = response.body;


    await PackageInfo.fromPlatform().then((value) {
      String currentVersion = value.version;
     // print("Current Version is $currentVersion and his version is $data");
      if(currentVersion!=data.trim()){
        showWarningDialog(
            title: language.forceUpdateTitle,
            content:
            language.forceUpdateContent,
            context: context,
            okButtonText: language.forceUpdate,
            cancellable: false);
      }
    });

  }

  void init() async {
    loadRewardedAds(onAdComplete: () {
      appStore.addFavourite(appStore.selectedPlaceId);
      setState(() {});
    });
    appStore.setLoading(true);
    await getCurrentPosition().then((value) async {
      await placeService.getDashboardData().then((value) {
        appStore.setLoading(false);
        dashboardResponse = value;
        setState(() {});
      }).catchError((e) {
        appStore.setLoading(false);
        throw e;
      });
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    // print("This is categoryPlaces ${dashboardResponse!.categoryPlaces }");
    return dashboardResponse != null
        ? ListView(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            children: [
              HomeCategoryWidget(dashboardResponse!.categoryPlaces ?? []),
              if ((dashboardResponse!.nearByPlaces ?? []).isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headingWidget(
                        language.nearByPlaces +
                            '\t(${getDoubleAsync(NEAR_BY_PLACE_DISTANCE)} ${language.km})',
                        () {
                      ViewAllScreen(
                              name: language.nearByPlaces,
                              placesType: placesTypeNearBy)
                          .launch(context);
                    }),
                    HorizontalList(
                        padding: EdgeInsets.all(16),
                        spacing: 12,
                        itemCount: dashboardResponse!.nearByPlaces!.length,
                        itemBuilder: (context, index) {
                          PlaceModel place =
                              dashboardResponse!.nearByPlaces![index];
                          return placesComponent(place, context, () {
                            appStore.addRemoveFavouriteData(
                                context, place.id.validate());
                            setState(() {});
                          });
                        })
                  ],
                ),
              4.height,
              if ((dashboardResponse!.latestPlaces ?? []).isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headingWidget(language.latestPlaces, () {
                      ViewAllScreen(name: language.latestPlaces)
                          .launch(context);
                    }),
                    HorizontalList(
                        padding: EdgeInsets.all(16),
                        spacing: 12,
                        itemCount: dashboardResponse!.latestPlaces!.length,
                        itemBuilder: (context, index) {
                          PlaceModel place =
                              dashboardResponse!.latestPlaces![index];
                          return placesComponent(place, context, () {
                            appStore.addRemoveFavouriteData(
                                context, place.id.validate());
                            setState(() {});
                          });
                        })
                  ],
                ),
              4.height,
              if ((dashboardResponse!.popularPlaces ?? []).isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headingWidget(language.popularPlaces, () {
                      ViewAllScreen(
                              name: language.popularPlaces,
                              placesType: placesTypePopular)
                          .launch(context);
                    }),
                    HorizontalList(
                        padding: EdgeInsets.all(16),
                        spacing: 12,
                        itemCount: dashboardResponse!.popularPlaces!.length,
                        itemBuilder: (context, index) {
                          PlaceModel place =
                              dashboardResponse!.popularPlaces![index];
                          return placesComponent(place, context, () {
                            appStore.addRemoveFavouriteData(
                                context, place.id.validate());
                            setState(() {});
                          });
                        })
                  ],
                )
            ],
          )
        : appStore.isLoading
            ? loaderWidget()
            : emptyWidget();
  }
}
