import 'package:flutter/material.dart';

import '../../config/app_color.dart';
import '../../config/pref.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../../widget/custom_toast.dart';
import '../base_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _passwordVisible = true, _passwordConfirmVisible = true;
  String? passwordMatch, valueGender;
  bool isLoading = false;
  final Session _session = Session();
  final TextEditingController namaController = TextEditingController(), emailController = TextEditingController(), passwordController = TextEditingController(), confirmPasswordController = TextEditingController(), noTelpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  RegExp get emailRegex => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  RegExp passwordRegex =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.,/]).{8,}$');

  final List<String> _gender = [
    "Laki-Laki",
    "Perempuan"
  ];

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
                  "Daftar Akun",
                  style: fontTextStyle.copyWith(
                    color: AppColor.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                )),
                const SizedBox(height: 16),
                Text(
                  "Daftar akun supaya bisa menggunakan fitur didalam aplikasi.",
                  style: fontTextStyle.copyWith(color: Color(0xFF4F5E71)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // SizedBox(
                //   width: double.infinity,
                //   child: TextButton(
                //     onPressed: () {},
                //     style: OutlinedButton.styleFrom(
                //         side: const BorderSide(
                //           width: 1,
                //           color: Color(0xffE8EDF1),
                //           style: BorderStyle.solid,
                //         ),
                //         backgroundColor: Colors.white,
                //         padding: const EdgeInsets.symmetric(vertical: 12),
                //         shape: const RoundedRectangleBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(16)),
                //         )),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Image.asset("assets/logo_google.png", width: 16),
                //         const SizedBox(width: 8),
                //         Text(
                //           "Masuk dengan Google",
                //           style: fontTextStyle.copyWith(
                //             fontWeight: FontWeight.w700,
                //             fontSize: 14,
                //             color: const Color(0xff4F5E71),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
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
                  controller: namaController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: AppColor.white,
                      filled: true,
                      labelStyle: fontTextStyle.copyWith(
                          color: const Color(0xff878E97)),
                      hintStyle: fontTextStyle.copyWith(
                          color: const Color(0xff878E97)),
                      hintText: "Nama Lengkap",
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
                        return 'Nama harus di isi';
                      }
                      return null;
                    }),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
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
                  controller: noTelpController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      fillColor: AppColor.white,
                      filled: true,
                      labelStyle: fontTextStyle.copyWith(
                          color: const Color(0xff878E97)),
                      hintStyle: fontTextStyle.copyWith(
                          color: const Color(0xff878E97)),
                      hintText: "No Telepon",
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
                        return 'No.Telp harus di isi';
                      }
                      return null;
                    }),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: _passwordVisible,
                  onChanged: (value) {
                    setState(() {
                      passwordMatch = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kata Sandi harus di isi';
                    } else {
                      if (!passwordRegex.hasMatch(value)) {
                        return 'Kata sandi wajib huruf besar, simbol, dan angka.';
                      } else {
                        return null;
                      }
                    }
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
                          icon: Icon(_passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          })),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: confirmPasswordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: _passwordConfirmVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Konfirmasi Kata Sandi harus di isi';
                    }
                    if (value != passwordMatch) {
                      return 'Kedua kata sandi harus sama';
                    }
                    return null;
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    fillColor: AppColor.white,
                    filled: true,
                    labelStyle:
                        fontTextStyle.copyWith(color: const Color(0xff878E97)),
                    hintStyle:
                        fontTextStyle.copyWith(color: const Color(0xff878E97)),
                    hintText: "Konfirmasi Kata Sandi",
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
                      icon: Icon(_passwordConfirmVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _passwordConfirmVisible = !_passwordConfirmVisible;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 18, bottom: 30),
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.colorPrimaryGreen,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextButton(
                      onPressed: () {
                        if (isLoading == false && _formKey.currentState!.validate()){
                          setState(() {
                            isLoading = true;
                          });
                          register();
                        }

                        // Session().setUserLogin(value: true);
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //         builder: (context) => const BasePage()),
                        //         (Route<dynamic> route) => false);
                      },
                      child: isLoading ? const Center(child: CircularProgressIndicator(color: AppColor.white)) :Text(
                        "Daftar Sekarang",
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
                    Text("Sudah memiliki akun? ",
                        style: fontTextStyle.copyWith(
                            color: const Color(0xFF4F5E71))),
                    InkResponse(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: Text("masuk sekarang",
                            style: fontTextStyle.copyWith(
                                color: AppColor.colorPrimaryGreen)))
                  ],
                ),
                const SizedBox(height: 10),
                // TextButton(
                //     onPressed: () {},
                //     child: Text(
                //       "Nanti Saja",
                //       style: fontTextStyle.copyWith(
                //         fontWeight: FontWeight.w600,
                //         color: AppColor.colorPrimaryYellow,
                //       ),
                //     )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  register() {
    AuthViewmodel()
        .register(email: emailController.text, name: namaController.text, confirmPassword: confirmPasswordController.text, password: passwordController.text, phone: noTelpController.text)
        .then(
          (response) async {
        if (response.code == 200){
          setState(() {
            isLoading = false;
          });
          if (!mounted) return;

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const BasePage()),
                  (Route<dynamic> route) => false);


        } else {
          setState(() {
            isLoading = false;
          });
          showToast(context: context,msg: response.message.toString());
        }
      },
    );
  }
}
