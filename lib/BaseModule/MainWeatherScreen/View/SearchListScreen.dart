
import 'package:flutter/material.dart';
import 'package:weather_track/BaseModule/MainWeatherScreen/ViewModel/SearchListViewModel.dart';
class SearchListScreen extends StatefulWidget {
  final ValueChanged<String> onUpdate;
  SearchListScreen({ required this.onUpdate});
  @override
  _SearchListScreenState createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  TextEditingController _searchController = TextEditingController();

  final viewModel = SearchListViewModel();
  List<String> _filteredItems = [];
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _filteredItems = viewModel.getAllCityName(); // Initially show all items
    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      _filteredItems = viewModel.getAllCityName()
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search and Select City'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16),
            _selectedItem != null
                ? Text('Selected: $_selectedItem',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ))
                : Container(),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredItems[index]),
                    onTap: () {
                      widget.onUpdate(_filteredItems[index]);
                      setState(() {
                        _selectedItem = _filteredItems[index];
                      });

                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}