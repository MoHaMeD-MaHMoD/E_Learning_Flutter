class Course {
  String  name;
  double completedPercentage;
  String author;
  String thumbnail;

  Course({
    required this.author,
    required this.completedPercentage,
    required this.name,
    required this.thumbnail,
  });
}

List<Course> courses = [
  Course(
    author: "Dr. / Abdul Hamid  Al-Agouza",
    completedPercentage: 1,
    name: "First Class",
    thumbnail: "assets/icons/first-icon.png",
  ),
  Course(
    author: "Dr. / Abdul Hamid  Al-Agouza",
    completedPercentage: 1,
    name: "Second Class",
    thumbnail: "assets/icons/second-icon.png",
  ),
  Course(
    author: "Dr. / Abdul Hamid  Al-Agouza",
    completedPercentage: 1,
    name: "Third Class",
    thumbnail: "assets/icons/third-icon.png",
  ),
  
];
