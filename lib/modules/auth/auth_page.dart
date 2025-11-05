import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/modules/auth/auth_controller.dart';
import 'package:frontend_mobile_flutter/modules/auth/otp_verification_page.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/widgets/fail_register.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/widgets/success_register.dart';
import '../../core/widgets/login_header_widget.dart';
import '../../core/app_colors.dart';
import '../../core/text_styles.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AuthController controller = Get.find<AuthController>();

  bool isLogin = true;
  bool isLoading = false;

  // Login Controllers
  final TextEditingController _emailLogin = TextEditingController();
  final TextEditingController _passwordLogin = TextEditingController();

  // Register Controllers
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _emailReg = TextEditingController();
  final TextEditingController _telp = TextEditingController();
  final TextEditingController _passwordReg = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _onLogin() async {
    if (_emailLogin.text.isEmpty || _passwordLogin.text.isEmpty) {
      Get.snackbar("Error", "Email dan password wajib diisi",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    setState(() => isLoading = true);
    final result =
        await controller.login(_emailLogin.text.trim(), _passwordLogin.text);
    setState(() => isLoading = false);

    if (result != null) {
      Get.snackbar("Login Gagal", result,
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    } else {
      Get.snackbar("Berhasil", "Login sukses!",
          backgroundColor: Colors.green, colorText: Colors.white);
      // Arahkan ke halaman utama
      Get.offAllNamed('/main');
    }
  }

  Future<void> _onRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    final result = await controller.register(
      name: _name.text.trim(),
      username: _username.text.trim(),
      email: _emailReg.text.trim(),
      telp: _telp.text.trim(),
      password: _passwordReg.text,
      confirmPassword: _confirmPassword.text,
      statusKaryawan: 1,
    );
    setState(() => isLoading = false);

    if (result != null) {
      Get.to(() => const FailRegister());
    } else {
      // ke verifikasi OTP
      Get.to(() => OtpVerificationPage(email: _emailReg.text.trim()));
      Get.snackbar("Registrasi Berhasil",
          "Silakan verifikasi email kamu sebelum login.",
          backgroundColor: Colors.green, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: isLogin ? _buildLoginView() : _buildRegisterView(),
        ),
      ),
    );
  }

  // ================= LOGIN VIEW ==================
  Widget _buildLoginView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const LoginHeaderWidget(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Masuk ke akunmu", style: TextStyles.headerMedium),
                const SizedBox(height: 24),

                // Email
                TextField(
                  controller: _emailLogin,
                  decoration: InputDecoration(
                    labelText: "Email/Username",
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 16),
                // Password
                TextFormField(
                  controller: _passwordLogin,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (v) {
                    if(v == null || v.isEmpty) {
                      return "Password tidak boleh kosong";
                    }

                    final pwdRegex = RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).{8,}$');
                    if (!pwdRegex.hasMatch(v)) {
                      return "Minimal 8 karakter, harus ada 1 uppercase, 1 simbol, dan 1 angka";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _onLogin,
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2)
                        : const Text("Masuk"),
                  ),
                ),

                const SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () => setState(() => isLogin = false),
                    child: Text.rich(
                      TextSpan(
                        text: "Belum punya akun? ",
                        style: TextStyles.bodyMedium,
                        children: [
                          TextSpan(
                            text: "Daftar sekarang",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= REGISTER VIEW ==================
  Widget _buildRegisterView() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const LoginHeaderWidget(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Buat akun baru", style: TextStyles.headerMedium),
                  const SizedBox(height: 24),

                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                      labelText: "Nama Lengkap",
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (v) =>
                        v!.isEmpty ? "Nama tidak boleh kosong" : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _username,
                    decoration: const InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Icons.account_circle_outlined),
                    ),
                    validator: (v) =>
                        v!.isEmpty ? "Username tidak boleh kosong" : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _emailReg,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (v) =>
                        v!.isEmpty ? "Email tidak boleh kosong" : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _telp,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "Nomor Telepon",
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Nomor telepon tidak boleh kosong";
                      }

                      final phoneRegex = RegExp(r'^(?:\+62|0)[0-9]{9,}$');
                      if (!phoneRegex.hasMatch(v)) {
                        return "Format nomor tidak valid (contoh: 0812xxx atau +62812xxx)";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _passwordReg,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (v) {
                      if(v == null || v.isEmpty) {
                        return "Password tidak boleh kosong";
                      }

                      final pwdRegex = RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).{8,}$');
                      if (!pwdRegex.hasMatch(v)) {
                        return "Minimal 8 karakter, harus ada 1 uppercase, 1 simbol, dan 1 angka";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _confirmPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Konfirmasi Password",
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (v) {
                      if(v == null || v.isEmpty) {
                        return "Password tidak boleh kosong";
                      }

                      final pwdRegex = RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).{8,}$');
                      if (!pwdRegex.hasMatch(v)) {
                        return "Minimal 8 karakter, harus ada 1 uppercase, 1 simbol, dan 1 angka";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _onRegister,
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2)
                          : const Text("Daftar"),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () => setState(() => isLogin = true),
                      child: Text.rich(
                        TextSpan(
                          text: "Sudah punya akun? ",
                          style: TextStyles.bodyMedium,
                          children: [
                            TextSpan(
                              text: "Masuk di sini",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
