package com.objectmentor.utilities.args;

import org.apache.commons.lang.ArrayUtils;

import java.util.Iterator;
import java.util.NoSuchElementException;

import static com.objectmentor.utilities.args.ArgsException.ErrorCode.MISSING_STRING;

public class StringArrayArgumentMarshaler implements ArgumentMarshaler {
    private String stringValue = "";

    public void set(Iterator<String> currentArgument) throws ArgsException {
        try {
            stringValue = currentArgument.next();
        } catch (NoSuchElementException e) {
            throw new ArgsException(MISSING_STRING);
        }
    }

    public static String[] getValue(ArgumentMarshaler am) {
        if (am instanceof StringArrayArgumentMarshaler)
            return null;
            //return ((StringArrayArgumentMarshaler) am).stringValue;
        else
            return ArrayUtils.EMPTY_STRING_ARRAY;
    }
}
