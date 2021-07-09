import 'package:flutter/material.dart';
import 'package:pet_service_application/main.dart';
import 'package:pet_service_application/log_in/SignUpPage.dart';
import 'dart:math';

const Color PINK = const Color.fromRGBO(255, 113, 113, 1);
class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // 리소스 낭비를 막기 위해 dispose method를 사용해야하나, 생략

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("로그인"),
        backgroundColor: PINK,
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search))
        ],
      ),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView( // 키보드 올라옴에 따라 스크린도 같이 올라가는 위젯
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 50)),
                Center(
                  child: Image(
                    image: AssetImage('images/logo_main.png'),
                    width: 200.0,
                    height: 200.0,
                  ),
                ),
                Form(
                    child: Theme(
                        data: ThemeData(
                            primaryColor: Colors.black87,
                            inputDecorationTheme: InputDecorationTheme(
                                labelStyle: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15.0
                                )
                            )
                        ),
                        child: Container( // Container 위젯은 1개의 child만 가질 수 없다!
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: "이메일을 입력하세요 / 초기값: email",
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: "비밀번호를 입력하세요 / 초기값: password",
                                ),
                                keyboardType: TextInputType.text,
                                obscureText: true, // 비밀번호 보안
                              ),
                              SizedBox(height: 40.0),
                              ButtonTheme(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: PINK,
                                        onPrimary: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 180, vertical: 20),
                                        textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                    onPressed: () {
                                      if (emailController.text == 'email'
                                          && passwordController.text ==
                                              'password') {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (
                                                    BuildContext context) =>
                                                    MyHomePage(title: appName))
                                        );
                                      }
                                      else if (emailController.text == 'email'
                                          && passwordController.text !=
                                              'password') {
                                        showSnackBarPassword(context);
                                      }
                                      else if (emailController.text != 'email'
                                          && passwordController.text ==
                                              'password') {
                                        showSnackBarEmail(context);
                                      }
                                      else {
                                        showSnackBarLogin(context);
                                      }
                                    },
                                    child: Text("로그인하기")),
                              ),
                              SizedBox(height: 20.0),
                              ButtonTheme(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.grey[350],
                                          onPrimary: Colors.black87,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 180, vertical: 20),
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          )
                                      ),
                                      onPressed: () {
                                        // Navigator.push(context,
                                        // MaterialPageRoute(
                                        //     builder: (BuildContext context) =>
                                        //         SignUpPage())
                                        // );
                                      },
                                      child: Text("회원가입"))
                              ),
                              SizedBox(height: 60.0),
                              Divider(
                                height: 25,
                                thickness: 1,
                                color: Colors.grey[850],
                                indent: 100,
                                endIndent: 100,
                              ),
                              // ----------소셜 아이디 로그인 -----------
                              //
                              // ----------소셜 아이디 로그인 -----------
                            ],
                          ),
                        ))
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void showSnackBarLogin(BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content:
    Text('로그인 정보를 다시 확인하세요',
        textAlign: TextAlign.center
    ),
        duration: Duration(seconds: 2),
    )
  );
}
void showSnackBarPassword(BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:
      Text('비밀번호가 일치하지 않습니다',
          textAlign: TextAlign.center
      ),
        duration: Duration(seconds: 2),
      )
  );
}
void showSnackBarEmail(BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:
      Text('이메일이 일치하지 않습니다',
          textAlign: TextAlign.center
      ),
        duration: Duration(seconds: 2),
      )
  );
}

