import 'package:flutter/material.dart';
import 'package:younghappychallenge/address/country_entity.dart';

class CountryList extends StatelessWidget {
  final List<CountryEntity> countries;

  final void Function(CountryEntity) onSelectItem;

  const CountryList({
    @required this.countries,
    this.onSelectItem,
  });

  @override
  Widget build(BuildContext context) {
    Widget callingListItem(CountryEntity country) => InkWell(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text(
              '\(${country.nationality}\) ${country.name}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          onTap: () => onSelectItem(country),
        );

    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (
        BuildContext context,
        int index,
      ) =>
          callingListItem(countries[index]),
    );
  }
}
