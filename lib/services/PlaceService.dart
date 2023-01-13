import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/Common.dart';
import '../utils/Extensions/shared_pref.dart';
import 'package:geolocator/geolocator.dart';
import '../main.dart';
import '../models/DashboardResponse.dart';
import '../models/PlaceModel.dart';
import '../utils/AppConstant.dart';
import '../utils/ModelKeys.dart';
import 'BaseService.dart';

class PlaceService extends BaseService {
  PlaceService() {
    ref = db.collection('places');
  }

  Future<DashboardResponse> getDashboardData() async {
    DashboardResponse dashboardResponse = DashboardResponse();

    List<CategoryPlaceModel> list = [];

    await categoryService.getCategories(isViewAll: false).then((categoryList) async {
      if (categoryList.isNotEmpty) {
        categoryList.forEach((category) async {
          await placeService.getHomePlacesByCategory(category.id).then((placeList) {
            if (placeList.isNotEmpty) {
              list.add(CategoryPlaceModel(category: category, places: placeList));
            }
          });
        });
      }
    });
    dashboardResponse.latestPlaces = await placeService.latestPlaces();
    dashboardResponse.popularPlaces = await placeService.popularPlaces();
    dashboardResponse.categoryPlaces = list;
    if (appStore.currentPosition != null) {
      dashboardResponse.nearByPlaces = await placeService.nearByPlaces(appStore.currentPosition!);
    }
    return dashboardResponse;
  }

  Future<List<PlaceModel>> fetchPlaceList({required List<PlaceModel> list, String? catId, String? stateId, bool isPopular = false}) async {
    Query query;
    QuerySnapshot querySnapshot;

    if (catId != null) {
      query = ref!.where(CommonKeys.status, isEqualTo: 1).where(PlaceKeys.categoryId, isEqualTo: catId).orderBy(CommonKeys.createdAt, descending: true);
    } else if (stateId != null) {
      query = ref!.where(CommonKeys.status, isEqualTo: 1).where(PlaceKeys.stateId, isEqualTo: stateId).orderBy(CommonKeys.createdAt, descending: true);
    } else if (isPopular) {
      query = ref!.where(CommonKeys.status, isEqualTo: 1).orderBy(PlaceKeys.rating, descending: true);
    } else {
      query = ref!.where(CommonKeys.status, isEqualTo: 1).orderBy(CommonKeys.createdAt, descending: true);
    }

    if (list.isEmpty) {
      querySnapshot = await query.limit(perPageLimit).get();
    } else {
      querySnapshot = await query.startAfterDocument(await ref!.doc(list[list.length - 1].id).get()).limit(perPageLimit).get();
    }
    List<PlaceModel> data = querySnapshot.docs.map((e) => PlaceModel.fromJson(e.data() as Map<String, dynamic>)).toList();

    return data;
  }

  Future<List<PlaceModel>> getFavouritePlaces() async {
    if (appStore.favouriteList.isNotEmpty) {
      Query query = ref!.where(CommonKeys.status, isEqualTo: 1).where(CommonKeys.id, whereIn: appStore.favouriteList).orderBy(CommonKeys.updatedAt, descending: true);

      return await query.get().then((x) {
        return x.docs.map((y) => PlaceModel.fromJson(y.data() as Map<String, dynamic>)).toList();
      });
    } else {
      return [];
    }
  }

  Future<List<PlaceModel>> getHomePlacesByCategory(String? catId) {
    return ref!
        .where(CommonKeys.status, isEqualTo: 1)
        .where(PlaceKeys.categoryId, isEqualTo: catId)
        .orderBy(CommonKeys.createdAt, descending: true)
        .limit(homePlaceLimit)
        .get()
        .then((value) => value.docs.map((e) => PlaceModel.fromJson(e.data() as Map<String, dynamic>)).toList());
  }

  Future<List<PlaceModel>> latestPlaces() {
    return ref!
        .where(CommonKeys.status, isEqualTo: 1)
        .orderBy(CommonKeys.createdAt, descending: true)
        .limit(homePlaceLimit)
        .get()
        .then((event) => event.docs.map((e) => PlaceModel.fromJson(e.data() as Map<String, dynamic>)).toList());
  }

  Future<List<PlaceModel>> popularPlaces() {
    return ref!.where(CommonKeys.status, isEqualTo: 1).orderBy(PlaceKeys.rating, descending: true).limit(homePlaceLimit).get().then((event) => event.docs.map((e) => PlaceModel.fromJson(e.data() as Map<String, dynamic>)).toList());
  }

  Future<List<PlaceModel>> nearByPlaces(Position position, {bool isViewAll = false, String? catId,double? distance}) async {
    List<PlaceModel> list = [];
    QuerySnapshot querySnapshot;

    if (catId != null) {
      querySnapshot = await ref!.where(PlaceKeys.categoryId, isEqualTo: catId).get();
    } else {
      querySnapshot = await ref!.get();
    }
    List<PlaceModel> data = querySnapshot.docs.map((e) => PlaceModel.fromJson(e.data() as Map<String, dynamic>)).toList();

    if (data.isNotEmpty) {
      data.forEach((element) {
        if (calculateDistanceKm(position.latitude, position.longitude, element.latitude, element.longitude) <= (distance ?? getDoubleAsync(NEAR_BY_PLACE_DISTANCE))) {
          if (isViewAll || list.length < homePlaceLimit) {
            list.add(element);
          }
        }
      });
    }

    return list;
  }

  Future<List<PlaceModel>> searchPlaces(String? caseSearch) {
    return ref!
        .where(CommonKeys.status, isEqualTo: 1)
        .where(PlaceKeys.caseSearch, arrayContains: caseSearch)
        .orderBy(CommonKeys.createdAt, descending: true)
        .get()
        .then((event) => event.docs.map((e) => PlaceModel.fromJson(e.data() as Map<String, dynamic>)).toList());
  }
}
