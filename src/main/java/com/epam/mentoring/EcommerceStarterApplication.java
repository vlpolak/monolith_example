package com.epam.mentoring;

import com.epam.mentoring.storage.StorageProperties;
import com.epam.mentoring.storage.StorageService;
import com.epam.mentoring.validators.GroupValidator;
import com.epam.mentoring.validators.OrderValidator;
import com.epam.mentoring.validators.ProductValidator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.orm.jpa.vendor.HibernateJpaSessionFactoryBean;
import org.springframework.validation.Validator;

@SpringBootApplication
@EnableConfigurationProperties(StorageProperties.class)
public class EcommerceStarterApplication {

  public static void main(String[] args) {
    SpringApplication.run(EcommerceStarterApplication.class, args);
  }

  @Bean
  CommandLineRunner init(StorageService storageService) {
    return (args) -> {
      //			storageService.deleteAll();
      storageService.init();
    };
  }

  @Bean
  public HibernateJpaSessionFactoryBean sessionFactory() {
    return new HibernateJpaSessionFactoryBean();
  }

  @Bean
  public Validator productValidator() {
    return new ProductValidator();
  }

  @Bean
  public Validator groupValidator() {
    return new GroupValidator();
  }

  @Bean
  public Validator orderValidator() {
    return new OrderValidator();
  }

}
