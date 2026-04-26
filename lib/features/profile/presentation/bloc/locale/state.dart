import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sayyor/core/storage/localstorage.dart';

class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit(this._storage) : super(_parse(_storage.localeCode));

  final LocalStorage _storage;

  static Locale? _parse(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return Locale(value);
  }

  Future<void> setLocale(Locale? locale) async {
    emit(locale);
    await _storage.setLocaleCode(locale?.languageCode);
  }
}
