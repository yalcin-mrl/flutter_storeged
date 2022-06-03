import 'package:flutter_storeged/model/models.dart';
import 'package:flutter_storeged/services/local_storege_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices implements LocalStorageServices {
  late final SharedPreferences preferences;
  SharedPrefServices() {
    init();
  }

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveData(UserInformation userInformation) async {
    final _name = userInformation.isim;

    preferences.setString('name', _name);
    preferences.setBool('ogrenci', userInformation.ogrenciMi);
    preferences.setInt('cinsiyet', userInformation.cinsiyet.index);
    preferences.setStringList('renkler', userInformation.renkler);
  }

  @override
  Future<UserInformation> readData() async {
    var _isim = preferences.getString('name') ?? '';
    var _ogrenci = preferences.getBool('ogrenci') ?? false;
    var _cinsiyet = Cinsiyet.values[preferences.getInt('cinsiyet') ?? 0];
    var _renkler = preferences.getStringList('renkler') ?? <String>[];
    return UserInformation(_isim, _cinsiyet, _renkler, _ogrenci);
  }
}
