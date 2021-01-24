import 'package:younghappychallenge/address/address_repository.dart';
import 'package:younghappychallenge/address/country_entity.dart';
import 'package:younghappychallenge/core/base/base_controller.dart';
import 'package:younghappychallenge/core/base/base_view_event.dart';
import 'package:younghappychallenge/core/result.dart';
import 'package:younghappychallenge/register_page/model/input_user_register.dart';
import 'package:younghappychallenge/register_page/register_view_event.dart';
import 'package:younghappychallenge/user/user_repository.dart';

class RegisterController extends BaseController {
  final AddressRepository _addressRepository;
  final UserRepository _userRepository;

  RegisterController(this._addressRepository, this._userRepository);

  Future<List<CountryEntity>> requestCountries() async {
    Result<List<CountryEntity>> result =
        await _addressRepository.requestCountry();

    if (result is Success<List<CountryEntity>>) {
      return result.data;
    } else {
      return <CountryEntity>[];
    }
  }

  submitRegister(InputUserRegister input) async {
    setViewState(OperatingViewState());

    final Result result = await _userRepository.requestRegisterUser(input);
    if (result is Success) {
      setViewState(RegisterViewEvent());
    } else {
      final String message = (result as Failure).message;
      setViewState(ErrorViewState(message));
    }
  }

  @override
  dispose() {}

  @override
  init() {}
}
