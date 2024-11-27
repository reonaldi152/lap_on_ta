import 'package:flutter/material.dart';
import 'package:flutter_lapon/view/profile/ubah_profile_page.dart';
import '../../config/app_color.dart';
import '../../config/pref.dart';
import '../../model/user/user.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../../widget/custom_toast.dart';
import '../auth/request_code_password_page.dart';
import '../base_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    getUserProfile();
    // logout();
    super.initState();
  }

  void logout() async {
    await Session().logout();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const BasePage()),
            (Route<dynamic> route) => false);
    showToast(
        context: context,
        msg: "Logout Berhasil");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color(0xff94A8BE),
        elevation: 0.2,
        backgroundColor: AppColor.white,
        title: Center(
          child: Text(
            "Profil Saya",
            style: fontTextStyle.copyWith(
                color: AppColor.black,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: _users == null ? const Center(child: CircularProgressIndicator(color: AppColor.colorPrimaryGreen,)) : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 80),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  // gradient: LinearGradient(
                  //   colors: [Color(0xffA78A50), Color(0xff8C6D42)],
                  // ),
                  color: AppColor.colorPrimaryGreen,
                ),
                width: double.infinity,
                height: 148,
              ),
              Image.asset(
                "assets/bg_profile.png",
                width: 420,
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 0, bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff94A8BE).withOpacity(0.3),
                        spreadRadius: 0.0,
                        blurRadius: 8,
                        offset: Offset(0.2, 0.2), // changes position of shadow
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const UbahProfilePage(),));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Ubah",
                              style: fontTextStyle.copyWith(
                                fontSize: 14,
                                color: AppColor.colorPrimaryGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // SizedBox(width: 4),
                            // Image.asset("assets/ic_pen.png", width: 14)
                          ],
                        ),
                      ),
                      Text(
                        _users?.name ?? "",
                        style: fontTextStyle.copyWith(
                          fontSize: 16,
                          color: const Color(0xFF252A31),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          _users?.email ?? "",
                          style:
                          fontTextStyle.copyWith(color: const Color(0xFF4F5E71)),
                        ),
                      ),
                      Text(
                        _users?.phone ?? "",
                        style:
                        fontTextStyle.copyWith(color: const Color(0xFF4F5E71)),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(top: 60, left: 40,child: Image.asset("assets/ic_default_profile.png", width: 80,),),
              // Positioned(
              //   top: 45,
              //   left: 40,
              //   child: ClipOval(
              //       child: Container(
              //         decoration: BoxDecoration(
              //             color: AppColor.black,
              //             borderRadius: BorderRadius.circular(50)
              //         ),
              //         child: Image.asset(
              //           'assets/ic_profile.png',
              //           width: 75,
              //           fit: BoxFit.cover,
              //         ),
              //       )
              //   ),
              // )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 26),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColor.white,
              border: Border.all(color: const Color(0xFFE8EDF1)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RequestCodePasswordPage()));
                  },
                  child: Row(
                    children: [
                      // Image.asset("assets/ic_privacy_policy.png", width: 16),
                      SizedBox(width: 8),
                      Text(
                        "Reset Password",
                        style: fontTextStyle.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  height: 1,
                  width: double.infinity,
                  color: const Color(0xFFE8EDF1),
                ),
                InkWell(
                  onTap: () {
                    logoutConfirm();
                  },
                  child: Row(
                    children: [
                      // Image.asset("assets/ic_logout.png", width: 16),
                      const SizedBox(width: 8),
                      Text(
                        "Keluar",
                        style: fontTextStyle.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future logoutConfirm() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        // contentPadding:
        //     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        contentPadding: EdgeInsets.zero,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Keluar Aplikasi",
                style: fontTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColor.black),
              ),
            ),
            const SizedBox(height: 14),
            Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: const BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Color(0xFFE8EDF1)))),
                child: Text(
                  "Yakin ingin keluar dari aplikasi?",
                  softWrap: true,
                  style: fontTextStyle.copyWith(color: AppColor.black),
                )),
          ],
        ),
        actions: [
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: const BorderSide(
                    color: Color(0xFFE8EDF1),
                  )),
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Batal',
                style: fontTextStyle.copyWith(
                    fontWeight: FontWeight.w700, color: AppColor.black),
              )),
          const SizedBox(width: 5),
          TextButton(
            onPressed: () async {
              // await Session().logout();
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (_) => const BasePage()),
              //         (Route<dynamic> route) => false);
              // showToast(
              //     context: context,
              //     msg: "Logout Berhasil");
              AuthViewmodel().logout().then((value) async {
                if (value.code == 200) {
                  await Session().logout();
                  if (!mounted) return;
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const BasePage()),
                          (Route<dynamic> route) => false);
                  showToast(
                      context: context,
                      msg: "Logout Berhasil");

                } else {
                  showToast(
                      context: context,
                      msg: "Terjadi Kesalahan");
                }
              });
            },
            style: OutlinedButton.styleFrom(
                backgroundColor: AppColor.colorPrimaryGreen,
                padding: const EdgeInsets.symmetric(horizontal: 22),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                )),
            child: Text(
              "Keluar",
              style: fontTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColor.white),
            ),
          ),
        ],
      ),
    );
  }

Users? _users;
getUserProfile() async {
  String? token = await Session().getUserToken();

  if (token != null) {
    AuthViewmodel().userDetail().then((value) {
      if (value.code == 200) {
        setState(() {
          _users = Users.fromJson(value.data);
        });
      }
    });
  }
}
}