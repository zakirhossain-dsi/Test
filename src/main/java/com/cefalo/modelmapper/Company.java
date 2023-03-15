package com.cefalo.modelmapper;

import lombok.*;

import java.util.List;

@ToString
@Getter
@Setter
@NoArgsConstructor
public class Company {
    List<Employee> students;

    private String name;

    Company(String name, List<Employee> students){
        this.name = name;
        this.students = students;
    }
}
