package com.cefalo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Revision implements Serializable {
    String revision_id;
    String parent_id;
    String branch;
    int index;

    public Revision(String parent_id){
        this.parent_id = parent_id;
    }
}

