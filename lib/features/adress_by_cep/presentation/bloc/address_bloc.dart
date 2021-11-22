import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cep_study/core/error/failures.dart';
import 'package:flutter_cep_study/core/utils/input_validator.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/entities/address.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/usecases/get_address_by_cep.dart';

part 'address_event.dart';
part 'address_state.dart';


//todo localize
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

const String INVALIDE_INPUT_FAILURE_MESSAGE = 'Invalid input';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GetAddressByCep getAddress;
  final InputValidator validator;

   

  AddressBloc({required this.getAddress, required this.validator}) : super(EmptyState()) {
    on<AddressEvent>((event, emit) {
      if(event is GetAddressByCepEvent){
        
        final inputEither = validator.validate(event.cepString);

        


        inputEither.fold(
          (failure){
            return ErrorState(message:INVALIDE_INPUT_FAILURE_MESSAGE);
          },
          (string) async  {
            emit(LoadingState());
            final failureOrAddress = await getAddress(Params(cep: string));

            failureOrAddress.fold(
              (failure){
                emit(ErrorState(message: _mapFailureToMessage(failure)));
              },
              (address){
                emit(LoadedState(address: address));
              }
            );

          },
        );
      }
    }); 
  }

    String _mapFailureToMessage(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }


}
