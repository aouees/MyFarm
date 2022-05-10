import 'package:myfarm/modal/farm.dart';
import 'package:test/test.dart';

void main() {
  test('test convert method -- object from ( farm ) to Map -- ', () {
    final Farm farm = new Farm(name: "FamilyFarm", numH: 5, numW: 5);

    var maptest = farm.toMap();

    expect(maptest, {'name': "FamilyFarm", 'numH': 5, 'numW': 5});
  });
///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
  test(
    'test convert method -- map to object  from ( farm ) --',
    () {
      Farm res = Farm.fromMap({'name': "Farm1", 'numH': 10, 'numW': 5});
      expect(res, new Farm(name: "Farm1", numH: 10, numW: 5));
    },
  );
}
