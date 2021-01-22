import 'package:flutter/material.dart';
import 'package:younghappychallenge/register_page/model/gender_radio_model.dart';

class GenderSelector extends StatelessWidget {
  final GenderRadioModel selectedItem;
  final Function(GenderRadioModel) onSelectItem;

  const GenderSelector({
    Key key,
    this.selectedItem = const GenderRadioModel(0, 'None', 'none', false),
    @required this.onSelectItem,
  }) : super(key: key);

  Widget genderItem(GenderRadioModel gender) => Container(
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: gender.isSelected ? Colors.green : Colors.white,
            ),
            padding: EdgeInsets.all(16),
            child: Text(
              gender.name,
              style: TextStyle(
                color: gender.isSelected ? Colors.white : Colors.green,
              ),
            ),
          ),
          onTap: () => onSelectItem(GenderRadioModel(
            gender.id,
            gender.name,
            gender.value,
            true,
          )),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          genderItem(GenderRadioModel(
            1,
            'Male',
            'male',
            (selectedItem?.id == 1 ?? false) ? selectedItem.isSelected : false,
          )),
          SizedBox(width: 16.0),
          genderItem(GenderRadioModel(
            2,
            'Female',
            'female',
            (selectedItem?.id == 2 ?? false) ? selectedItem.isSelected : false,
          )),
          SizedBox(width: 16.0),
          genderItem(GenderRadioModel(
            3,
            'Other',
            'other',
            (selectedItem?.id == 3 ?? false) ? selectedItem.isSelected : false,
          )),
        ],
      ),
    );
  }
}
