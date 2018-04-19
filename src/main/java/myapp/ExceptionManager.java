package myapp;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;
import org.springframework.security.access.AccessDeniedException;

import javax.validation.ConstraintViolationException;

// All exceptions for the application are routed here to be logged internally and presented to the client.
// Reference: http://www.baeldung.com/global-error-handler-in-a-spring-rest-api

@ControllerAdvice
public class ExceptionManager extends ResponseEntityExceptionHandler {

    // This will be thrown if @SecuredArea validation in a given route fails
    @ExceptionHandler({AccessDeniedException.class})
    public ResponseEntity<String> handleAccessDeniedException(Exception ex, WebRequest request) {
        Logger.security("Access denied occurred!");

        // What the client will see
        return new ResponseEntity<String>("Invalid credentials. Access is denied.", new HttpHeaders(), HttpStatus.UNAUTHORIZED); // HTTP 401
    }

    // Bad request exception handling #1
    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        Logger.info("Bad request occurred!");

        // What the client will see
        return new ResponseEntity<Object>("Invalid data or fields sent. Bad request.", new HttpHeaders(), HttpStatus.BAD_REQUEST); // HTTP 400
    }

    // Bad request exception handling #2
    @ExceptionHandler({ConstraintViolationException.class})
    public ResponseEntity<String> handleConstraintViolationException(Exception ex, WebRequest request) {
        Logger.info("Bad request occurred!");

        // What the client will see
        return new ResponseEntity<String>("Invalid data or fields sent. Bad request.", new HttpHeaders(), HttpStatus.BAD_REQUEST); // HTTP 400
    }

    // Bad request exception handling #3
    @Override
    protected ResponseEntity<Object> handleMissingServletRequestParameter(MissingServletRequestParameterException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        Logger.info("Bad request occurred!");

        // What the client will see
        return new ResponseEntity<Object>("Invalid data or fields sent. Bad request.", new HttpHeaders(), HttpStatus.BAD_REQUEST); // HTTP 400
    }

    // Bad request exception handling #4
    @ExceptionHandler({MethodArgumentTypeMismatchException.class})
    public ResponseEntity<Object> handleMethodArgumentTypeMismatch(MethodArgumentTypeMismatchException ex, WebRequest request) {
        Logger.info("Bad request occurred!");

        // What the client will see
        return new ResponseEntity<Object>("Invalid data or fields sent. Bad request.", new HttpHeaders(), HttpStatus.BAD_REQUEST); // HTTP 400
    }

    // Bad request exception handling #5
    @Override
    protected ResponseEntity<Object> handleHttpMessageNotReadable(HttpMessageNotReadableException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        Logger.info("Bad request occurred!");

        // What the client will see
        return new ResponseEntity<Object>("Invalid data or fields sent. Bad request.", new HttpHeaders(), HttpStatus.BAD_REQUEST); // HTTP 400
    }

    // General exceptions
    @ExceptionHandler({Exception.class})
    public ResponseEntity<String> handleGeneralException(Exception ex, WebRequest request) {
        // What the system administrator will see internally
        ex.printStackTrace();

        // What the client will see
        return new ResponseEntity<String>("A general exception has occurred.", new HttpHeaders(), HttpStatus.INTERNAL_SERVER_ERROR); // HTTP 500
    }
}
