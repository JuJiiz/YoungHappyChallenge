import 'package:younghappychallenge/address/address_repository.dart';
import 'package:younghappychallenge/address/country_entity.dart';
import 'package:younghappychallenge/core/api_service.dart';
import 'package:younghappychallenge/core/result.dart';

class AddressRepositoryImpl extends AddressRepository {
  final APIService _apiService;

  AddressRepositoryImpl(this._apiService);

  @override
  Future<Result<List<CountryEntity>>> requestCountry() async {
    final response = await _apiService.requestCountry();
    if (response.success) {
      final List<CountryEntity> countries = (response.data['countries'] as List)
          .map((e) => CountryEntity.fromJson(e))
          .toList()
            ..sort((a, b) => a.name.compareTo(b.name));

      return Success(countries);
    } else {
      return Failure(response.message);
    }
  }
}
