import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sayyor/core/routes/app_router.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/themes/app_textstyles.dart';
import 'package:sayyor/core/widgets/error_dialog.dart';
import 'package:sayyor/features/authentification/presentation/screen/otp_screen.dart';
import 'package:sayyor/features/authentification/presentation/bloc/auth_bloc.dart';
import 'package:sayyor/features/authentification/presentation/bloc/auth_event.dart';
import 'package:sayyor/features/authentification/presentation/bloc/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _role = 'client';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(
      SendOtpEvent(phone: _phoneController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSendOtpSuccess) {
                // ✅ MUVAFFAQIYAT: OTP yuborildi
                AppSnackBar.showSuccess(context, state.result.message);
                context.go(
                  AppRoutes.otp,
                  extra: OtpArgs(
                    phone: _phoneController.text.trim(),
                    flow: AuthFlow.register,
                    name: _nameController.text.trim(),
                    role: _role,
                  ),
                );
              }
              if (state is AuthFailure) {
                // ❌ XATO: Chiroyli error dialog ko'rsatish
                AppErrorDialog.show(context, state.message);
              }
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSizes.xl),
                  Text('register_title'.tr(), style: AppTextStyles.h1),
                  const SizedBox(height: AppSizes.sm),
                  Text('register_subtitle'.tr(), style: AppTextStyles.bodySm),
                  const SizedBox(height: AppSizes.xl),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'name_label'.tr(),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if ((value ?? '').trim().isEmpty) {
                              return 'name_required'.tr();
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSizes.md),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'phone_label'.tr(),
                            hintText: '+998 90 123 45 67',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            final v = value?.trim() ?? '';
                            if (v.isEmpty) return 'phone_required'.tr();
                            if (v.length < 10) return 'phone_invalid'.tr();
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSizes.md),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'role_label'.tr(),
                              style: AppTextStyles.bodySm,
                            ),
                            const SizedBox(height: AppSizes.sm),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    value: 'client',
                                    groupValue: _role,
                                    onChanged: (value) {
                                      setState(() => _role = value ?? 'client');
                                    },
                                    title: Text('role_client'.tr()),
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    value: 'master',
                                    groupValue: _role,
                                    onChanged: (value) {
                                      setState(() => _role = value ?? 'master');
                                    },
                                    title: Text('role_master'.tr()),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.lg),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            final loading = state is AuthLoading;
                            return SizedBox(
                              width: double.infinity,
                              height: AppSizes.buttonHeight,
                              child: FilledButton(
                                onPressed: loading ? null : _sendOtp,
                                child: loading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        'send_otp'.tr(),
                                        style: AppTextStyles.body.copyWith(
                                          color: colorScheme.onPrimary,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.md),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () => context.go(AppRoutes.login),
                      child: Text('have_account'.tr()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
