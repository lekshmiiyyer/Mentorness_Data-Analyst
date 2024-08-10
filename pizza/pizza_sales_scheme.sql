-- Create order_details table
CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT,
    pizza_id varchar(80),
    quantity INT
);

-- Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    date DATE,
    time TIME
);

-- Create pizza_type table
CREATE TABLE pizza_type (
    pizza_type_id varchar(255) PRIMARY KEY,
    name VARCHAR(255),
    category VARCHAR(255),
    ingredients TEXT
);

-- Create pizza table
CREATE TABLE pizza (
    pizza_id varchar(255) PRIMARY KEY,
    pizza_type_id varchar(255),
    size VARCHAR(50),
    price DECIMAL(10, 2)
);
