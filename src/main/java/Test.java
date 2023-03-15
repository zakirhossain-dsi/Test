import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.commons.lang3.math.NumberUtils;

import java.time.Instant;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public class Test{
    public static void main(String[] args) {

        Map<String, Integer> nameToAge = Map.of("zakir", 1, "nishat", 2);
        System.out.println(
                nameToAge.keySet().stream().collect(Collectors.toMap(name -> name, name -> 0))
        );
        /*
        Predicate<Student> PREDICATE_ICT = student -> "ICT".equals(student.getDept());
        Predicate<Student> PREDICATE_MBSTU = student -> "MBSTU".equals(student.getUniversity());

        List<Student> ictStudents = students.stream().filter(PREDICATE_ICT).collect(Collectors.toList());
        System.out.println(ictStudents);

        List<Student> mbstuIctStudents = students.stream().filter(PREDICATE_MBSTU).collect(Collectors.toList());
        System.out.println(mbstuIctStudents);
        */

        /*
        Map<String, List<Student>> result =
                students.stream().collect(
                        Collectors.groupingBy(student -> student.getDept(), Collectors.toList())
                );
        */

    }

    public List<Student> getStudents(){
        List<Student> students = new ArrayList<>();
        students.add(new Student("MBSTU", "ICT", "zakir"));
        students.add(new Student("MBSTU", "ICT", "Jakir"));
        students.add(new Student("MBSTU", "ICT", "Amir"));
        students.add(new Student("MBSTU", "ICT", "Sabina"));
        students.add(new Student("MBSTU", "ICT", "Liton"));
        students.add(new Student("MBSTU", "CSE", "Ripon"));
        students.add(new Student("MBSTU", "CSE", "Rahim"));
        students.add(new Student("MBSTU", "CSE", "Karim"));
        students.add(new Student("MBSTU", "CSE", "Setu"));
        students.add(new Student("MBSTU", "CSE", "Sami"));
        students.add(new Student("KU", "Pharmacy", "Nishat"));
        students.add(new Student("KU", "Pharmacy", "Dipa"));
        students.add(new Student("KU", "Pharmacy", "Sabbir"));
        students.add(new Student("KU", "Pharmacy", "Shoan"));
        students.add(new Student("KU", "Pharmacy", "Maisha"));
        students.add(new Student("KU", "ESRM", "Rimon"));
        students.add(new Student("KU", "ESRM", "Tamim"));
        students.add(new Student("KU", "ESRM", "Parves"));
        students.add(new Student("KU", "ESRM", "Mahim"));
        students.add(new Student("KU", "ESRM", "Fahim"));
        return students;
    }

    @AllArgsConstructor
    @Getter
    @Setter
    @ToString
    class Student{
        private String university;
        private String dept;
        private String name;
    }
}
