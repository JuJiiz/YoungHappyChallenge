import 'package:younghappychallenge/testing_repository.dart';
import 'package:younghappychallenge/core/api_service.dart';
import 'package:younghappychallenge/core/result.dart';

class TestingRepositoryImpl extends TestingRepository {
  final APIService _apiService;

  TestingRepositoryImpl(APIService apiService) : _apiService = apiService;

  @override
  Future<Result<String>> requestBuilderName() {
    return _apiService.requestBuilderName();
  }
}
