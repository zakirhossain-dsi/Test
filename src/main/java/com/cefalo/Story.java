package com.cefalo;

import lombok.*;

@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Story {
    private String _id;
    private String created_date;
    private Headline headlines;
    private String subtitle;
}

