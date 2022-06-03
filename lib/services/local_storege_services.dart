import '../model/models.dart';

abstract class LocalStorageServices {
  Future<void> saveData(UserInformation userInformation);
  Future<UserInformation> readData();
}
