package com.mycompany.app.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AppController {
    @RequestMapping("/")
    public String index() {
        return "Greetings from Spring Boot!";
    }
}
