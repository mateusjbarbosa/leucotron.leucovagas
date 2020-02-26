class Job {
  String id;
  String name;
  String role;
  List<dynamic> requirements;
  List<dynamic> skills;

  Job({this.id, this.name, this.role, this.requirements, this.skills});

  Job.fromMap(Map m, String id) {
    id = id ?? '';
    name = m['name'] ?? '';
    role = m['role'] ?? '';
    requirements = m['requirements'] ?? '';
    skills = m['skills'] ?? '';
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
