import 'package:e_commerce_app/core/view_model/get_products/get_products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<GetProductsBloc, GetProductsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return Text("Default");
                  },
                loading: () {
                  return CircularProgressIndicator();
                },
                failure: (error) {
                  return Text("Error");
                },success: (response) {
                  return Text("Success ${response[0].name}");
                },
                );
              },
            ),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<GetProductsBloc>(context)
                      .add(GetProductsEvent.getProducts());
                },
                child: Text("CAll APi"))
          ],
        ),
      ),
    );
  }
}
