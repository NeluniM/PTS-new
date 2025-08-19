package com.it.ceb.util.common.exceptions;

public class AlreadyExistingException extends RuntimeException {
    public AlreadyExistingException() {
        super("Not allowed! This record already exists");
    }
}
