import 'package:dartz/dartz.dart';
import 'package:flutter_cep_study/core/error/failures.dart';

class InputValidator{

  RegExp withHyphen = RegExp(r'\d{5}-\d{3}$');
  RegExp withoutHyphen = RegExp(r'\d{8}$');



  Either<Failure, String> validate(String str){

    if(!withHyphen.hasMatch(str) && !withoutHyphen.hasMatch(str) || (withoutHyphen.hasMatch(str) && str.length>8)) return Left(InvalidInputFailure());

    str = str.replaceAll('-', '');
    
    return Right(str);


  }

  justDebugging(){
    
  }
}

class InvalidInputFailure extends Failure {}