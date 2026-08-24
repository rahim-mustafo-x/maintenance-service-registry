package org.safa.maintenanceserviceregistry;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@SpringBootApplication
@EnableEurekaServer
public class MaintenanceServiceRegistryApplication {

    static void main(String[] args) {
        SpringApplication.run(MaintenanceServiceRegistryApplication.class, args);
    }

}
