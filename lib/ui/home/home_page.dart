import 'package:flutter/material.dart';
import 'package:flutter_book_search_app/ui/home/home_veiw_model.dart';
import 'package:flutter_book_search_app/ui/home/widgets/home_bottom_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  //텍스트필드 컨트롤러
  //dispose를 반드시 호출해야하는데 그럼 stateless >statfull로 바꿔야함

  @override
  void dispose() {
    //dispose 불러오면 자동으로 오버라이드 됨
    //textEditingController 사용시에는 반드시 dispose를 호출해줘야 메모리에서 소거됨.
    textEditingController.dispose(); //재정의시 원래 dispose를 호출해야 한다.
    super.dispose();
  }

  void onSearch(String text) {
    //Todo 홈뷰모델의 searchBooks 메서드 호출
    ref.read(homeViewModelProvider.notifier).searchBooks(text);
    print("onSearch 호출됨");
  }

  //검색 함수
  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);

    return GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); //키보드 외 영역 탭시 '포커스 해지'를 위해 Gesture로 감싸기
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              GestureDetector(
                onTap: () {
                  onSearch(
                      textEditingController.text); //위에 정의한 onSearch 함수를 실행한다는 뜻
                },
                child: Container(
                  //아이콘 터치 영역 만들기위해 컨테이너 씌움
                  width: 48,
                  height: 48,
                  color: Colors.transparent, //아이콘에 투명도를 주면 영역 전체에 터치 이벤트가 걸림
                  child: Icon(Icons.search),
                ),
              ),
            ],
            title: TextField(
              maxLines: 1,
              onSubmitted: onSearch, //키보드의 완료 버튼 클릭시 서치 함수 실행되도록 함//키보드에서 필요
              controller:
                  textEditingController, //컨트롤러 속성 값에 위에서 선언한 textEditingController 불러오기
              decoration: InputDecoration(
                  hintText: "검색어를 입력해주세요",
                  border: MaterialStateOutlineInputBorder.resolveWith(
                    (states) {
                      if (states.contains(WidgetState.focused)) {
                        //
                        return OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        );
                      }
                      return OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      );
                    },
                  )),
            ),
          ),
          body: GridView.builder(
            padding: EdgeInsets.all(20),
            itemCount: homeState.books.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final book = homeState.books[index];
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return HomeBottomSheet(book);
                    },
                  );
                },
                child: Image.network(book.image),
              );
            },
          ),
        ));
  }
}
