package com.cefalo;

import lombok.Builder;
import lombok.Value;

import java.io.Serializable;

@Value
@Builder
public class Headlines implements Serializable {
    String basic;
}
