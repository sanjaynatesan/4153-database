CREATE SCHEMA dish_management;
CREATE SCHEMA review_and_rating;
CREATE SCHEMA image_management;

USE dish_management;

CREATE TABLE dining_halls (
                              id INT PRIMARY KEY AUTO_INCREMENT,
                              name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE stations (
                          id INT PRIMARY KEY AUTO_INCREMENT,
                          name VARCHAR(255) NOT NULL,
                          dining_hall_id INT NOT NULL,
                          FOREIGN KEY (dining_hall_id) REFERENCES dining_halls(id) ON DELETE CASCADE
);

CREATE TABLE dishes (
                        id INT PRIMARY KEY AUTO_INCREMENT,
                        name VARCHAR(255) NOT NULL,
                        description TEXT,
                        dining_hall_id INT NOT NULL,
                        station_id INT NOT NULL,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        FOREIGN KEY (dining_hall_id) REFERENCES dining_halls(id) ON DELETE CASCADE,
                        FOREIGN KEY (station_id) REFERENCES stations(id) ON DELETE CASCADE
);

CREATE INDEX idx_name ON dishes(name);

USE review_and_rating;

CREATE TABLE reviews (
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         dish_id INT NOT NULL,
                         rating INT CHECK (rating >= 1 AND rating <= 5),
                         review TEXT,
                         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                         FOREIGN KEY (dish_id) REFERENCES dish_management.dishes(id) ON DELETE CASCADE
);

CREATE INDEX idx_dish_id ON reviews(dish_id);

USE image_management;

CREATE TABLE images (
                        id INT PRIMARY KEY AUTO_INCREMENT,
                        dish_id INT,
                        review_id INT,
                        url VARCHAR(512) NOT NULL,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        FOREIGN KEY (dish_id) REFERENCES dish_management.dishes(id) ON DELETE SET NULL,
                        FOREIGN KEY (review_id) REFERENCES review_and_rating.reviews(id) ON DELETE SET NULL
);

CREATE INDEX idx_dish_id ON images(dish_id);
CREATE INDEX idx_review_id ON images(review_id);