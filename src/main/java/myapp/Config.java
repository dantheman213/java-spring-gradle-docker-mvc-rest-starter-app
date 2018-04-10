package myapp;

public class Config {
    private static boolean isset = false;

    // List of configuration options for your application
    public static int port;
    public static String environment = null;

    public Config() throws Exception {
        if(!isset) {
            Logger.info("Loading application configuration from environment");

            port = Integer.parseInt(System.getenv("APP_PORT"));
            environment = System.getenv("ENVIRONMENT"); // 'DEV' or 'PROD'

            isset = true;
        }
    }
}
