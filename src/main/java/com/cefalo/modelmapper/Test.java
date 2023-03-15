package com.cefalo.modelmapper;

import org.modelmapper.Converter;
import org.modelmapper.ModelMapper;
import org.modelmapper.PropertyMap;
import org.modelmapper.spi.MappingContext;

import java.util.List;

public class Test {
    public static void main(String[] args) {
        Student s1 = new Student("Zakir");
        Department d1 = new Department("ict", List.of(s1));

        ModelMapper modelMapper = new ModelMapper();

        Converter<Student, Employee> studentEmployeeConverter = mappingContext -> {
            System.out.println("Converting....");
            Student student = mappingContext.getSource();
            Employee employee = new Employee();
            employee.setFirstName(student.getName());

            return employee;
        };

        PropertyMap<Student, Employee> studentEmployeeMap = new PropertyMap <>() {
            protected void configure() {
                System.out.println("Mapping....");
                map().setFirstName(source.getName());
                skip();
            }
        };
        modelMapper.addConverter(studentEmployeeConverter, Student.class, Employee.class);
        //modelMapper.addMappings(studentEmployeeMap);
        Company company = modelMapper.map(d1, Company.class);
        System.out.println(company);
    }
}
