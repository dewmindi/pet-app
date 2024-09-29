import 'package:flutter/material.dart';

class PetList extends StatelessWidget {
  const PetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: false,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  title: const Text("",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      )),
                  background: Image.asset(
                    "assets/images/adopt.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView.builder(
              itemCount: _articles.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _articles[index];
                return Container(
                  height: 150,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text("${item.author} · ${item.postedOn}",
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icons.bookmark_border_rounded,
                              Icons.share,
                            ].map((e) {
                              return InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(e, size: 16),
                                ),
                              );
                            }).toList(),
                          )
                        ],
                      )),
                      Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(item.imageUrl),
                              ))),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Article {
  final String title;
  final String imageUrl;
  final String author;
  final String postedOn;

  Article(
      {required this.title,
      required this.imageUrl,
      required this.author,
      required this.postedOn});
}

final List<Article> _articles = [
  Article(
    title: "3 Kittens near Battaramulla",
    author: "Dasun Fernando",
    imageUrl:
        "https://t4.ftcdn.net/jpg/06/85/37/05/360_F_685370573_wWfLALjqdGVPDR2jY4CdAO7bt0hjI4mO.jpg",
    postedOn: "Yesterday",
  ),
  Article(
      title: "Wild Rabbits",
      imageUrl: "https://www.omlet.us/images/originals/rabbits_in_the_wild.jpg",
      author: "Namal Perera",
      postedOn: "4 hours ago"),
  Article(
    title: "German Shepherd Dog",
    author: "Sandun Alwis",
    imageUrl:
        "https://cdn.britannica.com/79/232779-050-6B0411D7/German-Shepherd-dog-Alsatian.jpg",
    postedOn: "2 days ago",
  ),
  Article(
    title: "White Street Puppy",
    author: "Nimesh Tharanga",
    imageUrl:
        "https://akm-img-a-in.tosshub.com/indiatoday/images/story/202303/collage_maker-15-mar-2023-02-45-pm-624-sixteen_nine.jpg?VersionId=oYu3K.vMPP0eTGvYMpB4TtjvgGU3CWyS",
    postedOn: "22 hours ago",
  ),
  Article(
    title: "Street cat",
    author: "Nimali Dias",
    imageUrl:
        "https://res.cloudinary.com/petrescue/image/upload/v1598315017/ul4uxmbk6nzyg0662920.jpg",
    postedOn: "2 hours ago",
  ),
];
