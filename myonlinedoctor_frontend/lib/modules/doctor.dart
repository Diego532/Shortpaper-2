import './specialty.dart';

class Doctor {
  String image = '';
  String name = '';
  String lastname = '';
  List<Specialty> specialty = [];

  Doctor(this.image, this.name, this.lastname, this.specialty);
}
