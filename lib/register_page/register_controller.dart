import 'package:younghappychallenge/address/address_repository.dart';
import 'package:younghappychallenge/address/country_entity.dart';
import 'package:younghappychallenge/core/base/base_controller.dart';
import 'package:younghappychallenge/core/result.dart';

class RegisterController extends BaseController {
  final AddressRepository _addressRepository;

  RegisterController(this._addressRepository);

  Future<List<CountryEntity>> requestCountries() async {
    Result<List<CountryEntity>> result =
        await _addressRepository.requestCountry();

    if (result is Success<List<CountryEntity>>) {
      return result.data;
    } else {
      return <CountryEntity>[];
    }
  }

  @override
  dispose() {}

  @override
  init() {}
}
