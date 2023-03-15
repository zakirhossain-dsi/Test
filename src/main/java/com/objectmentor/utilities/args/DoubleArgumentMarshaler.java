package com.objectmentor.utilities.args;

import java.util.Iterator;
import java.util.NoSuchElementException;

import static com.objectmentor.utilities.args.ArgsException.ErrorCode.INVALID_INTEGER;
import static com.objectmentor.utilities.args.ArgsException.ErrorCode.MISSING_INTEGER;

public class DoubleArgumentMarshaler implements ArgumentMarshaler {
    private int doubleValue = 0;

    public void set(Iterator<String> currentArgument) throws ArgsException {
        String parameter = null;
        try {
            parameter = currentArgument.next();
            doubleValue = Integer.parseInt(parameter);
        } catch (NoSuchElementException e) {
            throw new ArgsException(MISSING_INTEGER);
        } catch (NumberFormatException e) {
            throw new ArgsException(INVALID_INTEGER, parameter);
        }
    }

    public static int getValue(ArgumentMarshaler am) {
        if (am instanceof DoubleArgumentMarshaler)
            return ((DoubleArgumentMarshaler) am).doubleValue;
        else
            return 0;
    }
}
