# MemeMe


## 목차
* MemeMe Application 소개
* MemeMe 기능소개
* MemeMe Kick 기능 설명


-----------

## MemeMe Application 소개
* 앨범, 카메라를 이용하여 이미지를 가져온 후 뷰에 상,하단에 텍스트를 추가하여 공유, 저장, 전송 등의 이벤트 진행
* 액션이 끝난 이미지에 대하여 TableVIew, CollectionView 의 리스트 제공 (삭제, 순서 변경 등 가능)
* 리스트에 있는 이미지 보기 제공
* 리스트 이미지 등와 텍스트등은 별도의 파일을 생성하지 않고 캐시로 만들어 관리
<br /><br /><br />

-----------

## MemeMe 기능소개
<br /><br />
[시연동영상](https://youtu.be/taUkyUWzSPk)
* Action을 끝낸 이미지에 대하여 파일 리스트 제공
  <br /><br />
  1. TableView (파일 삭제, 순서 변경 가능)

  ![테이블뷰](https://github.com/BoostCamp/LimboMemeMe-Doohwan/blob/master/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202017-01-28%20%EC%98%A4%ED%9B%84%204.30.29.png)
  ![테이블 셀 수정](https://github.com/BoostCamp/LimboMemeMe-Doohwan/blob/master/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202017-01-28%20%EC%98%A4%ED%9B%84%204.31.31.png)
<br /><br />
  2. CollectionView (CustomLayout Collection 추가)

  ![콜렉션뷰](https://github.com/BoostCamp/LimboMemeMe-Doohwan/blob/master/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202017-01-28%20%EC%98%A4%ED%9B%84%204.30.43.png)
  ![커스텀콜렉션뷰](https://github.com/BoostCamp/LimboMemeMe-Doohwan/blob/master/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202017-01-28%20%EC%98%A4%ED%9B%84%204.30.55.png)
<br /><br />
* 이미지 수정
 <br /><br />
  1. 카메라, 앨범을 이용한 이미지 가져오기

  ![이미지 불러오기](https://github.com/BoostCamp/LimboMemeMe-Doohwan/blob/master/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202017-01-28%20%EC%98%A4%ED%9B%84%205.32.50.png)
<br /><br />
  2. 뷰 상단, 하단 텍스트 입력 

  ![텍스트 입력](https://github.com/BoostCamp/LimboMemeMe-Doohwan/blob/master/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202017-01-28%20%EC%98%A4%ED%9B%84%205.33.25.png)
  <br /><br />
  3. 수정된 이미지 처리 (전송, 공유, 저장 등)

  ![이미지처리](https://github.com/BoostCamp/LimboMemeMe-Doohwan/blob/master/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202017-01-28%20%EC%98%A4%ED%9B%84%204.32.14.png)
<br /><br />
* 이미지 보기
<br /><br />
  1. 화면 회전에 따른 ContentMode 변경 후 보기

  ![이미지보기](https://github.com/BoostCamp/LimboMemeMe-Doohwan/blob/master/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202017-01-28%20%EC%98%A4%ED%9B%84%204.31.18.png) 
<br /><br />
* 데이터 저장
    <blockquote>
  <p>    appDelegate.anyArr.append(["topText":meme.topText! as NSString,"bottomText":meme.bottomText! as NSString,"originalImage":UIImagePNGRepresentation(meme.originalImage!)! as NSData,"memedImage":UIImagePNGRepresentation(meme.memedImgae!)! as NSData])
    <br />
    setting.set(appDelegate.anyArr, forKey: "memes") </p>
</blockquote>
<br /><br />
-------------
## MemeMe Kick 기능 설명 

* Beizerpath를 이용한 그림판 (하단 Slider로 선 굵기 변경 가능)
* Delegate를 이용한 이전 이미지 변경
<br /><br />
![그림판](https://github.com/BoostCamp/LimboMemeMe-Doohwan/blob/master/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202017-01-28%20%EC%98%A4%ED%9B%84%204.33.37.png)
![변경된 이미지](https://github.com/BoostCamp/LimboMemeMe-Doohwan/blob/master/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202017-01-28%20%EC%98%A4%ED%9B%84%204.33.49.png)
