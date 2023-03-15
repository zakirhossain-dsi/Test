package com.cefalo.modelmapper;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@ToString
@Getter
@Setter
public class Student {
    private String name;

    Student(String name){
        this.name = name;
    }
}
