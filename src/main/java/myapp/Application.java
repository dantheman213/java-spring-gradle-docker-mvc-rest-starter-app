package myapp;

import java.util.Arrays;
import java.util.HashMap;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@SpringBootApplication
@EnableAspectJAutoProxy
public class Application {

    public static void main(String[] args) throws Throwable {
        try {
          Config config = new Config();
        } catch(Exception ex) {
          System.out.println("Unable to read env config!");
          ex.printStackTrace();
          System.exit(1);
        }

        Logger.info("Starting application!");

        HashMap<String, Object> props = new HashMap<>();
        props.put("server.port", Config.port);

        new SpringApplicationBuilder()
                .sources(Application.class)
                .properties(props)
                .run(args);
    }

}
