import 'package:flutter/material.dart';
import 'package:stockwave/views/one_company_view.dart';
import 'package:stockwave/views/two_company_view.dart';

import '../api.dart';

class CompanyListView extends StatefulWidget{
  const CompanyListView({
    super.key,
    required this.onToggleTheme,
  });

  final VoidCallback onToggleTheme;

  @override
  State<CompanyListView> createState() => _CompanyListViewState();
}

class _CompanyListViewState extends State<CompanyListView> {
  List<int> selectedCompanies = [];

  @override
  Widget build(BuildContext context){
    List<MapEntry<String, IconData>> companiesList = companies.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Company List'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(companiesList[index].key),
            onTap: () {
              setState(() {
                if (selectedCompanies.contains(index)) {
                  selectedCompanies.remove(index);
                } else if (selectedCompanies.length < 2){
                  selectedCompanies.add(index);
                }
              });
            },
            selected: selectedCompanies.contains(index),
            selectedTileColor: Colors.blue.withOpacity(0.5),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if (selectedCompanies.isEmpty) {
            return ;
          }
          else if (selectedCompanies.length == 1) {
            Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => OneCompanyView(
                  onToggleTheme: widget.onToggleTheme,
                  chosenCompanySymbol: companiesList[selectedCompanies[0]].key,
                ),
              ),
            );
          }
          else if (selectedCompanies.length == 2) {
            Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => TwoCompanyView(
                  onToggleTheme: widget.onToggleTheme,
                  first: {},
                  second: {},
                ),
              ),
            );
          }

        },
      ),
    );
  }
}

// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => OneCompanyView(
// onToggleTheme: widget.onToggleTheme,
// chosenCompanySymbol: companies[index],
// ),
// ),
// );