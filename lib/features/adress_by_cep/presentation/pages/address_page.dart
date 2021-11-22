import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/entities/address.dart';
import 'package:flutter_cep_study/features/adress_by_cep/presentation/bloc/address_bloc.dart';
import 'package:flutter_cep_study/features/adress_by_cep/presentation/widgets/address_display.dart';
import 'package:flutter_cep_study/features/adress_by_cep/presentation/widgets/cep_input.dart';
import 'package:flutter_cep_study/injection_container.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddressPage extends StatelessWidget {
  AddressPage({Key? key}) : super(key: key);

  final TextEditingController cepController = TextEditingController();

  void search(BuildContext context) {
    BlocProvider.of<AddressBloc>(context)
        .add(GetAddressByCepEvent(cepController.text));
  }

  // States
  Widget _getLoadedBody(Address address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AddressDisplay(address: address),
        ),
        CepInput(controller: cepController, submit: search),
      ],
    );
  }

  Widget _getLoadingBody() {
    return Builder(builder: (context) {
      return Center(
        child: SpinKitCircle(
          color: Theme.of(context).primaryColor,
          size: 150.0,
        ),
      );
    });
  }

  Widget _getEmptyBody() {
    return Center(
      child: CepInput(controller: cepController, submit: search),
    );
  }

  Widget _getErrorBody(String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$message"),
        CepInput(controller: cepController, submit: search),
      ],
    );
  }

  BlocProvider<AddressBloc> buildBody() {
    return BlocProvider.value(
      value: sl.get<AddressBloc>(),
      child: Container(
        child: BlocBuilder<AddressBloc, AddressState>(
          builder: (BuildContext context, state) {
            if (state is LoadingState) return _getLoadingBody();
            if (state is LoadedState) return _getLoadedBody(state.address);
            if (state is ErrorState) return _getErrorBody(state.message);
            return _getEmptyBody();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
      ),
      body: buildBody(),
    );
  }
}
