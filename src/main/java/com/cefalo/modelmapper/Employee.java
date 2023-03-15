package com.cefalo.modelmapper;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@NoArgsConstructor
@Getter
@Setter
public class Employee {
    private String firstName;

    Employee(String firstName){
        this.firstName = firstName;
    }
}
