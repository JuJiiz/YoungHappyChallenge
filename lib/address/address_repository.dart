import 'package:younghappychallenge/address/country_entity.dart';
import 'package:younghappychallenge/core/result.dart';

abstract class AddressRepository {
  Future<Result<List<CountryEntity>>> requestCountry();
}
