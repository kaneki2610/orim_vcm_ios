import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/entities/category/categories_model.dart';
import 'package:orim/model/app_config/AppConfigModel.dart';

class HelperViewModel extends BaseViewModel<AppConfigModel> {
  AppConfigModel appConfigModel = AppConfigModel();
  List<CategoriesModel> categories = [];

  Future<LatLng> getPositionDefault() async {
    return appConfigModel.locationDefault;
  }

  Future<void> saveCategoryIcons(List<CategoriesModel> list) async {
    this.categories = list;
  }
}
