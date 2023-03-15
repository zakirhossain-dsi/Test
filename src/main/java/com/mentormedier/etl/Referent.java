package com.mentormedier.etl;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Referent {
    private String id;
    private String provider;
    private String type;
    private String website;
}
