class Employee{
  String id;
  String firstName;
  String lastName;
  String datatreino;

  Employee({this.id,this.firstName,this.lastName,this.datatreino});

  factory Employee.fromJson(Map<String, dynamic>json){
    return Employee(
      id:json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      datatreino: json['data_treino'] as String,
    );
  }
}