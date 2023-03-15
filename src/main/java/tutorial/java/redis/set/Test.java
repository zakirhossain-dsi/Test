package tutorial.java.redis.set;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

public class Test {
    public static void main(String[] args) {

        Set<Employee> employees1 = new HashSet<>();

        Employee e1 = new Employee("zakir", 30, "a");
        Employee e2 = new Employee("zakir", 30, "xxx");

        employees1.add(e1);

        Set<Employee> employees2 = new HashSet<>();
        employees2.add(e2);

        employees1.addAll(employees2);

        System.out.println(employees1);

    }
}

@Data
@AllArgsConstructor
class Employee{
    private String name;
    private Integer age;
    private String district;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Employee employee = (Employee) o;
        return Objects.equals(name, employee.name) && Objects.equals(age, employee.age);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, age);
    }
}
