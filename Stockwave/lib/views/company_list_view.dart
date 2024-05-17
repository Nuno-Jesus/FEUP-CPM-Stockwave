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
  IconData currentIcon = Icons.dark_mode_outlined;

  void onChangedColorTheme() {
    setState(() {
      widget.onToggleTheme();
      currentIcon = currentIcon == Icons.dark_mode_outlined
          ? Icons.light_mode
          : Icons.dark_mode_outlined;
    });
  }

  @override
  Widget build(BuildContext context){
    List<MapEntry<String, IconData>> companiesList = companies.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stockwave'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(currentIcon),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          for (int index = 0; index < companiesList.length; index++)
            ListTile(
              leading: Icon(companiesList[index].value),
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
            )
        ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 50,
        child: FloatingActionButton(
          child: Text('Analyse', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          tooltip: 'Confirms the chosen company(ies) to submit into analysis.',
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