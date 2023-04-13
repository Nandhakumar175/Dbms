CREATE TABLE tb_customer_nandha (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  code VARCHAR(50) UNIQUE,
  email VARCHAR(255),
  phone VARCHAR(20),
  contact_person_name VARCHAR(255),
  contact_person_phone VARCHAR(20),
  status ENUM('active', 'inactive','Deleted') NOT NULL DEFAULT 'active',
  created_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(255) NOT NULL,
  modified_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  modified_by VARCHAR(255) NOT NULL
);

---------------------------------------------------------------------------  -------------------

CREATE TABLE tb_customer_address_nandha (
  id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  address_type ENUM('billing', 'shipping','home') NOT NULL,
  address_line1 VARCHAR(255) NOT NULL,
  address_line2 VARCHAR(255),
  city VARCHAR(100) NOT NULL,
  state VARCHAR(100),
  country VARCHAR(100) NOT NULL,
  postal_code VARCHAR(20) NOT NULL,
  created_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(255) NOT NULL,
  modified_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  modified_by VARCHAR(255) NOT NULL,
  CONSTRAINT uc_customer_address UNIQUE (customer_id, address_type),
  CONSTRAINT fk_customer_address_customer_id FOREIGN KEY (customer_id) REFERENCES tb_customer_nandha(id) ON DELETE CASCADE
);

-----------------------------------------  ---------------------------------------------------------------
CREATE TABLE tb_customer_order_nandha (
  id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  order_no VARCHAR(50) NOT NULL,
  order_date DATE NOT NULL,
  no_of_items INT NOT NULL,
  order_sub_total DECIMAL(10,2) NOT NULL,
  order_discount DECIMAL(10,2) NOT NULL DEFAULT 0,
  order_total_amount DECIMAL(10,2) NOT NULL,
  payment_type ENUM('credit card', 'debit card', 'cash', 'cheque') NOT NULL,
  delivery_date DATE NOT NULL,
  status ENUM('pending', 'processing', 'completed', 'cancelled') NOT NULL,
  created_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(255) NOT NULL,
  modified_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  modified_by VARCHAR(255) NOT NULL,
  CONSTRAINT fk_customer_order_customer_id FOREIGN KEY (customer_id) REFERENCES tb_customer_nandha(id) ON DELETE CASCADE
);

---------------------------------------------- -------------------------------------------------------------------------------
CREATE TABLE tb_customer_order_item_nandha (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  item_name VARCHAR(255) NOT NULL,
  item_sku VARCHAR(50) NOT NULL,
  item_rate DECIMAL(10,2) NOT NULL,
  ordered_qty INT NOT NULL,
  order_total DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_customer_order_item_order_id FOREIGN KEY (order_id) REFERENCES tb_customer_order_nandha(id) ON DELETE CASCADE
);

----------------------------------------------------------------- --------------------------------------------------

--INSERT TABLES data

INSERT INTO tb_customer_nandha (name, code, email, phone, contact_person_name, contact_person_phone, status, created_by, modified_by)
VALUES
  ('John Doe', 'CUST001', 'johndoe@example.com', '555-1234', 'Jane Doe', '555-5678', 'active', 'Admin', 'Admin'),
  ('Jane Smith', 'CUST002', 'janesmith@example.com', '555-2345', 'John Smith', '555-6789', 'active', 'Admin', 'Admin'),
  ('Bob Johnson', 'CUST003', 'bobjohnson@example.com', '555-3456', 'Sue Johnson', '555-7890', 'active', 'Admin', 'Admin'),
  ('Sue Brown', 'CUST004', 'suebrown@example.com', '555-4567', 'Bob Brown', '555-8901', 'inactive', 'Admin', 'Admin'),
  ('Mike Lee', 'CUST005', 'mikelee@example.com', '555-5678', 'Kelly Lee', '555-9012', 'active', 'Admin', 'Admin'),
  ('Kelly Wong', 'CUST006', 'kellywong@example.com', '555-6789', 'Mike Wong', '555-0123', 'active', 'Admin', 'Admin'),
  ('Tom Chen', 'CUST007', 'tomchen@example.com', '555-7890', 'Lucy Chen', '555-1234', 'active', 'Admin', 'Admin'),
  ('Lucy Kim', 'CUST008', 'lucykim@example.com', '555-8901', 'Tom Kim', '555-2345', 'inactive', 'Admin', 'Admin'),
  ('Amy Davis', 'CUST009', 'amydavis@example.com', '555-9012', 'John Davis', '555-3456', 'active', 'Admin', 'Admin'),
  ('John Smith', 'CUST010', 'johnsmith@example.com', '555-0123', 'Amy Smith', '555-4567', 'active', 'Admin', 'Admin');tb_customer_nandha
  
 ------------------------------------------------------------------------------------------------------------------------------------------------------ 
  
  INSERT IGNORE INTO tb_customer_address_nandha (customer_id, address_type, address_line1, address_line2, city, state, country, postal_code, created_by, modified_by)
VALUES
  (1, 'billing', '123 Main St', NULL, 'New York', NULL, 'USA', '10001', 'Admin', 'Admin'),
  (1, 'shipping', '456 Elm St', 'Apt 2B', 'New York', NULL, 'USA', '10001', 'Admin', 'Admin'),
  (1, 'shipping', '789 Oak St', 'Suite 100', 'New York', NULL, 'USA', '10001', 'Admin', 'Admin'),
  (2, 'billing', '10 Market St', NULL, 'San Francisco', 'CA', 'USA', '94102', 'Admin', 'Admin'),
  (2, 'shipping', '20 Grove St', 'Unit A', 'San Francisco', 'CA', 'USA', '94102', 'Admin', 'Admin'),
  (2, 'shipping', '30 Pine St', 'Unit B', 'San Francisco', 'CA', 'USA', '94102', 'Admin', 'Admin'),
  (3, 'billing', '1 Oxford St', NULL, 'London', NULL, 'UK', 'WC1A 1DG', 'Admin', 'Admin'),
  (3, 'shipping', '2 Baker St', 'Flat 1B', 'London', NULL, 'UK', 'W1U 3BW', 'Admin', 'Admin'),
  (3, 'shipping', '3 Abbey Rd', 'Flat 2A', 'London', NULL, 'UK', 'NW8 9AY', 'Admin', 'Admin'),
  (4, 'billing', '4 Rue de Rivoli', NULL, 'Paris', NULL, 'France', '75001', 'Admin', 'Admin'),
  (4, 'shipping', '5 Champs-Élysées', 'Appt 12', 'Paris', NULL, 'France', '75008', 'Admin', 'Admin'),
  (4, 'shipping', '6 Avenue Montaigne', 'Appt 15', 'Paris', NULL, 'France', '75008', 'Admin', 'Admin'),
  (5, 'billing', '500 Fifth Ave', NULL, 'New York', 'NY', 'USA', '10110', 'Admin', 'Admin'),
  (5, 'shipping', '501 Madison Ave', 'Floor 10', 'New York', 'NY', 'USA', '10022', 'Admin', 'Admin'),
  (5, 'shipping', '502 Park Ave', 'Floor 12', 'New York', 'NY', 'USA', '10022', 'Admin', 'Admin'),
  (6, 'billing', '531 Adayar Ave', 'Floor 14', 'Chennai', 'TamilNadu', 'India', '10022', 'Admin', 'Admin'),
  (6, 'billing', '123 Anna Nagar St', NULL, 'Chennai', 'TamilNadu', 'India', '10001', 'Admin', 'Admin');
  
  INSERT IGNORE INTO tb_customer_address_nandha (customer_id, address_type, address_line1, address_line2, city, state, country, postal_code, created_by, modified_by)
VALUES
  (7, 'home', '123 Main St', NULL, 'New York', NULL, 'USA', '10001', 'Admin', 'Admin'),
  (7, 'home', '456 Elm St', 'Apt 2B', 'Karur', 'TamilNadu', 'India', '10001', 'Admin', 'Admin'),
  (8, 'home', '531 Adayar Ave', 'Floor 14', 'Chennai', 'TamilNadu', 'India', '10022', 'Admin', 'Admin'),
  (8, 'home', '123 Anna Nagar St', NULL, 'Chennai', 'TamilNadu', 'India', '10001', 'Admin', 'Admin'),
  (9, 'home', '500 Fifth Ave', NULL, 'Thirupur', 'TamilNadu', 'India', '10110', 'Admin', 'Admin'),
  (9, 'home', '501 Madison Ave', 'Floor 10', 'Vijayawada', 'TamilNadu', 'India', '10022', 'Admin', 'Admin'),
  (10, 'home', '10 Market St', NULL, 'San Francisco', 'CA', 'USA', '94102', 'Admin', 'Admin'),
  (10, 'home', '20 Grove St', 'Unit A', 'San Francisco', 'CA', 'USA', '94102', 'Admin', 'Admin');
  
  
  INSERT INTO tb_customer_order_nandha (customer_id, order_no, order_date, no_of_items, order_sub_total, order_discount, order_total_amount, payment_type, delivery_date, status, created_by, modified_by)
VALUES (1, 'ORD0001', '2023-04-12', 3, 350.00, 17.50, 332.50, 'credit card', '2023-04-15', 'processing', 'admin', 'admin'),
VALUES (2, 'ORD-002', '2023-04-15', 3, 150.00, 0, 150.00, 'debit card', '2023-04-17', 'processing', 'Admin', 'Admin'),
VALUES (3, 'ORD-003', '2023-04-16', 1, 50.00, 5.00, 45.00, 'cash', '2023-04-18', 'completed', 'Admin', 'Admin'),
VALUES (4, 'ORD-005', '2023-04-18', 2, 90.00, 9.00, 81.00, 'credit card', '2023-04-20', 'pending', 'Admin', 'Admin'),
VALUES (5, 'ORD-006', '2023-04-19', 1, 30.00, 0, 30.00, 'debit card', '2023-04-21', 'cancelled', 'Admin', 'Admin'),
VALUES (6, 'ORD-007', '2023-04-20', 3, 120.00, 12.00, 108.00, 'cash', '2023-04-22', 'processing', 'Admin', 'Admin'),
VALUES (7, 'ORD00001', '2023-04-13', 2, 25.99, 3.00, 22.99, 'credit card', '2023-04-20', 'processing', 'system', 'system'),
VALUES (8, 'ORD-005', '2023-04-18', 2, 90.00, 9.00, 81.00, 'credit card', '2023-04-20', 'pending', 'Admin', 'Admin'),
VALUES (9, 'ORD00004', '2023-04-13', 2, 35.99, 0, 35.99, 'cheque', '2023-04-21', 'processing', 'system', 'system'),
VALUES (10, 'ORD-007', '2023-04-20', 3, 120.00, 12.00, 108.00, 'cash', '2023-04-22', 'processing', 'Admin', 'Admin');
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--SOME TABLE chnages


ALTER TABLE tb_customer_nandha MODIFY COLUMN status ENUM('active', 'inactive', 'Deleted') NOT NULL DEFAULT 'active';

UPDATE tb_customer_nandha 
SET status = 'Deleted', 
    modified_date = CURRENT_TIMESTAMP, 
    modified_by = 'Admin' 
WHERE id IN (
  SELECT id FROM (
    SELECT id FROM tb_customer_nandha WHERE status = 'Active' LIMIT 5
  ) as top_customers
);

  SELECT *FROM tb_customer_nandha WHERE status = 'active';

ALTER TABLE tb_customer_address_nandha 
MODIFY COLUMN address_type ENUM('billing', 'shipping', 'home') NOT NULL;

SELECT c.*, a.*
FROM tb_customer_nandha c 
JOIN tb_customer_address_nandha a ON c.id = a.customer_id
WHERE c.status = 'active' AND a.address_type = 'home';


----------------------------------------------------------------------------------------------------------------------------

