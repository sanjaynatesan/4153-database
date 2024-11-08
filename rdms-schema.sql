CREATE SCHEMA p1_database;
CREATE SCHEMA p2_database;
CREATE SCHEMA p3_database;

USE p1_database;

CREATE TABLE dishes (
                        id CHAR(36) PRIMARY KEY,
                        name VARCHAR(255) NOT NULL,
                        description TEXT,
                        category VARCHAR(100),
                        location VARCHAR(255),
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        dietary_info JSON
);

CREATE INDEX idx_name ON dishes(name);

USE p2_database;

CREATE TABLE reviews (
                         id CHAR(36) PRIMARY KEY,
                         dish_id CHAR(36) NOT NULL,
                         user_id CHAR(36),
                         rating INT CHECK (rating >= 1 AND rating <= 5),
                         review TEXT,
                         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                         FOREIGN KEY (dish_id) REFERENCES p1_database.dishes(id) ON DELETE CASCADE  -- Reference to the `dishes` table in the dish_management_db database
);

CREATE INDEX idx_dish_id ON reviews(dish_id);
CREATE INDEX idx_user_id ON reviews(user_id);

USE p3_database;

CREATE TABLE images (
                        id CHAR(36) PRIMARY KEY,
                        dish_id CHAR(36),
                        review_id CHAR(36),
                        url VARCHAR(512) NOT NULL,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        FOREIGN KEY (dish_id) REFERENCES p1_database.dishes(id) ON DELETE SET NULL,  -- Reference to the `dishes` table in the dish_management_db
                        FOREIGN KEY (review_id) REFERENCES p2_database.reviews(id) ON DELETE SET NULL  -- Reference to the `reviews` table in the review_db
);

CREATE INDEX idx_dish_id ON images(dish_id);
CREATE INDEX idx_review_id ON images(review_id);