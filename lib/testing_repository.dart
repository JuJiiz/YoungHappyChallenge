import 'package:younghappychallenge/core/result.dart';

abstract class TestingRepository {
  Future<Result<String>> requestBuilderName();
}
