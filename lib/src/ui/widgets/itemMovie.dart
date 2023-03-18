import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../movieDetail/movieDetail.dart';
import '../../model/movies.dart';
class modelItemMovie extends StatefulWidget {
  Movies movie;
  double rating;
  modelItemMovie(
      this.movie,
      this.rating
      );

  @override
  State<modelItemMovie> createState() => _modelItemMovieState();
}

class _modelItemMovieState extends State<modelItemMovie> {
  bool addFavorite = false;
  storeData(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(id, id);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MovieDetailScreen(widget.movie),
            ),
          );
            },
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl:
                'https://image.tmdb.org/t/p/original/${widget.movie.backdropPath}',
                imageBuilder: (context, imageProvider) {
                  return Stack(
                    children: [
                      Container(
                        width: 158,
                        height: 195,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 158,
                        height: 195,
                        child:GestureDetector(
                          onTap: () {
                            storeData(widget.movie.id.toString());
                            setState(() {
                              addFavorite = !addFavorite;
                            });
                          },
                          child: Stack(
                            alignment: Alignment.topRight,
                            children:  [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 2,
                                  right: 6,
                                ),
                                child: addFavorite == false ? const Icon(Icons.favorite_border, color: Colors.white,size: 28,):
                                const Icon(Icons.favorite, color: Colors.red,size: 28,)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                placeholder: (context, url) => Container(
                  width: 158,
                  height: 195,
                  child: Center(
                    child: Platform.isAndroid
                        ? const CircularProgressIndicator()
                        : const CupertinoActivityIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 158,
                  height: 195,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/img_not_found.jpg'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: SizedBox(
              width: 158,
              child: Text(
                widget.movie.title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'muli',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(
            width: 158,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.star,
                        color: widget.rating < 2
                            ? Colors.grey
                            : Colors.yellow,
                        size: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.star,
                        color: widget.rating < 4
                            ? Colors.grey
                            : Colors.yellow,
                        size: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.star,
                        color: widget.rating < 6
                            ? Colors.grey
                            : Colors.yellow,
                        size: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.star,
                        color: widget.rating < 8
                            ? Colors.grey
                            : Colors.yellow,
                        size: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.star,
                        color: widget.rating < 9.6
                            ? Colors.grey
                            : Colors.yellow,
                        size: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.movie.voteAverage,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}