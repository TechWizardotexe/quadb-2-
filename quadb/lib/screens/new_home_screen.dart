import 'package:flutter/material.dart';
import 'package:quadb/screens/new_search_screen.dart';
import 'package:quadb/services/api_services.dart';

import '../models/movie.dart';
import 'details_screen.dart';

class HomeScreen2 extends StatelessWidget {
  final ApiService apiService = ApiService();

  HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF363636),
      appBar: AppBar(
        backgroundColor: Color(0xFF363636),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen2()));
              },
              icon: Icon(
                Icons.search,
                color: Color(0xFFBDB7AB),
              )),
        ],
        title: Text(
          'Movies',
          style: TextStyle(
            color: Colors.redAccent,
          ),
        ),
      ),
      body: FutureBuilder(
        future: apiService.fetchMovies('all'), // Corrected method name
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Movie> movies = (snapshot.data as List<Movie>?) ?? [];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movieIndex = index % movies.length;

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
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
                                              builder: (context) =>
                                                  DetailsScreen(
                                                      movie:
                                                          movies[movieIndex])));
                                    },
                                    child: Image.network(
                                        movies[movieIndex].imageUrl))),
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
                                    flex: 3,
                                    child: Text(
                                      movies[movieIndex].title,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.redAccent),
                                    )),
                                Expanded(
                                    flex: 24,
                                    child: Text(
                                      movies[movieIndex].summary,
                                      style:
                                          TextStyle(color: Color(0xFFBDB7AB)),
                                    )),
                                Expanded(child: SizedBox())
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            );
          }
        },
      ),
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
              MaterialPageRoute(builder: (context) => SearchScreen2()),
            );
          }
        },
      ),
    );
  }
}
