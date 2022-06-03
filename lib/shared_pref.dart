import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storeged/main.dart';
import 'package:flutter_storeged/model/models.dart';
import 'package:flutter_storeged/services/local_storege_services.dart';

class SharedPref extends StatefulWidget {
  const SharedPref({Key? key}) : super(key: key);

  @override
  State<SharedPref> createState() => _SharedPrefState();
}

class _SharedPrefState extends State<SharedPref> {
  var _secilenCinsiyet = Cinsiyet.KADIN;
  var _secilenRenkler = <String>[];
  var _ogrenciMi = false;
  final TextEditingController _nameController = TextEditingController();
  //final LocalStorageServices _preferencesServices = FileStoregeServices();
  // final LocalStorageServices _preferencesServices2 = SecureStoregedServices();
  final LocalStorageServices _preferencesServices3 =
      locator<LocalStorageServices>();
  @override
  void initState() {
    super.initState();
    _verileriOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter shared preference"),
      ),
      body: ListView(children: [
        ListTile(
          title: TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Type your name"),
          ),
        ),
        for (var item in Cinsiyet.values)
          _buildRadioListTile(describeEnum(item).toString(), item),
        for (var item in Renkler.values) _buildCheckBox(item),
        SwitchListTile(
          title: const Text("Ogrenci Misin ?"),
          value: _ogrenciMi,
          onChanged: (bool ogrenciMi) {
            setState(() {
              _ogrenciMi = ogrenciMi;
            });
          },
        ),
        TextButton(
          onPressed: () {
            var _userInformation = UserInformation(_nameController.text,
                _secilenCinsiyet, _secilenRenkler, _ogrenciMi);
            _preferencesServices3.saveData(_userInformation);
          },
          child: const Text("Kaydet"),
        ),
      ]),
    );
  }

  Widget _buildRadioListTile(String title, Cinsiyet cinsiyet) {
    return RadioListTile(
        title: Text(title),
        value: cinsiyet,
        groupValue: _secilenCinsiyet,
        onChanged: (Cinsiyet? selectedCinsiyet) {
          setState(() {
            _secilenCinsiyet = selectedCinsiyet!;
          });
        });
  }

  Widget _buildCheckBox(Renkler renkler) {
    return CheckboxListTile(
        title: Text(
          describeEnum(renkler),
        ),
        value: _secilenRenkler.contains(
          describeEnum(renkler),
        ),
        onChanged: (bool? deger) {
          if (deger == false) {
            _secilenRenkler.remove(
              describeEnum(renkler),
            );
          } else {
            _secilenRenkler.add(describeEnum(renkler));
          }
          setState(() {});
        });
  }

  void _verileriOku() async {
    var info = await _preferencesServices3.readData();
    _nameController.text = info.isim;
    _secilenCinsiyet = info.cinsiyet;
    _secilenRenkler = info.renkler;
    _ogrenciMi = info.ogrenciMi;
    setState(() {});
  }
}
