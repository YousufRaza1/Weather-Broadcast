import 'package:flutter/material.dart';
import 'package:weather_track/BaseModule/MainWeatherScreen/ViewModel/SearchListViewModel.dart';

class SearchListScreen extends StatefulWidget {
  final ValueChanged<String> onUpdate;

  SearchListScreen({required this.onUpdate});

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
    _initializeData(); // Separate async method
    _searchController.addListener(_filterItems);
  }

  // Separate method to handle async logic
  Future<void> _initializeData() async {
    _filteredItems = await viewModel.getAllCityName(); // Initially show all items
    setState(() {}); // Update UI after fetching data
    await viewModel.hasConnection(); // Call hasConnection after fetching city names
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() async {
    // Get the search query from the search controller
    String query = _searchController.text.toLowerCase();

    // Fetch the city names asynchronously from the view model
    List<String> cityNames = await viewModel.getAllCityName();

    // Filter the city names based on the query
    List<String> filteredList = cityNames
        .where((city) => city.toLowerCase().contains(query))
        .toList();

    // Update the filtered items and refresh the UI
    setState(() {
      _filteredItems = filteredList;
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
            icon: Icon(Icons.arrow_back)),
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
                ? Text(
              'Selected: $_selectedItem',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
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
