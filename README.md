# 메모마무

### 개발 일지

<!--
| 날짜 | 완료한 부분         | 고민한 부분 | 팀빌딩 내용 | 기타 |
|------|---------------------|-------------|-------------|------|
| 0913     | - WriteVC UI 큰 부분들 완료 <br>- 페이지 뷰컨 안에 뷰컨들 들어갈 수 있도록 구조 다시 짬 ㅠㅠ   |             |             |      |
| 0914     | - DiaryVC UI<br> | - DiaryVC 안에 PageVC 적용 <br> - 데이터 스키마 다시 짜기            | - 25일까지 완성            |      |
| 0915     |                     |             |             |      |
| 0919 | |             |             |      |
| 1009 | - 순서 바꾸는 기능 수정 중.. | - 순서를 바꾸려면 OrderDate를 서로 바꿔주어야 하는데 어떻게 바꾸는게 좋은지?            |             |      |
-->


<details>
<summary>0913</summary>

**고민한 부분**
- 뷰컨 속 뷰 속 뷰컨 .. 어렵다! ㅠㅠ
    - 자잘한 내용 유아이보다 전체적인 틀부터 잡기
- container View
    - [https://www.youtube.com/watch?v=B5-1_aR20rE](https://www.youtube.com/watch?v=B5-1_aR20rE)
    - 넣을 녀석 instance vc
    - addChild
    - view.addSubview(vc.view)
    - vc.didMove(toParent: self)
    - constraints
    
    → 성공!!
    

**오류 수정**
- 버튼이 왜 안보일까 → offset 제대로 설정했나 볼 것
- 테이블뷰가 왜 안보일까 → addsubview, constraints 잘 설정했는지 볼 것!!!

**완료한 부분**
- WriteVC UI 큰 부분들 완료
- 페이지 뷰컨 안에 뷰컨들 들어갈 수 있도록 구조 다시 짬 ㅠㅠ

**팀빌딩**
- [https://wwit.design/tag/life](https://wwit.design/tag/life)
- [https://mobbin.com/browse/ios/apps?filter=appCategories.Lifestyle](https://mobbin.com/browse/ios/apps?filter=appCategories.Lifestyle)
</details>

<details>
<summary>0914</summary>
    
**팀빌딩**
- 25일까지 완성, 그 뒤로 같이 사용해보기
- 메모 앱 사용해보고 내일 공유하기

**구현한 것들**
- [x]  페이지 뷰 컨트롤러 적용
    - 페이지 뷰컨 안에 두 가지 뷰컨(투두, 다이어리)을 넣고 페이징 기능을 구현함으로써 하나의 종이와 같은 느낌을 구현했다.
- [x]  DiaryVC UI
- [x]  페이지VC 넘어가는 애니메이션 바꾸기
- [x]  스키마 다시 짜기 - list
    | objectId | date | diary |
    | --- | --- | --- |
    | 123 |  |  |
    | 234 |  |  |
    
    | objectId | todo(String) | check(Bool) | num(Int) | date |
    | --- | --- | --- | --- | --- |
    | 123 |  |  |  |  |
    | 123 |  |  |  |  |
    |  |  |  |  |  |
    
    **Todo와 Diary를 합쳐서 짤 순 없을까?**
    
    - Todo 하나에는 여러 가지 요소가 들어가야 함. (예를 들어, 순서 Int, 체크 여부 Bool, 투두 이름 String)
    - 이걸 다이어리와 합쳐서 구성하기에는 빈 공간도 많아질 거 같고 테이블이 이상해짐..
    - list - String 말고도 다른 value가 들어가야 해서 model 을 하나 더 짰는데..
    - 두 개가 엮여있는 걸로는 못 짤 듯
    - 따로 짜고, Date로 나중에 합치는 걸로..
    
    - 데이터 스키마 여러 개로 써야겠다는 결론까지 간 건 잘한듯!
    - 투두 일기 같은 유아이 - 일자에 대한 저장 잘 해야할듯!
    - 날짜 기반으로 데이터 쿼리를 통해 유아이에서 하나로 보여지는 것!!
    - 두 개 테이블로 관리하되, 하나로 어떻게 잘 보여줄수있는지 고민해야할 것
    - 포린키! 강의자료 참고
    - 업데이트할 기능에서 사용할 수도 있는 것도 데이터 스키마는 한스텝 더 먼저
</details>

<details>
<summary>0915</summary>
    
**팀빌딩**

- 팀빌딩 밤은 주3회 이상 참여하기!
- 학성님
    - 기획 바꿈
    - 남는 공간 어떻게할지??
- 지원
    - 데이터 스키마 짜기, 기획 다시 하기(캘린더, 모아보기, 각 화면 위계 등)
    - 옆으로 넘길 수 있는걸 잘 모를 수도 있을 것 같다 → 고민해봐야 할 점!
        - 책처럼 가운데를 오목하게 하기?
        - 페이지 뷰 컨트롤러 밑에 현재 위치 점 넣어서 다음 페이지가 있음을 알리기
        - 점선으로 알려주기?
- 상민님
- 윤제님
    - 테이블뷰 애니메이션 - 흐려지기
    - 캘린더 애니메이션
        - 테이블뷰도 스와이프될 수 있도록
        - 기능이 FS캘린더에 내장되어있음!
- 준혁님
    - 유아이 바뀜!
    - 익스텐션 얼럿으로 빼서 깔끔하게 사용

**고민한 부분**

- 메모 추가 기능 만들기 CRUD
    - Section 나누기
    - 키보드 올라갔다 내려가기
    - 스크롤시 키보드 내려가기
    - 엔터키 입력시 저장
    - 테이블뷰에 저장, 리로드
- 섹션1의 셀을 클릭했을 때, 섹션0의 마지막 인덱스에 셀이 추가되면서 텍스트 수정 실행되기
    - → 그럼 버튼처럼 적용하는건 어떨까?

**기획&디자인 회의**

- 캘린더 기능 추가 (메인으로 변경)
    - 사용자가 맨 처음 앱에 들어와서 보이는 화면: 그날의 투두 → 캘린더로 변경함
    - 처음에 기획했던 바는 하루에 하나씩 투두&다이어리를 작성하는 것에 집중하는 것이었는데
    1. 캘린더가 있어야 오늘의 투두&다이어리임을 확실하게 알 것
    2. 다른 날짜에 투두를 설정하기 용이함 (예를 들어, 3일 뒤 꼭 해야 할 일을 미리 적어둔다든지)
- 우측 상단 버튼 재정비
    - 플러스 버튼 추가
        - 캘린더가 메인으로 변경되면서, 새로 투두&다이어리를 작성하기 시작할 때 날짜를 탭하기보다 플러스 버튼을 주어야 사용자가 더욱 쉽게 추가할 수 있을 것으로 생각됨
    - 모아보기 버튼을 캘린더 ↔ 모아보기를 오갈 수 있는 버튼으로 기능 변경
</details>

<details>
<summary>0916</summary>

**고민한 부분**

- 기획이 수정되고 만들어야 할 페이지가 점점 늘어나면서 BaseVC의 필요성을 느끼는 중.. 일단 일일이 다 구현한 이후에 하나로 만들어서 수정하려고 한다
- 반복되는 코드가 많은 것 같다. 중간중간 코드를 고치면서 진행해보는게 좋을 듯
- 캘린더 뷰 - 위아래로 길어지는 화면이 아니므로 스크롤해도 달력이 접히지 않도록 만들었음
- 전체적인 UI를 짠 후에 진행해보기보다 한 화면의 기능을 완성하고 나서 그 다음 화면으로 가보자

<img src="https://user-images.githubusercontent.com/79574342/190837962-2d4aef5c-070e-41f9-8eb0-f9d9796f139a.png" width="148">

- UI 구조 어떻게 짤 수 있을지?
    - 화면 전체를 포함하는 테이블 뷰
    - 테이블 뷰 셀 안에 왼쪽 부분 뷰 + 오른쪽 부분 컨테이너 뷰(페이지 뷰컨(투두 + 다이어리))

**팀빌딩**

- 윤제님
    - 태그 삭제 시 nil값 들어가도록 변경
    - 태그 이름 변경되면 리스트 안에서도 다 변경
    - 같은 태그 시 토스트 띄워주기
    - 변경되지 않으면 완료버튼 눌리지 않도록
    - 드래그로 위치 변경
    컨퍼런스 포항?!
- 학성님
    - insetGrouped
    - 판넬뷰컨
- 준혁님
    - 리유저블셀 문제 - 리로드 테이블뷰, 렘에 저장하고 불러오는 부분에서 오류
- 상민님
    - uimenu 최소버전 15여도 충분!
- 재훈님
    - 날짜 설정 mindate maxdate
</details>


<details>
<summary>0917</summary>

- 메모 CRUD 적용 중
    - 텍스트뷰에 따라 셀 늘어나기 -> 오류로 시간 많이 씀 ㅜㅜ
</details>


<details>
<summary>0918</summary>

**완료한 부분**

- [x]  repository 구성
    - [x]  create
    - [x]  update
    - [x]  delete
- [x]  스크롤이 왜 끝까지 안되지?
    - [x]  높이가 다른가보다 → 높이가 전체 핸드폰 뷰 화면과 똑같음
    - [x]  컨테이너 뷰 안에 다시 넣어보자
    - [x]  테이블뷰 constraints 다시 정해줌!

**고민한 부분**

- 다른 section의 셀을 클릭해도 셀이 추가되는 문제
    - 셀 안에 넣어준 textview 의 gesture recognizer가 지워지지 않아서 계속 인식됨
    - 없애주니 해결!
- 스와이프가 두 개 들어가야 하는데, 어떻게 해결할까?
    - 투두 → 다이어리로 넘어갈 때와, 삭제 버튼을 생기게 할 때 둘 다 오른쪽으로 넘기는 제스처가 들어간다. 이를 구분하기가 어려울듯
    - 해결방법 1. 편집 버튼을 따로 두어 재정렬과 삭제를 넣는다 (제스처: 투두→다이어리에만 존재)
    - 해결방법 2. 투두 → 다이어리로 넘어갈 때 제스처로 넘기지 않고, 버튼을 눌러야만 넘어갈 수 있도록 한다. (제스처: 삭제 버튼에만 존재)
    - 해결방법 3. 텍스트 상자를 키보드 위에 띄우고, 삭제 버튼을 둔다.
    - 일단 임시로 editing 설정해둔 상태임!
</details>


<details>
<summary>0919</summary>

**완료한 부분**

- [x]  리드미 업데이트
- [ ]  데이터에 메모 날짜 추가하기 + 1h
    - [ ]  ?!!?!?!
- [x]  IQkeyboard + 1h
    - [x]  왜 안되냐………
    - [x]  major version 2 아님!!!! 6.5.0으로 하니까 해결 ;
    - [x]  적용 완료
- [ ]  투두 작성시 체크기능 만들기
    - [ ]  색상 랜덤
- [ ]  다이어리 저장 + 1h
    - [ ]  제너릭..어떻게 쓰는거임
    - [x]  렘 연결 완료 0.5h
    - [x]  results! 사용해서 여러개 불러오는데 한개만 불러오ㅏ야 해서 문제 → results로 안하고 diary 하나로 사ㅇ용해서 해결
    - [ ]  저장까지는 됨! 불러오기만.. 날짜에 저장된게 있으면 그걸 불러오기
- [ ]  writeVC 제목 오늘 날짜로 바꾸기
- [ ]  캘린더 화면에서 메모 불러오기

**고민한 부분**

- 다이어리 textView저장할 때, placeholder 문제
    - 아무것도 없으면 placeholder가 실행됨
    - placeholder와 똑같은 내용이 쓰여있으면 지워짐 → 어떻게 해결하지?
    - 잭님 띄어쓰기 해결법 ㅋㅋㅋ
    - isChanged 데이터를 만들어서 넣어주려고 했는데, 수정이 많이 되면 다시 리셋될 것 같음 ㅜㅜ
- 제스처 델리게이트 우선순위, 다중 제스처 설정!! 한 번 해보자
</details>

<details>
<summary>0920</summary>

- [x]  다이어리 렘 불러오기 (해당 날짜) + 0.5h
- [x]  writeVC 제목 오늘 날짜로 바꾸기 + 0.3h
- [x]  캘린더 화면 요일, 제목 바꾸기 + 0.5h
- [x]  캘린더 화면에서 불러오기 1h
    - [x]  다이어리도 불러오기!!!
    - [x]  투두 불러오기!
- [x]  투두 저장….. 1h
    - [x]  textviewDidEndEditing 함수에서 indexpath 불러오는 stackoverflow로 해결!

</details>


<details>
<summary>0921</summary>

- [ ]  투두 작성시 체크기능 만들기
    - [x]  체크 뷰 만들기
    - [ ]  체크 뷰에서 완료 클릭시 해당 투두의 check 여부 바꿔주고, 체크이미지 바뀌고, 체크 뷰 없어지도록??
    - [ ]  → 뷰를 따로 빼지 않고, 셀에 버튼들 포함한 다음 위에 가리는 뷰를 올려줬다
    - [ ]  커스텀 팝업으로 하는게 좋을까..????? → 위치를 매번 다르게 할 수 없을 것 같음 ㅜㅠ
    - [ ]  
    - [ ]  색상 랜덤
- [ ]  투두 체크 완료해야 넘어갈 수 있도록
- [ ]  페이지 뷰컨 이상하게 넘어가는거
- [ ]  캘린더 → PageVC 클릭시 WriteVC로 들어가기
- [ ]  캘린더에서 셀 클릭 안되도록
- [ ]  제스처 델리게이트 우선순위, 다중 제스처 설정!! 한 번 해보자
- [x]  폰트 적용..

고민한 부분

- 체크 뷰 를 띄워놓고 다른 셀을 클릭하면 셀이 뷰 위로 올라옴.. 다른 모든 버튼을 눌렀을 때 뷰가 사라지도록 해야 한다
    - 키보드 띄웠을 때, 다른 셀 클릭했을 때, 다른 셀의 텍스트뷰 클릭했을 때,
    

card만을 위한 tableviewcell 필요할듯

스택뷰?

</details>

<details>
<summary>0922</summary>

- [x]  페이지 뷰컨 이상하게 넘어가는거
- [x]  캘린더 → PageVC 클릭시 WriteVC로 들어가기
- [x]  캘린더에서 셀 클릭 안되도록
- [ ]  제스처 델리게이트 우선순위, 다중 제스처 설정!! 한 번 해보자
- [ ]  캘린더에서 + 클릭하면 새로 뷰 나오기,,
- [ ]  오늘작성 화면에서 날짜 선택
- [x]  폰트 적용..

- [x]  할일 작성 텍스트뷰 → 버튼으로 만들기
- [x]  할일 작성 클릭시 맨 마지막 셀에 firstResponder()
- [x]  투두에서 아무것도 적지 않고 나갈 시 삭제되도록

- [x]  캘린더 UI
- [x]  캘린더 점

[https://snowee.tistory.com/30](https://snowee.tistory.com/30)

</details>

<details>
<summary>0925</summary>

- [x]  세부 유아이 수정
    - [x]  CardTodo, CardDiary textview 위치 수정
    - [x]  diary 작성 안돼도 초록 버튼 떠있는부분 수정 - nil과 “” 차이 주었음

**고민한 부분**

- 체크를 표시하려고 버튼을 눌렀는데, 체크 표시하기가 싫다면?
- 캘린더용 버튼? - 일단 임시로 캘린더 이미지 넣긴 함
- 모아보기 유아이 - 왼쪽은 그냥 뷰, 오른쪽은 컨테이너 뷰 안에 페이지뷰컨..!!

</details>

<details>
<summary>0926</summary>
잭님

- 삭제는 스와이프 말고, 편집 모드들어갈 시 선택해서 삭제하기
- 위로 제스처 하면 모아보기&검색 기능 생기기
- 설정 버튼 왼쪽에 두기

고민한 부분

- 클리어 버튼!!!!!!!으아악
    - 페이지뷰컨 안에 있는 뷰컨에서 만들어줬음
- 일단 모아보기 화면은 업데이트로 미루기

디자이너랑 얘기하자

- 체크를 표시하려고 버튼을 눌렀는데, 체크 표시하기가 싫다면?! - 버튼: 완료 미완료 연기 체크해제
- 캘린더용 버튼? - 일단 임시로 캘린더 이미지 넣긴 함
- 만약 다이어리까지 다 적고 피니씨 했는데 날짜가 지난 이후에 투두를 추가했어.. 그리고 체크를 안했어 그러면 클리어 버튼이 비활성화 되어있나?!
    - 클리어 압수.. 하루까지만 수정 가능
- 체크에 점선 없는 화면은 cardview 쪽에만!!!
- 플러스 버튼 없애

</details>

<details>
<summary>1001</summary>

출시 완료!
- Github 업데이트! 리드미에 추가함

업데이트 할 기능들?

- 설정화면
    - 알림 설정(아침, 저녁)
    - 테마 변경
    - 오픈소스 라이선스
    - 개발자 정보
    - 글자 크기
- 연기하면 뒤 날짜로 들어갈 수 있게
    - 달력 선택?
- 다이어리 선택 시 다이어리 편집 화면으로 갈 수 있게
- 네비게이션으로 뜯어고치기
- 다국어 지원

</details>

<details>
<summary>1002</summary>

1. 설정 페이지(알림 여부(오전오후10), 글자 크기, 테마, 개발팀 정보, 백업/복구)
    1. 알림 문구
        1. 오늘의 todo를 작성해보세요 :)
        2. 오늘의 일기를 작성해보세요 :)
        3. 미완료인 to do 가 있습니다 ;( 앱에서 확인 하세요.
2. **앱스토어에서 보이는 스크린샷 목업 재정비 (기기별 화면 다르게!)**
3. 기타 UI 재정비
    1. 앱 아이콘 변경
    2. 앱 내 버튼 도트로 변경하기
    3. 테마 색깔
- 아이패드 화면 만들어보기(맘대로 하삼!!)
- 위젯화면

</details>

<details>
<summary>1007</summary>

- [ ]  순서 바꾸는 기능 완성하기
- [ ]  Crashlytics 달기

</details>


| 날짜 | 완료한 부분         | 고민한 부분 | 팀빌딩 내용 | 기타 |
|------|---------------------|-------------|-------------|------|
| 1009 | - 순서 바꾸는 기능 수정 중.. | - 순서를 바꾸려면 OrderDate를 서로 바꿔주어야 하는데 어떻게 바꾸는게 좋은지?            |             |      |


<!--
<details>
<summary>Click to toggle contents of `code`</summary>
```
CODE!
```
</details>
-->
