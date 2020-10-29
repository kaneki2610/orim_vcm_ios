import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/category_execute_model.dart';

class CategoryExecuteViewModel extends BaseViewModel<List<CategoryExecuteModel>> {
  List<CategoryExecuteModel> _categories = [
    CategoryExecuteModel(
      id: 13,
      code: 'CX',
      name: 'Xử lý',
    ),
    CategoryExecuteModel(
      id: 33,
      code: 'RAC',
      name: 'Tin rác',
    ),
    CategoryExecuteModel(
      id: 20,
      code: 'HT',
      name: 'Cần hỗ trợ',
    ),
    CategoryExecuteModel(
      id: 43,
      code: 'NKV',
      name: 'Ngoài khu vực xử lý',
    )
  ];

  Future<List<CategoryExecuteModel>> getCategoriesExecute() async {
    data = _categories;
    return data;
  }
}
