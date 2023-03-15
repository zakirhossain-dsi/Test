package com.cefalo;

import com.amazonaws.util.CollectionUtils;
import lombok.Getter;
import lombok.Setter;

import java.util.Collections;
import java.util.List;

@Getter
@Setter
class Person{
    private String name;
    private boolean isAdult;
    private int age;

    public Person(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Person{" +
                "name='" + name + '\'' +
                '}';
    }

    public static void main(String[] args) {
        List<String> names = Collections.singletonList("zakir");
        names.add("Parveen");
        System.out.println(names);
    }
}
