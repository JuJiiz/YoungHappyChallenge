import 'package:younghappychallenge/address/country_entity.dart';
import 'package:younghappychallenge/register_page/model/birth_date_select_model.dart';
import 'package:younghappychallenge/register_page/model/gender_radio_model.dart';
import 'package:younghappychallenge/register_page/model/profile_image_model.dart';

class InputUserRegister {
  final ProfileImageModel profilePicture;
  final String displayName;
  final CountryEntity country;
  final GenderRadioModel gender;
  final BirthDateSelectModel birthDate;

  const InputUserRegister(
    this.profilePicture,
    this.displayName,
    this.country,
    this.gender,
    this.birthDate,
  );
}
