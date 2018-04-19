package myapp;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;
import java.time.LocalDateTime;

@RestController
@RequestMapping("/")
public class HomeController {
    @RequestMapping("/")
    public String index() throws Exception {
        Logger.info("Hello World!");
        return "<h1>Hello, World!</h1><p>Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum</p>";
    }

    @SecuredArea
    @RequestMapping("/secured")
    public String secured() throws Exception {
        return "<h1>Secured Only Area</h1><p>Wow! You are in a secure area!</p>";
    }

    @SecuredArea
    @RequestMapping(path="/toUpperCase", method=RequestMethod.POST)
    public SampleResponseModel toUpperCase(@RequestBody @Valid SampleRequestModel model) throws Exception {
        SampleResponseModel responseModel = new SampleResponseModel();

        responseModel.outputData = model.inputData.toUpperCase();
        responseModel.occurredAt = LocalDateTime.now();

        return responseModel;
    }
}
