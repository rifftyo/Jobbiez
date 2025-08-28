import 'package:flutter/material.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/domain/usecases/job_category.dart';

class JobCategoryProvider extends ChangeNotifier {
  final JobCategory jobCategory;

  JobCategoryProvider({required this.jobCategory});

  List<String> _categories = [];
  List<String> get categories => _categories;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String? _message;
  String? get message => _message;

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  Future<List<String>> getCategories() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await jobCategory.getCategories();
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (categoriesData) {
        _state = RequestState.Loaded;
        _categories = categoriesData;
        notifyListeners();
      },
    );
    return _categories;
  }

  void changeCategory(String? value) {
    _selectedCategory = value;
    notifyListeners();
  }
}
