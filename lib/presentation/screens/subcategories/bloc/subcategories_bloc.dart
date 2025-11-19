import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_images.dart';
import 'subcategories_event.dart';
import 'subcategories_state.dart';

class SubCategoriesBloc extends Bloc<SubCategoriesEvent, SubCategoriesState> {
  SubCategoriesBloc() : super(SubCategoriesInitial()) {
    on<LoadSubCategoriesEvent>(_onLoadSubCategories);
  }

  Future<void> _onLoadSubCategories(
    LoadSubCategoriesEvent event,
    Emitter<SubCategoriesState> emit,
  ) async {
    emit(SubCategoriesLoading());

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data - Replace with actual API call
    final subCategories = _getSubCategoriesForCategory(event.categoryId);

    if (subCategories.isEmpty) {
      emit(const SubCategoriesError('No subcategories found'));
    } else {
      emit(
        SubCategoriesLoaded(
          categoryTitle: _getCategoryTitle(event.categoryId),
          subCategories: subCategories,
        ),
      );
    }
  }

  String _getCategoryTitle(String categoryId) {
    // Return category title based on ID
    final titles = {
      '1': 'Wire',
      '2': 'Cable',
      '3': 'Accessories',
      '4': 'Submersible Cable',
      '5': 'Contactor',
      '6': 'General Purpose',
    };
    return titles[categoryId] ?? 'Sub Categories';
  }

  List<Map<String, String>> _getSubCategoriesForCategory(String categoryId) {
    // Mock subcategories data
    return [
      {
        'id': '1',
        'image': AppImages.contactorCategory,
        'title': 'CONTACTOR\n(230V - 400V)',
      },
      {
        'id': '2',
        'image': AppImages.generalCategory,
        'title': 'GENERAL PURPOSE',
      },
      {'id': '3', 'image': AppImages.wireCategory, 'title': 'SURFIX'},
      {'id': '4', 'image': AppImages.cableCategory, 'title': 'ARMOURED'},
      {
        'id': '5',
        'image': AppImages.accessoriesCategory,
        'title': 'ACCESSORIES',
      },
      {
        'id': '6',
        'image': AppImages.submersibleCategory,
        'title': 'SUBMERSIBLE CABLE',
      },
    ];
  }
}
