package com.it.ceb.util.common.exceptions;

import java.nio.file.NoSuchFileException;

public class ExceptionHandler {
    //define a static methods
    public static String handleException(Exception e) {
        if (!(e instanceof AlreadyExistingException)
                && !(e instanceof NoSuchFileException)
                && !(e instanceof ConfigException)) {
                    return "Unknown error";
                }
        return e.getMessage();
    }

    public static void routeException(Exception e) throws AlreadyExistingException, NoSuchFileException, ConfigException {
        if (e instanceof AlreadyExistingException) {
            throw (AlreadyExistingException) e;
        } else if (e instanceof NoSuchFileException) {
            throw (NoSuchFileException) e;
        } else if (e instanceof ConfigException) {
            throw (ConfigException) e;
        } else {
            throw new RuntimeException("Unexpected exception occurred", e);
        }
    }

}
