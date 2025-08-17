package com.financetracker.backend.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

  @Bean
  public SecurityFilterChain security(HttpSecurity http) throws Exception {
    http.csrf(csrf -> csrf.disable()) // disable CSRF for simplicity
        .authorizeHttpRequests(
            auth ->
                auth.requestMatchers("/actuator/health", "/actuator/health/**")
                    .permitAll() // open health endpoint
                    .anyRequest()
                    .authenticated() // secure everything else
            )
        .httpBasic(Customizer.withDefaults()); // basic auth for other endpoints

    return http.build();
  }
}
