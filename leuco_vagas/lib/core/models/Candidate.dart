class Candidate {
  String id;
  String name;
  String age;
  String course;
  String college;
  List<dynamic> experience;
  List<dynamic> skills;

  Candidate(
      {this.id,
      this.name,
      this.age,
      this.course,
      this.college,
      this.experience,
      this.skills});

  Candidate.fromMap(Map m, String id) {
    this.id = id ?? '';
    this.name = m['name'] ?? '';
    this.age = m['age'] ?? '';
    this.course = m['course'] ?? '';
    this.college = m['college'] ?? '';
    this.experience = m['experience'] ?? '';
    this.skills = m['skills'] ?? '';
  }

  toJson() {
    return {
      "name": name,
      "age": age,
      "course": course,
      "college": college,
      "experience": experience,
      "skills": skills,
    };
  }
}
