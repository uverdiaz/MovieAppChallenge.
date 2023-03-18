import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/ movieDetail/ movieDetail.dart';
import 'movies.dart';
class modelItemMovie extends StatelessWidget {
  Movies movie;
  double rating;
  modelItemMovie(
      this.movie,
      this.rating
      );
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
                  MovieDetailScreen(movie),
            ),
          );
            },
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl:
                'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 158,
                    height: 195,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
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
                movie.title,
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
                      padding: EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.star,
                        color: rating < 2
                            ? Colors.grey
                            : Colors.yellow,
                        size: 15,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.star,
                        color: rating < 4
                            ? Colors.grey
                            : Colors.yellow,
                        size: 15,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.star,
                        color: rating < 6
                            ? Colors.grey
                            : Colors.yellow,
                        size: 15,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.star,
                        color: rating < 8
                            ? Colors.grey
                            : Colors.yellow,
                        size: 15,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.star,
                        color: rating < 9.6
                            ? Colors.grey
                            : Colors.yellow,
                        size: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  movie.voteAverage,
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