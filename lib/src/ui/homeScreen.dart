import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/src/ui/search/search.dart';
import 'package:untitled1/src/ui/startPage/startPage.dart';
import '../bloc/moviesBloc/movieBloc.dart';
import '../bloc/moviesBloc/movieEvent.dart';
import 'favorites/favorites.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;
  String pageActive = 'Seeri-Movie';

  getItemWidget(int pos) {
    switch (pos) {
      case 0:
        pageActive = 'Seeri-Movie';
        return const StartPage();
      case 1:
        pageActive = 'Search';
        return const Search();
      case 2:
        pageActive = 'Favorites';
        return const Favorites();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc()..add(const MovieEventStarted(0, '')),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF161616),
          elevation: 0,
          actions: [
            selectedIndex != 1
                ? Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.account_circle, size: 32),
                    ),
                  )
                : Container(),
          ],
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              pageActive,
              style: const TextStyle(color: Colors.white, fontSize: 28),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child:Column(
            children: [
              getItemWidget(selectedIndex)
            ],
          ),
        ),
        backgroundColor: const Color(0xFF161616),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          backgroundColor: const Color(0xFF030303),
          selectedFontSize: 15,
          unselectedFontSize: 15,
          selectedItemColor: const Color(0xFF1377E4),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items:  [
            const BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.home,
              ),
            ),
            const BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.search,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: selectedIndex == 2 ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border,),
            ),
          ],
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              getItemWidget(index);
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

