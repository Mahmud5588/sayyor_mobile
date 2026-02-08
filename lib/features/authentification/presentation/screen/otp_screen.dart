import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sayyor/core/routes/app_router.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/themes/app_textstyles.dart';
import 'package:sayyor/core/widgets/error_dialog.dart';
import 'package:sayyor/features/authentification/presentation/screen/auth_success_screen.dart';
import 'package:sayyor/features/authentification/presentation/bloc/auth_bloc.dart';
import 'package:sayyor/features/authentification/presentation/bloc/auth_event.dart';
import 'package:sayyor/features/authentification/presentation/bloc/auth_state.dart';

enum AuthFlow { login, register }

class OtpArgs {
  final String phone;
  final AuthFlow flow;
  final String? name;
  final String? role;

  const OtpArgs({
    required this.phone,
    required this.flow,
    this.name,
    this.role,
  });
}

class OtpScreen extends StatefulWidget {
  final OtpArgs args;

  const OtpScreen({super.key, required this.args});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(
      VerifyOtpEvent(
        phone: widget.args.phone,
        code: _codeController.text.trim(),
        name: widget.args.flow == AuthFlow.register ? widget.args.name : null,
        role: widget.args.flow == AuthFlow.register ? widget.args.role : null,
      ),
    );
  }

  void _resendOtp() {
    // OTP qayta yuborish - flow'ga mos isLogin parametrini yuborish
    context.read<AuthBloc>().add(
      SendOtpEvent(
        phone: widget.args.phone,
        isLogin: widget.args.flow == AuthFlow.login,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                // ✅ MUVAFFAQIYAT: Token'ni saqlash
                // TODO: SharedPreferences'ga saqlash kerak

                AppSnackBar.showSuccess(context, state.authEntity.message);

                // Home page'ga o'tish
                if (widget.args.flow == AuthFlow.register) {
                  // Register'dan keyin success ekraniga
                  context.go(
                    AppRoutes.authSuccess,
                    extra: AuthSuccessArgs(
                      name: state.authEntity.user?.name ?? '',
                      role: state.authEntity.user?.role ?? '',
                    ),
                  );
                } else {
                  // Login'dan keyin to'g'ridan to'g'ri home'ga
                  context.go(AppRoutes.home);
                }
              }
              if (state is AuthFailure) {
                // ❌ XATO: Chiroyli error dialog
                AppErrorDialog.show(context, state.message);
              }
              if (state is AuthSendOtpSuccess) {
                // 📨 OTP qayta yuborildi
                AppSnackBar.showInfo(context, state.result.message);
              }
            },
            builder: (context, state) {
              final loading = state is AuthLoading;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSizes.xl),
                  Text('otp_title'.tr(), style: AppTextStyles.h1),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    'otp_subtitle'.tr(args: [widget.args.phone]),
                    style: AppTextStyles.bodySm,
                  ),
                  const SizedBox(height: AppSizes.xl),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'otp_label'.tr(),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        final v = value?.trim() ?? '';
                        if (v.isEmpty) return 'otp_required'.tr();
                        if (v.length != 6) return 'otp_invalid'.tr();
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: AppSizes.lg),
                  SizedBox(
                    width: double.infinity,
                    height: AppSizes.buttonHeight,
                    child: FilledButton(
                      onPressed: loading ? null : _verifyOtp,
                      child: loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              'verify_otp'.tr(),
                              style: AppTextStyles.body.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.md),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: loading ? null : _resendOtp,
                      child: Text('resend_otp'.tr()),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
