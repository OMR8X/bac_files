import 'package:bac_files/features/auth/data/responses/sign_up_response.dart';
import 'package:bac_files/features/auth/domain/entites/user_data.dart';
import 'package:bac_files/features/auth/domain/requests/sign_up_request.dart';
import '../../../../core/resources/errors/failures.dart';
import '../repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase({required this.repository});

  Future<Either<Failure, SignUpResponse>> call({
    required SignUpRequest request,
  }) async {
    return await repository.signUp(request: request);
  }
}
