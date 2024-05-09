import 'package:flutter/material.dart';
import 'package:stockwave/views/one_company_view.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OneCompanyView(
                    onToggleTheme: widget.onToggleTheme,
                    chosenCompanySymbol: companies[index],
                  ),
                ),
              );
            }
          );
        },
      ),
    );
  }
}