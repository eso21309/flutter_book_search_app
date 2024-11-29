// 주석처리 단축키 : 커멘드+?

// {
//       "title": "Harry",
//       "link": "https://search.shopping.naver.com/book/catalog/32534728678",
//       "image": "https://shopping-phinf.pstatic.net/main_3253472/32534728678.20220523045017.jpg",
//       "author": "",
//       "discount": "65600",
//       "publisher": "Authorhouse",
//       "pubdate": "20181108",
//       "isbn": "9781546292463",
//       "description": "Set in the 1980s, Harry is a young girl who, overnight, turned from a chrysalis into a butterfly. Harry finds love and fame whilst on a family holiday in Spain."
//     },

class Book {
  String title;
  String link;
  String image;
  String author;
  String discount;
  String publisher;
  String pubdate;
  String isbn;
  String description;

  Book({
    required this.title,
    required this.link,
    required this.image,
    required this.author,
    required this.discount,
    required this.publisher,
    required this.pubdate,
    required this.isbn,
    required this.description,
  });

  //1. fromJason 네임드 생성자 만들기
  Book.fromJson(Map<String, dynamic> map)
      : this(
          title: map["title"],
          link: map["link"],
          image: map["image"],
          author: map["author"],
          discount: map["discount"],
          publisher: map["publisher"],
          pubdate: map["pubdate"],
          isbn: map["isbn"],
          description: map["description"],
        );

  //2. toJason 메서드 만들기
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "link": link,
      "image": image,
      "author": author,
      "discount": discount,
      "publisher": publisher,
      "pubdate": pubdate,
      "isbn": isbn,
      "description": description,
    };
  }
}
