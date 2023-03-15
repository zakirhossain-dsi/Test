package com.cefalo;

import java.util.Comparator;

public final class PhoneNumber {

    // Comparable with comparator construction methods
    private static final Comparator<PhoneNumber> COMPARATOR =
            Comparator.comparingInt((PhoneNumber pn) -> pn.areaCode)
                    .thenComparingInt(pn -> pn.prefix)
                    .thenComparingInt(pn -> pn.lineNum);

    private final short areaCode, prefix, lineNum;

    public PhoneNumber(short areaCode, short prefix, short lineNum) {
        this.areaCode = areaCode;
        this.prefix = prefix;
        this.lineNum = prefix;
    }

    public int compareTo(PhoneNumber pn) {
        return COMPARATOR.compare(this, pn);
    }
}
