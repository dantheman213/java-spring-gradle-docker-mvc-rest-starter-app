package myapp;

import java.util.UUID;

public class Logger {
    public static ErrorType ErrorType;

    private String id = null;

    public enum ErrorType {
        ERROR,
        DEBUG,
        INFO,
        WARNING,
        CRITICAL
    };

    public Logger() {
        id = generateIdentifier();
    }

    public Logger(ErrorType type, String logMessage) {
        id = generateIdentifier();
        message(type, logMessage);
    }

    public void message(ErrorType type, String logMessage) {
        System.out.println(String.format("[%s %s] %s", type.toString(), id, logMessage));
    }

    public static void debug(String logMessage) {
        System.out.println(String.format("[%s] %s", "DEBUG", logMessage));
    }

    public static void error(String logMessage) {
        System.out.println(String.format("[%s] %s", "ERROR", logMessage));
    }

    public static void info(String logMessage) {
        System.out.println(String.format("[%s] %s", "INFO", logMessage));
    }

    public static void warning(String logMessage) {
        System.out.println(String.format("[%s] %s", "WARNING", logMessage));
    }

    public static void critical(String logMessage) {
        System.out.println(String.format("[%s] %s", "CRITICAL", logMessage));
    }

    private String generateIdentifier() {
        return UUID.randomUUID().toString().replaceAll("-", "").substring(0, 10);
    }
}
