package com.mentormedier.etl;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
@NoArgsConstructor
public class Article {
    private final Map<String, Website> websites = new HashMap<>();
}
