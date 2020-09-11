import 'package:flutter/services.dart';
import 'package:flutter_web_signin/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_signin/utilities/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email, password;


  final formKey = new GlobalKey<FormState>();

  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }


  Widget _buildPasswordTF(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 4.0),
        Container(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            obscureText: true,
            validator: (value) => value.isEmpty
                ? 'Пароль отсутствует'
                : null,
            onChanged: (value) {
             this.password = value;
           },
            style: TextStyle(
              color: Colors.grey[600],
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 1.0, color: Colors.grey[400]),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 1.0, color: Colors.red[200]),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 1.0, color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(width: 1.0, color: Colors.blue),
                  ),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.grey[400],
              ),
              hintText: 'Пароль',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 4.0),
        Container(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
              validator: (value) => value.isEmpty
                  ? 'Емейл отсутствует'
                  : validateEmail(value.trim()),
              onChanged: (value) {
                this.email = value;
              },
            style: TextStyle(
              color: Colors.grey[600],
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(
          color: Colors.red,
          wordSpacing: 5.0,
        ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 1.0, color: Colors.grey[400]),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 1.0, color: Colors.red[200]),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 1.0, color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(width: 1.0, color: Colors.blue),
                  ),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.grey[400],
              ),
              hintText: 'Адрес электронной почты',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 0.0,
        onPressed: () { 
          if (checkFields()){
           AuthService().signIn(email, password, context); 

           }},
        padding: EdgeInsets.all(13.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.blue[100],
        child: Text(
          'Войти',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.1,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                    child: Stack(
                    children: <Widget>[
                      Container(
                           height: double.infinity,
                           width: double.infinity,
                           decoration: backgroundDecoration
                     ),

                      Center(
                        child: Container(
                          width: 400.0,
                          height: 500.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                              width: 1.0
                            ),
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                          horizontal: 42.0,
                          vertical: 0.0,
                           ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[ 
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 33.0),
                                child: Image.asset('assets/logo_ecostream-techno.jpg',),
                              ),
                              Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                     SizedBox(height: 0.0),
                                    _buildEmailTF(),
                                     SizedBox(height: 20.0),
                                    _buildPasswordTF(),
                                    _buildLoginBtn(),

                                    
                                  ],
                                ))],
                          ),
                        )),
                      )
                    ],
                  ),
                ))));
  }

}
