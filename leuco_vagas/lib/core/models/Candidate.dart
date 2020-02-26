class Candidate {
  String id;
  String jobId;
  String name;
  String age;
  String course;
  String college;
  List<dynamic> emails;
  List<dynamic> cellphones;
  List<dynamic> experience;
  List<dynamic> skills;

  Candidate({
    this.id,
    this.jobId,
    this.name,
    this.age,
    this.course,
    this.college,
    this.emails,
    this.cellphones,
    this.experience,
    this.skills,
  });

  Candidate.fromMap(Map m, String id) {
    this.id = id ?? '';
    this.jobId = m['jobId'] ?? '';
    this.name = m['name'] ?? '';
    this.age = m['age'] ?? '';
    this.course = m['course'] ?? '';
    this.college = m['college'] ?? '';
    this.emails = m['emails'] ?? '';
    this.cellphones = m['cellphones'] ?? '';
    this.experience = m['experience'] ?? '';
    this.skills = m['skills'] ?? '';
  }

  toJson() {
    return {
      "jobId": jobId,
      "name": name,
      "age": age,
      "course": course,
      "college": college,
      "emails": emails,
      "cellphones": cellphones,
      "experience": experience,
      "skills": skills,
    };
  }
}
