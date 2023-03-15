package com.cefalo;

import lombok.*;

import java.util.List;

@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Response {
    private String type;
    private String version;
    private List<Story> content_elements;
}
