import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/repositories/product_repo.dart';
import 'package:frontend/logic/cubits/product_cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initialize();
  }

  final _ProductRepository = ProductRepo();

  void _initialize() async {
    emit(ProductLoadingState(state.products));
    try {
      final products = await _ProductRepository.fetchAllProducts();
      emit(ProductLoadedState(products));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products));
    }
  }
}
