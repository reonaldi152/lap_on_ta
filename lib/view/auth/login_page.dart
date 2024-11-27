import 'package:flutter/material.dart';
import 'package:flutter_lapon/view/auth/register_page.dart';
import 'package:flutter_lapon/view/auth/request_code_password_page.dart';
import '../../config/app_color.dart';
import '../../config/pref.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../../widget/custom_toast.dart';
import '../base_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;
  bool isLoading = false;
  final Session _session = Session();

  final _formKey = GlobalKey<FormState>();

  RegExp get emailRegex => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 32),
                Center(
                    child: Text(
                  "Masuk Akun",
                  style: fontTextStyle.copyWith(
                    color: AppColor.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                )),
                const SizedBox(height: 16),
                Text(
                  "Masuk ke dalam akun untuk bisa maksimal dalam menggunakan fitur aplikasi.",
                  style: fontTextStyle.copyWith(color: Color(0xFF4F5E71)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 16),
                //   child: Center(
                //     child: Text(
                //       "atau",
                //       style: fontTextStyle.copyWith(
                //           color: const Color(0xFF878E97), fontSize: 12),
                //     ),
                //   ),
                // ),
                TextFormField(
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: AppColor.white,
                      filled: true,
                      labelStyle: fontTextStyle.copyWith(
                          color: const Color(0xff878E97)),
                      hintStyle: fontTextStyle.copyWith(
                          color: const Color(0xff878E97)),
                      hintText: "Email",
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE8EDF1)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE8EDF1)),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE8EDF1)),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email harus di isi';
                      } else if (value.isNotEmpty) {
                        if (!emailRegex.hasMatch(value)) {
                          return 'Email tidak valid';
                        }
                      }
                      return null;
                    }),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: passwordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'kata sandi harus di isi';
                    }
                    return null;
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                      fillColor: AppColor.white,
                      filled: true,
                      labelStyle: fontTextStyle.copyWith(
                          color: const Color(0xff878E97)),
                      hintStyle: fontTextStyle.copyWith(
                          color: const Color(0xff878E97)),
                      hintText: "Kata Sandi",
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE8EDF1)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE8EDF1)),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE8EDF1)),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      suffixIconColor: const Color(0xff324256),
                      suffixIcon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          })),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RequestCodePasswordPage()));
                        },
                        child: Text(
                          "Reset Password",
                          style: fontTextStyle.copyWith(
                              color: AppColor.colorPrimaryGreen),
                        ))),
                Container(
                  margin: const EdgeInsets.only(top: 18, bottom: 30),
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.colorPrimaryGreen,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: AppColor.white,
                          strokeWidth: 2,
                        ))
                      : TextButton(
                          onPressed: () {
                            // Session().setUserLogin(value: true);
                            // Navigator.of(context).pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //         builder: (context) => const BasePage()),
                            //         (Route<dynamic> route) => false);

                            if (isLoading == false &&
                                _formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              login();
                            }
                          },
                          child: Text(
                            "Masuk Sekarang",
                            style: fontTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.white,
                              fontSize: 16,
                            ),
                          )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Belum memiliki akun? ",
                        style: fontTextStyle.copyWith(
                            color: const Color(0xFF4F5E71))),
                    InkResponse(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                        child: Text("daftar sekarang",
                            style: fontTextStyle.copyWith(
                                color: AppColor.colorPrimaryGreen)))
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() {
    AuthViewmodel()
        .login(email: emailController.text, password: passwordController.text)
        .then((value) async {
      if (value.code == 200) {
        setState(() {
          isLoading = false;
        });
        await Session().setUserToken(value.data["access_token"]);
        await Session().setUserId(value.data["user"]["id"].toString());
        if (!mounted) return;
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             WelcomePage(nama: value.data['user']['name'])),
        //     (Route<dynamic> route) => false);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const BasePage()),
                (Route<dynamic> route) => false);
      } else {
        setState(() {
          isLoading = false;
        });
        showToast(context: context, msg: value.message.toString());
      }
    });
  }
}
