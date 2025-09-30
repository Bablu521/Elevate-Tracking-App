enum Gender { female, male }

Gender genderFromString(String gender) {
  switch (gender.toLowerCase()) {
    case "male":
      return Gender.male;
    case "female":
      return Gender.female;
    default:
      return Gender.male;
  }
}
