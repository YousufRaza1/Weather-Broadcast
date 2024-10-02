// import 'package:flutter/material.dart';
//
//
// class Homescreen extends StatefulWidget {
//   const Homescreen({super.key});
//
//   @override
//   State<Homescreen> createState() => _HomescreenState();
// }
//
// class _HomescreenState extends State<Homescreen> {
//   List<String> cityNames = [
//     'Abidjan', 'Abu Dhabi', 'Accra', 'Addis Ababa', 'Ahmedabad', 'Aleppo',
//     // Add the rest of your cities here...
//   ];
//
//   List<String> filteredCities = [];
//   String selectedCity = '';
//
//   @override
//   void initState() {
//     super.initState();
//     filteredCities = cityNames; // Initialize the filtered list with all cities.
//   }
//
//   void _filterCities(String query) {
//     List<String> results = [];
//     if (query.isEmpty) {
//       results = cityNames;
//     } else {
//       results = cityNames
//           .where((city) => city.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//
//     setState(() {
//       filteredCities = results;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(title: Text('Home Screen')),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: Colors.white,
//         child: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Search City',
//                     border: OutlineInputBorder(),
//                   ),
//                   onChanged: (query) => _filterCities(query),
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: filteredCities.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(filteredCities[index]),
//                       onTap: () {
//                         setState(() {
//                           selectedCity = filteredCities[index];
//                         });
//                         _showCitySelection(context, selectedCity);
//                       },
//                     );
//                   },
//                 ),
//               ),
//               if (selectedCity.isNotEmpty)
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Selected City: $selectedCity',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   void _showCitySelection(BuildContext context, String city) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('City Selected'),
//         content: Text('You selected $city'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
// class CitySearchScreen extends StatefulWidget {
//   @override
//   _CitySearchScreenState createState() => _CitySearchScreenState();
// }
//
// class _CitySearchScreenState extends State<CitySearchScreen> {
//   List<String> cityNames = [
//     'Abidjan', 'Abu Dhabi', 'Accra', 'Addis Ababa', 'Ahmedabad', 'Aleppo',
//     // Add the rest of your cities here...
//   ];
//
//   List<String> filteredCities = [];
//   String selectedCity = '';
//
//   @override
//   void initState() {
//     super.initState();
//     filteredCities = cityNames; // Initialize the filtered list with all cities.
//   }
//
//   void _filterCities(String query) {
//     List<String> results = [];
//     if (query.isEmpty) {
//       results = cityNames;
//     } else {
//       results = cityNames
//           .where((city) => city.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//
//     setState(() {
//       filteredCities = results;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search City'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 labelText: 'Search City',
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (query) => _filterCities(query),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredCities.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(filteredCities[index]),
//                   onTap: () {
//                     setState(() {
//                       selectedCity = filteredCities[index];
//                     });
//                     _showCitySelection(context, selectedCity);
//                   },
//                 );
//               },
//             ),
//           ),
//           if (selectedCity.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Selected City: $selectedCity',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   void _showCitySelection(BuildContext context, String city) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('City Selected'),
//         content: Text('You selected $city'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }