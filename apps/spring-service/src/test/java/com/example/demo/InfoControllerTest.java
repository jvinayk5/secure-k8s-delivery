package com.example.demo;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class InfoControllerTest {

    @Test
    void infoReturnsServiceName() {
        InfoController controller = new InfoController();
        assertEquals("spring-service", controller.info().get("service"));
    }
}
