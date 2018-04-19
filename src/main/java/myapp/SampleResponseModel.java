package myapp;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

public class SampleResponseModel {
    public String outputData;
    
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    public LocalDateTime occurredAt;
}
