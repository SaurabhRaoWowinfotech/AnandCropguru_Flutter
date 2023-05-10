import 'package:dr_crop_guru/screens/login_screen.dart';
import 'package:dr_crop_guru/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectLanguageScreen extends StatefulWidget {
  static final routeName = '/select-language-screen';

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  String _selectedLanguage = 'No language selected';

  void _selectLanguage(String title){
    setState(() {
      _selectedLanguage = title;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Util.colorPrimary,
    ));
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              height: 200,
              width: 200,
              child: Image.asset('assets/images/anand_crop_guru_logo.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Text('भाषा निवडा',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 25,
            ),
            LanguageButton('मराठी', _selectedLanguage == 'मराठी' ? true : false, _selectLanguage),
            LanguageButton('हिन्दी', _selectedLanguage == 'हिन्दी' ? true : false, _selectLanguage),
            LanguageButton('ENGLISH', _selectedLanguage == 'ENGLISH' ? true : false, _selectLanguage),
            LanguageButton('ગુજરાતી', _selectedLanguage == 'ગુજરાતી' ? true : false, _selectLanguage),
            SizedBox(
              height: 35,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white, width: 1.3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    offset: Offset(0.0, 1.0),
                  ),
                ],
                gradient: LinearGradient(colors: [
                  Colors.green,
                  Util.endColor,
                ],
                begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: SizedBox(
                height: 37,
                width: 130,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: Text('पुढे जा',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black54,
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final String title;
  final bool flag;
  final selectLanguage;

  LanguageButton(this.title, this.flag, this.selectLanguage);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        selectLanguage(title);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7),
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: flag ? Util.colorPrimary : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          border: Border.all(
            width: 1.7,
            color: flag ? Colors.white : Util.colorPrimary,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: flag ? Colors.white : Util.colorPrimary,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
