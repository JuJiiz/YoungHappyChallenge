import 'package:meta/meta.dart';

class RequestRegisterUser {
  RequestRegisterUser({
    @required this.displayName,
    @required this.imageURL,
    @required this.dateOfBirth,
    @required this.countryID,
    @required this.gender,
    this.firstName,
    this.lastName,
    this.address,
    this.city,
    this.zipCode,
    //this.appleEmail,
  });

  String displayName;
  String firstName;
  String lastName;
  String imageURL;
  DateTime dateOfBirth;
  int countryID;
  String gender;
  String address;
  String city;
  String zipCode;

  //String appleEmail;

  Map<String, dynamic> toJson() => {
        "display_name": displayName,
        "first_name": firstName ?? '',
        "last_name": lastName ?? '',
        "date_of_birth": dateOfBirth.toIso8601String(), //"1950-11-30T17:00:00Z"
        "country_id": countryID,
        "gender": gender,
        "address": address ?? '',
        "city": city ?? '',
        "zipcode": zipCode ?? '',
        "image_url": imageURL ?? '',
        //"apple_email": appleEmail,
      };
}
