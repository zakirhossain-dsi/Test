package com.cefalo;

import lombok.*;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RevisionResponse {
    String _id;
    Date last_updated_date;
    Date created_date;
    Headlines headlines;
    Revision revision;
    String type;
}

