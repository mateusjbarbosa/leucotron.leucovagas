class Job {
  String id;
  String name;
  String role;
  List<dynamic> requirements;
  List<dynamic> skills;

  Job({this.id, this.name, this.role, this.requirements, this.skills});

  Job.fromMap(Map m, String id) {
    this.id = id ?? '';
    this.name = m['name'] ?? '';
    this.role = m['role'] ?? '';
    this.requirements = m['requirements'] ?? '';
    this.skills = m['skills'] ?? '';
  }

  toJson() {
    return {
      "name": name,
      "role": role,
      "requirements": requirements,
      "skills": skills,
    };
  }
}
