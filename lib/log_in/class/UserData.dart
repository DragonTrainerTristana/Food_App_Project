import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

//사용자의 유저 정보 싱글톤
class Logger {
  static final Logger _logger = Logger._internals();

  UserData userData = UserData();
  List<PetInfo> petData = [PetInfo('???')];
  //스토리지 불러오기용 링크 주소
  static const String storageUrl = 'gs://bonapetti-715a9.appspot.com';

  ///디폴트 펫 데이터 불러오기
  PetInfo getDefaultPet() {
    if(petData.isEmpty)
      throw Exception('Logger Pet Data Error');
    else {
        //대표 펫 설정 이전 or 인덱스 오류
        if(userData.myDefaultPet < 0)
          return petData.last;
        //대표 펫 값 정상
        else if(userData.myDefaultPet < petData.length)
          return petData[userData.myDefaultPet];
        //대표 펫 > 받아온 펫 수 (펫 수신 오류)
        else
          return petData.last;
      }
  }

  factory Logger() {
    return _logger;
  }
  //초기화 코드
  Logger._internals();

  void getPetData() async {
    await FirebaseFirestore.instance.collection('UserData').doc(userData.uid.toString()).collection('Pets').get().then((petDocs) {
      if(petDocs.docs.length == 0)
        return;
      else {
        petDocs.docs.forEach((doc) {
          PetInfo.getPetData(userData.uid.toString(), doc.id).then((myPetInfo) {
            petData.add(myPetInfo);
          });
        });
        }
    });
  }

  //유저 데이터 첫 생성 : 서버로 동기화
  void sendUserData() async  {
    if (userData.name != "")
    {
      Future<int> curUserCount = allocUserID();
      curUserCount.then((value) {
        debugPrint("Allocate New UID : $value");
        if(value > 0)
        {
          CollectionReference users = FirebaseFirestore.instance.collection(
              'UserData');
          users.doc(value.toString()).set({
            'AccountInfo': userData.accountInfo,
            'Name': userData.name,
            'Description': userData.description,
            'following' : userData.following,
            'follower' : userData.follower,
            'Posts': userData.posts,
            'Shorts': userData.shorts,
            'MedalImage': userData.medalImage,
            'MyImage': userData.myImage,
            'MyPets': userData.myPets
          });
        }
        Logger().userData.uid = value;
      });
    }
    else
      throw Exception('Login Data Already Exist');
  }

  //새 UID 할당받기 : 서버와 동기화
  Future<int> allocUserID() async {
    //현재 유저 수 확인 후 UID 배정받기
    int newUID = await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(FirebaseFirestore.instance.collection('Manage').doc('Users'));
      if (!snapshot.exists) {
        throw Exception('Server Manager Connect Fail');
      }
      int curUserCount = snapshot.get('Count') + 1;
      transaction.update(FirebaseFirestore.instance.collection('Manage').doc('Users'), {'Count' : curUserCount});
      return curUserCount;
    });
    return newUID;
  }

  //중복 이름 여부 확인 함수
  Future<bool> isUserExist(String _name) async {
    var documentSnapshot = await FirebaseFirestore.instance
        .collection("UserData")
        .where('Name', isEqualTo: _name)
        .get();
    if (documentSnapshot.docs.isEmpty)
      return false;
    else
      return true;
  }

  //유저 데이터 존재 여부
  Future<dynamic> isKakaoUserExist(int _tokenID) async {
    var documentSnapshot = await FirebaseFirestore.instance
        .collection("UserData")
        .where('AccountInfo', isEqualTo: _tokenID)
        .get();
    if (documentSnapshot.docs.isEmpty)
      return false;
    else
      return documentSnapshot.docs.first.id.toString();
  }
  Future<bool> isDocExist(int uid) async {
    var collectionRef = FirebaseFirestore.instance
        .collection("UserData");
    var doc = await collectionRef.doc(uid.toString()).get();
    return doc.exists;
  }
}

//유저가 가지는 정보 클래스
class UserData {
  //유저 계정 정보 (카카오 계정 정보 하나)
  int accountInfo = 0;
  //유저 ID
  int uid = 0;

  //유저 이름과 설명
  String name = "";
  String description = '';

  //팔로잉 팔로워 유저 정보
  List<String> following = [];
  List<String> follower = [];

  //유저 이미지 2개
  String medalImage = "";
  //프로필 이미지
  String myImage = "";

  //차단 유저 정보
  List<String> blockList = [];
  //유저가 작성한 쇼츠 게시물들
  List<String> shorts = [];
  //유저가 작성한 커뮤니티 게시글들
  List<String> posts = [];

  //대표 펫 인덱스
  int myDefaultPet = -1;
  //UserInfo 펫 클래스 참조
  List<String> myPets = [];

  UserData()
  {
    description = "반갑습니다!";
  }

  ///uid로 서버에서 유저정보 불러오기
  static Future<UserData> getUserData(String uid) async  {
    try {
      await Firebase.initializeApp();
    }
    catch (e) {
      throw Exception(e);
    }
    var userData = await FirebaseFirestore.instance.collection(
        'UserData').doc(uid).get();
    UserData result = UserData();
    {
      result.uid = int.parse(uid);
      result.accountInfo = userData.data()!['AccountInfo'];
      result.name = userData.data()!['Name'];

      result.description = '';
      result.description = userData.data()!['Description'];
      result.follower = userData.data()!['follower'].cast<String>();
      result.following = userData.data()!['following'].cast<String>();
      result.medalImage = userData.data()!['MedalImage'];
      result.myImage = userData.data()!['MyImage'];
      result.posts = userData.data()!['Posts'].cast<String>();
      result.shorts = userData.data()!['Shorts'].cast<String>();
    }
    return result;
  }
  //랜덤 유저 정보 불러오기
  static Future<int> getRandomUserID() async {
    try {
      await Firebase.initializeApp();
    }
    catch (e) {
      throw Exception(e);
    }
    int userCount = await FirebaseFirestore.instance.collection(
        'Manage').doc('Users').get().then((value) {
          return value.data()!['Count'];
    });

    bool isExist = false;
    int ranUserID;
    do {
      ranUserID = Random().nextInt(userCount-10000) + 10001;

      isExist = await Logger().isDocExist(ranUserID);
    } while(isExist == false);

    return ranUserID;
  }
}

class PetInfo {
  //------  펫이 가지는 속성들-------------
  String petName = ""; // 펫 이름
  String petID = "";  //펫 ID

  String petType = '';  //펫 종류
  String petSpecies = ''; //펫 상세 종
  int petAge = 0;
  double petBodyLength = 0;
  double petWeight = 0;
  PetSilhouette petSilhouette = PetSilhouette.BCS1;
  List<String> petAllergyList = [];
  List<String> petDiseaseList = [];

  PetInfo(this.petName);
  //서버상의 펫 타입, 알러지, 질병 데이터
  static Map<String,List<String>> petTypes = {};
  static List<String> allergies = [];
  static List<String> diseases = [];
  //펫 초기 정보 불러오기
  static void initialPetListData() async {
    //펫 타입 초기화
    petTypes = {};
    var petDocument = await FirebaseFirestore.instance.collection('Manage').doc('PetType').get();
    if(petDocument.data() == null)
      throw Exception('Server Manager Connect Fail');
    petDocument.data()!.forEach((key,value) {
      petTypes[key.toString()] = List.from(value);
    });
    //펫 알러지 초기화
    allergies = [];
    diseases = [];
    var petInfoDoc = await FirebaseFirestore.instance.collection('Manage').doc('PetInfo').get();
    if(petInfoDoc.data() == null)
      throw Exception('Server Manager Connect Fail');
    allergies = petInfoDoc.data()!['Allergy'].cast<String>();
    diseases = petInfoDoc.data()!['Disease'].cast<String>();
  }

  //uid로 서버에서 펫 정보 불러오기
  static Future<PetInfo> getPetData(String uid, String petID) async  {
    try {
      await Firebase.initializeApp();
    }
    catch (e) {
      throw Exception(e);
    }
    var petDoc = await FirebaseFirestore.instance.collection(
        'UserData').doc(uid).collection('Pets').doc(petID).get();
    PetInfo result = PetInfo(petDoc.data()!['Name']);
    {
      result.petID = petID;
      result.petName = petDoc.data()!['Name'];
      result.petType = petDoc.data()!['PetType'];
      result.petSpecies = petDoc.data()!['PetSpecies'];
      result.petAge = petDoc.data()!['Age'];
      result.petBodyLength = double.parse(petDoc.data()!['BodyLength'].toString());
      result.petWeight = double.parse(petDoc.data()!['Weight'].toString());
      result.petAllergyList = petDoc.data()!['AllergyList'].cast<String>();
    }
    return result;
  }

  //생성된 펫 정보를 서버로 전송 (현재 펫 데이터 = 펫 개수)
  void sendPetData() async {
    //펫 정보 없을 바로 종료
    if(petName == "")
      throw Exception('Empty Pet Data');

    //uid 정상 호출 후 컬랙션 호출
    if (Logger().userData.uid != 0) {
      CollectionReference pets = FirebaseFirestore.instance.collection(
          'UserData').doc(Logger().userData.uid.toString()).collection('Pets');
      var petDocs = await pets.get();
      //할당할 펫 ID값 불러오고 Logger()에 적용
      int petCount = petDocs.docs.length;
      Logger().userData.myDefaultPet = petCount;
      //펫 ID로 문서 생성 및 전송
      petID = petCount.toString();
      pets.doc(petCount.toString()).set({
        //pet id 설정 후 입력
        'Name': petName,
        'Type' : petType,
        'Species' : petSpecies,
        'Age': petAge,
        'BodyLength': petBodyLength,
        'Weight': petWeight,
        'Silhouette': petSilhouette.toString(),
        'AllergyList': petAllergyList,
        'DiseaseList' : petDiseaseList
      });
      FirebaseFirestore.instance.collection(
          'UserData').doc(Logger().userData.uid.toString()).update({'MyDefaultPet' : petCount});
    }
    else
      throw Exception('Login Data Not Exist');
  }
}

enum PetSilhouette { BCS1, BCS2, BCS3, BCS4, BCS5 } //반려동물 실루엣(BCS)

/* 파이어 베이스 세팅
//파이어베이스 스테이트
  bool _initialized = false;
  bool _error = false;

  //파이어베이스 이니셜
  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }
 */

