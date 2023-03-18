import 'package:flutter/material.dart';

import '../../model/movieReview.dart';
class modelItemMovieReview extends StatefulWidget {
  MovieReview movie;
  double rating;
  modelItemMovieReview(
      this.movie,
      this.rating
      );

  @override
  State<modelItemMovieReview> createState() => _modelItemMovieReviewState();
}

class _modelItemMovieReviewState extends State<modelItemMovieReview> {

  var result = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    result = widget.movie.avatarPath.substring(1, 2);
    print(widget.movie.avatarPath.substring(1));
    print(result=='h');
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
                    child: result == 'h' ? CircleAvatar(
                      backgroundImage: NetworkImage('${widget.movie.avatarPath.substring(1)}'),
                      radius: 28,
                    ) :CircleAvatar(
                      backgroundImage: NetworkImage('https://image.tmdb.org/t/p/original${widget.movie.avatarPath}'),
                      radius: 28,
                    )  , //CircleAvatar
                  ),
                ],
              ), //CircleAvatar
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/1.35,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(5, 3, 0, 0),
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
                    width: MediaQuery.of(context).size.width/1.35,
                    child: Padding(
                      padding:
                      const EdgeInsets.fromLTRB(5, 3, 0, 0),
                      child: Text(
                        widget.movie.content,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                    child: Center(
                      child:  Container(
                        margin:  const EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                        height: 5.0,
                        color: Colors.red,
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