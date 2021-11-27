import 'package:pet_service_application/community/CommunityInfo.dart';
import 'package:pet_service_application/community/ShortsInfo.dart';

//사용자의 유저 정보 싱글톤
class Logger {
  static final Logger _logger = Logger._internals();

  UserData userData = UserData();
  String userEmail = ""; // 사용자 이메일
  String userPassword = ""; // 사용자 비밀번호

  PetInfo getDefaultPet()
  {
    if (userData.MyPets.isNotEmpty)
      return userData.MyPets.first;
    else
      return PetInfo('???');
  }

  factory Logger() {
    return _logger;
  }

  //초기화 코드
  Logger._internals();
}

//유저가 가지는 정보 클래스
class UserData
{
  //유저 계정 정보 (카카오 계정 정보 하나)
  String AccountInfo = "";
  //유저 ID
  String UID = "";

  //유저 이름과 설명
  String Name = "";
  List<String> Description = [];

  int following = 0;
  int follower = 0;

  //유저 이미지 2개
  String MedalImage = "";
  //프로필 이미지
  String MyImage = "";

  //친구 유저들의 이름
  List<String> Friends = [];
  //차단 유저 정보
  List<String> Blocks = [];
  //유저가 작성한 쇼츠 게시물들
  List<ShortsInfo> Shorts = [];
  //유저가 작성한 커뮤니티 게시글들
  List<CommunityInfo> Community = [];

  //UserInfo상의 펫 클래스 참조
  List<PetInfo> MyPets = [];

  UserData()
  {
    Description.clear();
    Description.add("반갑습니다!");
  }
}

class PetInfo {
  String petName = ""; // 펫 이름
  String petID = "";
  static List<String> petTypeNameList = [];   //x
  //펫 종류
  String petType = "";
  //펫 상세 종
  int petSpecies = 0;
  int petAge = 0;
  double petBodyLength = 0;
  double petWeight = 0;
  PetSilhouette petSilhouette = PetSilhouette.BCS1;
  List<String>? petAllergyList = [];

  PetInfo(this.petName);
}

enum PetSilhouette { BCS1, BCS2, BCS3, BCS4, BCS5 } // 질문5-2] 반려동물 실루엣(BCS단계)

