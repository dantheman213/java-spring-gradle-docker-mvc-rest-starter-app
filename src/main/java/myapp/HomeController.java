package myapp;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
@RequestMapping("/")
public class HomeController {
    @RequestMapping("/")
    public String index() {
        return "<h1>Hello, World!</h1><p>Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum</p>";
    }

    @SecuredArea
    @RequestMapping("/secured")
    public String secured() {
        return "<h1>Secured Only Area</h1><p>Wow! You are in a secure area!</p>";
    }
}
