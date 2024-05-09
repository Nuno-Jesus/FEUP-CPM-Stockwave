import 'package:flutter/material.dart';
import 'package:stockwave/views/one_company_view.dart';
import 'package:stockwave/views/two_company_view.dart';

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
  List<int> selectedIndexes = [];

  @override
  Widget build(BuildContext context){
    List<String> companies  = ['AAPL', 'MSFT', 'GOOGL', 'AMZN', 'TSLA', 'FB', 'NVDA', 'PYPL', 'ADBE', 'INTC'];


    return Scaffold(
      appBar: AppBar(
        title: const Text('Company List'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(companies[index]),
            onTap: () {
              setState(() {
                if (selectedIndexes.contains(index)) {
                  selectedIndexes.remove(index);
                } else if (selectedIndexes.length < 2){
                  selectedIndexes.add(index);
                }
              });
            },
            selected: selectedIndexes.contains(index),
            selectedTileColor: Colors.blue.withOpacity(0.5),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if (selectedIndexes.isEmpty) {
            return ;
          }
          else if (selectedIndexes.length == 1) {
            Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => OneCompanyView(
                  onToggleTheme: widget.onToggleTheme,
                  chosenCompanySymbol: companies[selectedIndexes[0]],
                ),
              ),
            );
          }
          else if (selectedIndexes.length == 2) {
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