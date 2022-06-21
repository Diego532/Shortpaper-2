import './specialty.dart';

class Doctor {
  String image = '';
  String name = '';
  String lastname = '';
  Specialty specialty = Specialty('');

  Doctor(this.image, this.name, this.lastname, this.specialty);
}
