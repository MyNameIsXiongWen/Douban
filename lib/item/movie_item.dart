import 'package:flutter/material.dart';
import 'package:hhh/model/movie_model.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: FadeInImage.assetNetwork(placeholder: 'images/placeholder.png', image: movie.picUrl, fit: BoxFit.fill,),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 30,
                height: 30,
                color: Colors.grey,
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(4), bottomRight: Radius.circular(4)),
                  child: Image.asset('images/collect.png', height: 20),
                )
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
          child: Text(
              movie.movieName,
              style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '暂无评分',
          style: TextStyle(color: Colors.grey, fontSize: 10.0),
        )
      ],
    );
  }
}