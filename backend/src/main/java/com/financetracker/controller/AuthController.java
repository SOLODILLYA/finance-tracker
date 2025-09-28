package com.financetracker.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
  @GetMapping("/register")
  public String register(@RequestBody AuthRequest request) {
    return "User registered with email: " + request.getEmail();
  }

  @PostMapping("/login")
  public AuthResponse login(@RequestBody AuthRequest request) {
    return new AuthResponse("dummyAccessToken", "dummyRefreshToken");
  }

  @PostMapping("/refresh")
  public AuthResponse refresh(@RequestBody RefreshRequest request) {
    return new AuthResponse("dummyAccessToken", request.getRefreshToken());
  }

  @RequestMapping("*")
  public ResponseEntity<Void> fallback() {
    return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
  }
}

class AuthRequest {
  private String email;
  private String password;

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }
}

class AuthResponse {
  private String accessToken;
  private String refreshToken;

  public AuthResponse(String accessToken, String refreshToken) {
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
  }

  public String getAccessToken() {
    return accessToken;
  }

  public String getRefreshToken() {
    return refreshToken;
  }
}

class RefreshRequest {
  private String refreshToken;

  public String getRefreshToken() {
    return refreshToken;
  }

  public void setRefreshToken(String refreshToken) {
    this.refreshToken = refreshToken;
  }
}
