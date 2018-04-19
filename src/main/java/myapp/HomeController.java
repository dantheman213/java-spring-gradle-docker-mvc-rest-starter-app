package myapp;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.time.LocalDateTime;

@RestController
@RequestMapping("/")
public class HomeController {

    // This is a basic route and you manually control the raw response. Not secured.
    @RequestMapping("/")
    public String index() throws Exception {
        Logger.info("Hello World!");
        return "<h1>Hello, World!</h1><p>Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum</p>";
    }

    // This is a basic route and you manually control the raw response. SECURED.
    @SecuredArea
    @RequestMapping("/secured")
    public String secured() throws Exception {
        return "<h1>Secured Only Area</h1><p>Wow! You are in a secure area!</p>";
    }

    // This is a POST route that utilizes data models for the REQUEST and RESPONSE entities.
    // Data is transformed from raw JSON into structured models for you to use, manipulate, and send back to the client which
    // will then be transformed back into raw JSON. SECURED. Responds with HTTP 201 on success.
    @SecuredArea
    @ResponseStatus(HttpStatus.CREATED) // HTTP 201. If you need to fine-tune your default success status to the client
    @RequestMapping(path="/toUpperCase", method=RequestMethod.POST)
    public SampleResponseModel toUpperCase(@RequestBody @Valid SampleRequestModel model) throws Exception {
        SampleResponseModel responseModel = new SampleResponseModel();

        responseModel.outputData = model.inputData.toUpperCase();
        responseModel.occurredAt = LocalDateTime.now();

        return responseModel;
    }
}
