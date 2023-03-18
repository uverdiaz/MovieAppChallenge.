import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../model/movieReview.dart';

class modelItemMovieReview extends StatefulWidget {
  MovieReview movie;
  double rating;

  modelItemMovieReview(this.movie, this.rating);

  @override
  State<modelItemMovieReview> createState() => _modelItemMovieReviewState();
}

class _modelItemMovieReviewState extends State<modelItemMovieReview> {
  var result = '';
  var avatarPath = '';

  @override
  void initState() {
    super.initState();
    if (widget.movie.avatarPath.toString() != 'null') {
      avatarPath = widget.movie.avatarPath.toString();
      result = widget.movie.avatarPath.substring(1, 3);
    } else {
      avatarPath = '/yHGV91jVzmqpFOtRSHF0avBZmPm.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF03182C),
                    radius: 30,
                    child: result == 'ht'
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(avatarPath.substring(1)),
                            radius: 28,
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://image.tmdb.org/t/p/original$avatarPath'),
                            radius: 28,
                          ), //CircleAvatar
                  ),
                ],
              ), //CircleAvatar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 3, 0, 0),
                          child: Text(
                            widget.movie.author,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: '',
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 6),
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                            ),
                            Text(
                              widget.rating.toString(),
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.35,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 3, 0, 0),
                      child: ReadMoreText(
                        widget.movie.content,
                        trimLines: 4,
                        style: TextStyle(color: Colors.grey),
                        colorClickableText: Colors.blue,
                        trimMode: TrimMode.Length,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
