package myapp;

import java.util.HashMap;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@EnableAspectJAutoProxy
@SpringBootApplication
@EnableWebMvc
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

    // Enable 404 not found error catching
    @Bean
    public DispatcherServlet dispatcherServlet() {
        DispatcherServlet dispatcher = new DispatcherServlet();
        dispatcher.setThrowExceptionIfNoHandlerFound(true);

        return dispatcher;
    }

}
