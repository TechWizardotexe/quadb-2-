import 'package:flutter/material.dart';
import 'package:quadb/screens/details_screen.dart';
import 'package:quadb/screens/new_home_screen.dart';
import 'package:quadb/services/api_services.dart';
import '../models/movie.dart';

class SearchScreen2 extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen2> {
  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();
  List<Movie> _searchResults = [];

  _onSearchSubmitted(String query) async {
    if (query.isNotEmpty) {
      List<Movie> results = await _apiService.fetchMovies(query);
      setState(() {
        _searchResults = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF363636),
      appBar: AppBar(
        backgroundColor: Color(0xFF363636),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: TextField(
          style: TextStyle(color: Colors.redAccent),
          controller: _searchController,
          decoration: InputDecoration(
              hintText: 'Search Movies',
              hintStyle: TextStyle(color: Color(0xFFBDB7AB))),
          onSubmitted: _onSearchSubmitted,
        ),
      ),
      body: _searchResults.isEmpty
          ? Center(
              child: Text('No results found',
                  style: TextStyle(color: Colors.redAccent)),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF363636),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsScreen(
                                              movie: _searchResults[index])));
                                },
                                child: Image.network(
                                    _searchResults[index].imageUrl))),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(flex: 5, child: SizedBox()),
                            Expanded(
                                flex: 5,
                                child: Text(
                                  _searchResults[index].title,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.redAccent),
                                )),
                            Expanded(
                              flex: 25,
                              child: Text(
                                _searchResults[index].summary,
                                style: TextStyle(
                                  color: Color(
                                    0xFFBDB7AB,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF363636),
        unselectedItemColor: Color(0xFFbdb7ab),
        selectedItemColor: Colors.redAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen2()),
            );
          }
        },
      ),
    );
  }
}
