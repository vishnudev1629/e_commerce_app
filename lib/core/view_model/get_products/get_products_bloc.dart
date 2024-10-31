import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/Models/get_product/get_product.dart';
import 'package:e_commerce_app/core/services/api_services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_products_event.dart';
part 'get_products_state.dart';
part 'get_products_bloc.freezed.dart';

class GetProductsBloc extends Bloc<GetProductsEvent, GetProductsState> {
  GetProductsBloc() : super(_Initial()) {
    on<_GetProducts>(
      (event, emit) async {
        emit(const GetProductsState.loading());

        try {
          final result = await ApiService().fetchProducts();

          print(result.toString());
          await result.fold((failure) async {
            emit(GetProductsState.failure(failure.toString()));
          }, (success) async {
            emit(GetProductsState.success(success));
          });
        } catch (e) {
          emit(GetProductsState.failure('An error occurred: $e'));
        }
      },
    );
  }
}
