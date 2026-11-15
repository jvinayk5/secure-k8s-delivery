package com.example.demo;

import java.util.Map;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class InfoController {

    @Value("${app.version:dev}")
    private String version = "dev";

    @Value("${app.environment:local}")
    private String environment = "local";

    @GetMapping("/")
    public Map<String, String> info() {
        return Map.of("service", "spring-service", "version", version, "environment", environment);
    }
}
