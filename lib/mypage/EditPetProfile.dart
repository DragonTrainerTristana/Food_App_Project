import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_service_application/bottombar/MenuBottomBar.dart';
import 'package:pet_service_application/log_in/UserInfoClass.dart';

class EditPetProfile extends StatefulWidget {
  const EditPetProfile({Key? key}) : super(key: key);
  @override
  _EditPetProfileState createState() => _EditPetProfileState();
}

class _EditPetProfileState extends State<EditPetProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.08),
              Container(
                alignment: Alignment.center,
                child: Text("함께하는 반려동물",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.085),
              Container(
                alignment: Alignment.center,
                child: Text("프로필 이미지",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02),
              ClipRRect( // 프로필 이미지 설정란
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'images/loginIcon/icon_kakao.png',
                  width: 122,
                  height: 122,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                  // 사진 촬영 버튼 Card
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // 카드 테두리의 둥글기 설정값
                    elevation: 4.0,
                    child: InkWell(
                        splashColor: Colors.grey.withAlpha(30),
                        child: SizedBox( // 카드 박스의 Size
                          width: MediaQuery.of(context).size.width*0.43,
                          height: MediaQuery.of(context).size.height*0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('images/svg/camera.svg', // 갤러리 이미지
                                width: 16,
                                height: 16, // 크기는 폰트 사이즈와 맞게
                              ),
                              SizedBox(width: 8),
                              Text('사진촬영',
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap:(){
                          // 사진촬영 기능으로 이동
                        }
                    ),
                  ),
                  // 갤러리 버튼 Card
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // 카드 테두리의 둥글기 설정값
                    elevation: 4.0,
                    child: InkWell(
                        splashColor: Colors.grey.withAlpha(30),
                        child: SizedBox( // 카드 박스의 Size
                          width: MediaQuery.of(context).size.width*0.43,
                          height: MediaQuery.of(context).size.height*0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('images/svg/gallery.svg', // 갤러리 이미지
                                width: 16,
                                height: 16, // 크기는 폰트 사이즈와 맞게
                              ),
                              SizedBox(width: 8),
                              Text('갤러리',
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap:(){
                          // 갤러리 기능으로 이동
                        }
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.08),
              Container( // 프로필 상태메시지 텍스트
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width*0.04
                ),
                alignment: Alignment.centerLeft,
                child: Text("프로필 상태메시지",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03),
              Card( // 프로필 상태메시지 입력창
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // 카드 테두리의 둥글기 설정값
                elevation: 4.0,
                child: InkWell(
                    splashColor: Colors.grey.withAlpha(30),
                    child: Container( // 카드 박스의 Size
                        width: MediaQuery.of(context).size.width*0.87,
                        height: MediaQuery.of(context).size.height*0.2,
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width*0.03,
                            left: MediaQuery.of(context).size.width*0.06
                        ),
                        child: TextFormField(
                          // controller: editingController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: '프로필 상태메시지를 입력해주세요! (20자 이내)',
                                hintStyle: TextStyle(color: GREY)),
                            cursorColor: GREY,
                            //테스트용 코드
                            onChanged: (text) {
                              print(text);
                            })
                    ),
                    onTap:(){
                      // 사진촬영 기능으로 이동
                    }
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BackSpaceButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}