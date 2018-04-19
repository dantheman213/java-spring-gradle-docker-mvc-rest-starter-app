package myapp;

import javax.validation.constraints.NotEmpty;

public class SampleRequestModel {
    //@JsonProperty("input_data") // if alias is needed for field
    @NotEmpty(message="Input data cannot be null.")
    public String inputData;
}
