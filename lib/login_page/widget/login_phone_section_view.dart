import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:younghappychallenge/core/constants.dart';

class LoginPhoneSectionView extends StatefulWidget {
  final Function(String callingCode, String phoneNumber) onSendOTP;

  const LoginPhoneSectionView({
    Key key,
    @required this.onSendOTP,
  }) : super(key: key);

  @override
  _LoginPhoneSectionViewState createState() => _LoginPhoneSectionViewState();
}

class _LoginPhoneSectionViewState extends State<LoginPhoneSectionView> {
  final _selectedCountry = BehaviorSubject<Country>();
  final _phoneNumber = BehaviorSubject<String>();

  @override
  void initState() {
    super.initState();
    _onSelectDefaultCallingCode();
  }

  @override
  void dispose() {
    _selectedCountry.close();
    _phoneNumber.close();
    super.dispose();
  }

  _onSelectDefaultCallingCode() async {
    final country = await getDefaultCountry(context);
    _selectedCountry.sink.add(country);
  }

  _onSelectCallingCode() async {
    final country = await showCountryPickerSheet(context);
    _selectedCountry.sink.add(country);
  }

  _onSendOTP() async {
    Rx.combineLatest2(_selectedCountry, _phoneNumber,
        (Country country, String phone) {
      return {country.callingCode, phone};
    }).listen((input) => widget.onSendOTP(input.first, input.last));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      constraints: BoxConstraints(maxWidth: view_width),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: view_height,
                child: InkWell(
                  child: StreamBuilder(
                    stream: _selectedCountry,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<Country> snapshot,
                    ) {
                      if (snapshot.hasData) {
                        return Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(
                              const Radius.circular(16.0),
                            ),
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                snapshot.data.flag,
                                package: countryCodePackageName,
                                width: 16.0,
                              ),
                              Text(snapshot.data.callingCode),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          child: Row(
                            children: [
                              Text('-'),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  onTap: () => _onSelectCallingCode(),
                ),
              ),
              SizedBox(height: 8.0),
              Expanded(
                child: Container(
                  height: view_height,
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    onChanged: _phoneNumber.sink.add,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        hintText: "Type in your phone number.",
                        fillColor: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          ElevatedButton(
            child: Text('Send OTP'),
            onPressed: () => _onSendOTP(),
          ),
        ],
      ),
    );
  }
}
