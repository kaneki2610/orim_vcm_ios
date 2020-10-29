import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/entities/category/category.dart';
import 'package:orim/utils/debounce.dart';
import 'package:orim/viewmodel/category.dart';
import 'package:provider/provider.dart';
import 'package:orim/base/subject.dart';

class ModalFieldBloc extends BaseBloc {
  ModalFieldBloc({
    BuildContext context,
    CategoryData categoryData,
  })  : searchController = TextEditingController(),
        super(context: context) {
    this._categoryData = categoryData;
  }

  CategoryData _categoryData;
  CategoryViewModel _categoryViewModel;
  final TextEditingController searchController;
  final Debounce _debounce = Debounce(milliseconds: 500);

  StreamSubscription<List<CategoryData>> _subscription;

  List<Field> _data;
  BehaviorSubject<List<Field>> _dataSubject = BehaviorSubject();

  Stream<List<Field>> get dataStream => _dataSubject.stream;

  BehaviorSubject<String> _categoryNameSubject = BehaviorSubject();

  Stream<String> get categoryNameStream => _categoryNameSubject.stream;

  Future<void> loadCategories() async {
    if (_categoryViewModel.data != null) {
      _data = _categoryViewModel.data.map((e) => Field(e)).toList();
    } else {
      List<CategoryData> res = await _categoryViewModel.loadData();
      _data = res.map((e) => Field(e)).toList();
    }
    _dataSubject.value = _data;
  }

  @override
  void dispose() {
    _subscription.cancel();
    _dataSubject.close();
    searchController.removeListener(_onChangeText);
    searchController.dispose();
    _categoryNameSubject.close();
  }

  void getCategory() {
    if(_categoryData != null) {
      _categoryNameSubject.value = _categoryData.name ?? "";
    }
  }

  void selecteItem(Field field, String categoryName) {
    _categoryNameSubject.value = "$categoryName - ${field.name}";
    // always have one item selected
    for (final f in _data) {
      if (f.code == field.parentCode) {
        int index = f.indexOfField(field);
        for (final fi in f.subField) {
          // remove select old
          fi.selected = false;
        }
        f.subField[index].selected = !f.subField[index].selected;
      } else {
        for (final fi in f.subField) {
          // remove select old
          fi.selected = false;
        }
      }
    }
    searchFilter();
  }

  Future<Field> itemSelected() async {
    for (final f in _data) {
      for (final field in f.subField) {
        if (field.selected) {
          return field;
        }
      }
    }
    return null;
  }

  _onChangeText() {
    _debounce.run(() async {
      searchFilter();
    });
  }

  void searchFilter() {
    if (searchController.value.text.trim() != '') {
      List<Field> dataFilter = [];
      for (int i = 0; i < _data.length; i++) {
        Field fieldParentTemp = Field.clone(_data[i]);
        fieldParentTemp.subField.clear();
        fieldParentTemp.subCategories.clear();
        dataFilter.add(fieldParentTemp);
        for (int j = 0; j < _data[i].subField.length; j++) {
          final Field field = Field.clone(_data[i].subField[j]);
          if (field.name
              .toLowerCase()
              .contains(searchController.text.trim().toLowerCase())) {
            fieldParentTemp.subField.add(field);
            fieldParentTemp.subCategories.add(field.generateCategory());
          } else {}
        }
      }
      dataFilter = dataFilter.where((e) => e.subField.length > 0).toList();
      _dataSubject.value = dataFilter;
    } else {
      _dataSubject.value = _data;
    }
  }

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    _categoryViewModel = Provider.of<CategoryViewModel>(context);
  }

  void initListener() {
    if (_subscription == null) {
      _subscription = _categoryViewModel.listener(
          onDataChange: (List<CategoryData> data) {
            _data = data.map((e) => Field(e)).toList();
            _dataSubject.value = _data;
          },
          onDone: () {},
          onError: (error) {
            print(error);
          });
    }
    searchController.addListener(_onChangeText);
  }
}

class Field extends CategoryData {
  bool selected = false;
  List<Field> subField = [];

  Field(CategoryData categoryData) {
    this.areaCode = categoryData.areaCode;
    this.code = categoryData.code;
    this.desc = categoryData.desc;
    this.flag = categoryData.flag;
    this.icon = categoryData.icon;
    this.id = categoryData.id;
    this.name = categoryData.name;
    this.orders = categoryData.orders;
    this.parentCode = categoryData.parentCode;
    this.status = categoryData.status;
    this.type = categoryData.type;

    this.subField = categoryData.subCategories.map((e) => Field(e)).toList();
  }

  int indexOfField(Field f) {
    for (final field in subField) {
      if (field.code == f.code &&
          field.id == f.id &&
          field.parentCode == f.parentCode) {
        int index = subField.indexOf(field);
        return index;
      }
    }
    return -1;
  }

  CategoryData generateCategory() {
    return CategoryData(
        areaCode: this.areaCode,
        code: this.code,
        desc: this.desc,
        flag: this.flag,
        icon: this.icon,
        id: this.id,
        name: this.name,
        orders: this.orders,
        parentCode: this.parentCode,
        status: this.status,
        type: this.type,
        subCategories: this.subCategories);
  }

  Field.clone(Field field) {
    this.areaCode = field.areaCode;
    this.code = field.code;
    this.desc = field.desc;
    this.flag = field.flag;
    this.icon = field.icon;
    this.id = field.id;
    this.name = field.name;
    this.orders = field.orders;
    this.parentCode = field.parentCode;
    this.status = field.status;
    this.type = field.type;
    this.selected = field.selected;
    this.subField = field.subField.map((e) => Field.clone(e)).toList();
  }
}
