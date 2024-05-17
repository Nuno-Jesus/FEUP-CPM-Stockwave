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
    List<MapEntry<String, List<dynamic>>> companiesList = companies.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stockwave'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // title: Text('Help'),
                  icon: Icon(Icons.info_outline, color: Theme.of(context).colorScheme.onBackground),
                  content: Text('Select at most 2 companies to analyse.'),
                );
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(currentIcon),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 1,
        crossAxisSpacing: 10,
        childAspectRatio: 45/9,
        children: [
          for (int index = 0; index < companiesList.length; index++)
              ListTile(
                tileColor: Theme.of(context).colorScheme.background,
                leading: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(0, 0, 0, 0.17)
                  ),
                  child: Image(
                    image: AssetImage('assets/logos/${companiesList[index].key}.png'),
                    width: 50,
                    height: 50,
                  ),
                ),
                title: Text(companiesList[index].key, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(companiesList[index].value[0], overflow: TextOverflow.ellipsis),
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
                selectedTileColor: Theme.of(context).colorScheme.tertiary,
              ),
          const SizedBox(),
        ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 50,
        child: Visibility(
          visible: selectedCompanies.isNotEmpty,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            tooltip: 'Submit companies into analysis.',
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
            child: const Text('Analyse',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)
            ),
          ),
        ),
      ),
    );
  }
}