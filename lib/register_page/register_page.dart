import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:universal_html/html.dart' as html;
import 'package:younghappychallenge/address/country_entity.dart';
import 'package:younghappychallenge/core/base/base_page.dart';
import 'package:younghappychallenge/core/base/base_view_event.dart';
import 'package:younghappychallenge/core/constants.dart';
import 'package:younghappychallenge/register_page/model/birth_date_select_model.dart';
import 'package:younghappychallenge/register_page/model/gender_radio_model.dart';
import 'package:younghappychallenge/register_page/model/profile_image_model.dart';
import 'package:younghappychallenge/register_page/register_controller.dart';
import 'package:younghappychallenge/register_page/widget/country_list.dart';
import 'package:younghappychallenge/register_page/widget/gender_selector.dart';

// ignore: must_be_immutable
class RegisterPage extends BasePage<RegisterController> {
  static const routeName = '/register';

  RegisterPage(BuildContext context, RegisterController controller)
      : super(context, controller);

  final _profilePicture = BehaviorSubject<ProfileImageModel>();
  final _displayName = BehaviorSubject<String>();
  final _country = BehaviorSubject<CountryEntity>();
  final _gender = BehaviorSubject<GenderRadioModel>();
  final _birthDate = BehaviorSubject<BirthDateSelectModel>();

  List<CountryEntity> _countriesList = [];

  @override
  void onStateInit() async {
    super.onStateInit();
    controller.init();

    _countriesList = await controller.requestCountries();
  }

  @override
  void onDispose() {
    _profilePicture.close();
    _displayName.close();
    _country.close();
    _gender.close();
    _birthDate.close();

    controller.dispose();
    super.onDispose();
  }

  _showCallingCodeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: view_width,
          color: Color(0x00737373),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                width: double.infinity,
                color: Colors.lightGreen[400],
                padding: EdgeInsets.all(8),
                child: Text(
                  'เลือกสัญชาติ',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Expanded(
                child: Container(
                  child: CountryList(
                    countries: _countriesList,
                    onSelectItem: (selected) {
                      Navigator.pop(context);
                      _country.sink.add(selected);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _showDatePicker(BuildContext context) async {
    final DateTime _current = DateTime.now();
    final int _currentYear = _current.year;

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(_currentYear - 60),
      firstDate: DateTime(_currentYear - 150),
      lastDate: DateTime(_currentYear - 1),
    );

    _birthDate.sink.add(
      BirthDateSelectModel(picked.day, picked.month, picked.year),
    );
  }

  _showImagePicker() async {
    if (kIsWeb) {
      final html.InputElement input = html.document.createElement('input');
      input
        ..type = 'file'
        ..accept = 'image/*';

      input.onChange.listen((e) {
        if (input.files.isEmpty) return;
        final reader = html.FileReader()..readAsDataUrl(input.files[0]);

        reader.onLoad.first.then((res) {
          final encoded = reader.result as String;

          final stripped =
              encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');

          _profilePicture.sink
              .add(ProfileWebImageModel(base64.decode(stripped)));
        });

        reader.onError.listen(
          (err) => controller
              .setViewState(ErrorViewState('Error while retrieve picture.')),
        );
      });

      input.click();
    } else {
      final PickedFile pickedFile =
          await ImagePicker().getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _profilePicture.sink.add(ProfileMobileImageModel(pickedFile.path));
      } else {
        controller
            .setViewState(ErrorViewState('Error while retrieve picture.'));
      }
    }
  }

  @override
  Widget initUI(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: view_width,
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: StreamBuilder(
                      stream: _profilePicture.stream,
                      builder:
                          (context, AsyncSnapshot<ProfileImageModel> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data is ProfileMobileImageModel) {
                            final String path =
                                (snapshot.data as ProfileMobileImageModel).path;

                            return ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.file(
                                io.File(path),
                                height: 100.0,
                                width: 100.0,
                                fit: BoxFit.cover,
                              ),
                            );
                          } else if (snapshot.data is ProfileWebImageModel) {
                            final Uint8List data =
                                (snapshot.data as ProfileWebImageModel).data;

                            return ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.memory(
                                data,
                                height: 100.0,
                                width: 100.0,
                                fit: BoxFit.cover,
                              ),
                            );
                          } else {
                            return Image.asset(
                              'assets/ic_profile_place_holder.png',
                              height: 100.0,
                              width: 100.0,
                            );
                          }
                        } else {
                          return Image.asset(
                            'assets/ic_profile_place_holder.png',
                            height: 100.0,
                            width: 100.0,
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      InkWell(
                        onTap: _showImagePicker,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/ic_camera.png',
                              height: 24.0,
                              width: 24.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'เพิ่มรูปโปรไฟล์',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    height: view_height,
                    alignment: Alignment.center,
                    child: TextField(
                      onChanged: _displayName.sink.add,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: "กรอกชื่อผู้ใช้งาน",
                          fillColor: Colors.white70),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  InkWell(
                    onTap: () => _showCallingCodeBottomSheet(context),
                    child: Container(
                      height: view_height,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: StreamBuilder(
                        stream: _country,
                        builder:
                            (context, AsyncSnapshot<CountryEntity> snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data.nationality);
                          } else {
                            return Text('-');
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    height: view_height,
                    child: StreamBuilder(
                      stream: _gender.stream,
                      builder: (
                        context,
                        AsyncSnapshot<GenderRadioModel> snapshot,
                      ) {
                        return GenderSelector(
                          selectedItem: snapshot.data,
                          onSelectItem: _gender.sink.add,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  InkWell(
                    onTap: () => _showDatePicker(context),
                    child: Container(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      height: view_height,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StreamBuilder(
                            stream: _birthDate,
                            builder: (context,
                                AsyncSnapshot<BirthDateSelectModel> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  '${snapshot.data.dayNumber} / ${snapshot.data.monthNumber} / ${snapshot.data.yearNumber}',
                                  style: TextStyle(color: Colors.black),
                                );
                              } else {
                                return Text(
                                  'เลือกวันเกิดของคุณ',
                                  style: TextStyle(color: Colors.grey),
                                );
                              }
                            },
                          ),
                          Image.asset(
                            'assets/ic_calendar.png',
                            height: 24.0,
                            width: 24.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('บันทึก'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
