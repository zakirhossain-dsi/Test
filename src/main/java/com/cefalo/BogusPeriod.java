
package com.cefalo;

import java.io.*;

public class BogusPeriod {
    // Byte stream couldn't have come from a real Period instance!
    private static final byte[] serializedForm = {
            -84,-19,0,5,115,114,0,17,99,111,109,46,99,
            101,102,97,108,111,46,80,101,114,105,111,
            100,54,-71,95,-96,-11,89,10,83,2,0,2,76,0,
            3,101,110,100,116,0,16,76,106,97,118,97,47,
            117,116,105,108,47,68,97,116,101,59,76,0,5,
            115,116,97,114,116,113,0,126,0,1,120,112,115,
            114,0,14,106,97,118,97,46,117,116,105,108,46,
            68,97,116,101,104,106,-127,1,75,89,116,25,3,0,
            0,120,112,119,8,0,0,1,112,-66,125,72,-99,120,
            115,113,0,126,0,3,119,8,0,0,1,112,-66,125,72,
            -99,120
    };

    public static void main(String[] args) {
        Period p = (Period) deserialize(serializedForm);
        System.out.println(p);
    }

    // Returns the object with the specified serialized form
    static Object deserialize(byte[] serializedForm) {
        try {
            return new ObjectInputStream(new ByteArrayInputStream(serializedForm)).readObject();
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }
}
