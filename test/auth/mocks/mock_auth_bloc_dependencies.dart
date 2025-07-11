import 'package:flutter_starter_kit/domain/usecases/auth_usecase.dart';
import 'package:flutter_starter_kit/ui/shared/service/service.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthUseCase extends Mock implements AuthUseCase {}

class MockKeyValueStorageService extends Mock
    implements KeyValueStorageService {}
