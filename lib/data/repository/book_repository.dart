import 'dart:convert';

import 'package:flutter_book_search_app/data/model/book.dart';
import 'package:http/http.dart';

class BookRepository {
  //
  Future<List<Book>> searchBooks(String query) async {
    //
    final client = Client(); //클라이언트가 뭔데?
    final response = await client.get(
      Uri.parse(
          "https://openapi.naver.com/v1/search/book.json?query=$query"), //왜 why를 안알려주지?그냥 따라서 쳐보기만 하면 남는게 있을까?
      headers: {
        "X-Naver-Client-Id": "SH_LKobngDmzQH038C8p",
        "X-Naver-Client-Secret": "lRwfEyt1lt"
      },
    );
    //Get 요청시 성공 => 200
    //응답코드가 200일때 body 데이터를 jsonDecode 함수 사용해서 map으로 바꾼 뒤 List<Book>으로 반환
    //아닐때 빈 리스트로 반환

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      final items = List.from(map["items"]);
      final iterable = items.map((e) {
        return Book.fromJson(e); //도대체 무슨말을 하는건지...
      });

      final list = iterable.toList();
      return list;
    }

    return [];
  }
}
