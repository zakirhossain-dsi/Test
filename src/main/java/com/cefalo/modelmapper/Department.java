package com.cefalo.modelmapper;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@ToString
@Getter
@Setter
public class Department {
    List<Student> students;
    private String name;

    Department(String name, List<Student> students){
        this.name = name;
        this.students = students;
    }
}
