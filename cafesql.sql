CREATE TABLE Manager (
    Manager_name NVARCHAR(100),
    Manager_user NVARCHAR(100),
    Manager_pass NVARCHAR(100)
)

CREATE TABLE Staff (
    Staff_id NVARCHAR(100) PRIMARY KEY,
    Staff_name NVARCHAR(100),
    Staff_pic NVARCHAR(100),
    Staff_role NVARCHAR(100),
    Staff_user NVARCHAR(100),
    Staff_pass NVARCHAR(100),
    Staff_phoneNum VARCHAR(100),
    Staff_status BIT
)


CREATE TABLE Item (
    Item_id NVARCHAR(100) PRIMARY KEY,
    Item_name NVARCHAR(100),
    Item_price NUMERIC(10, 3),
    Item_picture NVARCHAR(100),
    Item_type NVARCHAR(100)
)


CREATE TABLE Customer (
    Customer_id NVARCHAR(100) PRIMARY KEY,
    Customer_name NVARCHAR(100) not null,
    Customer_table INT,
    Customer_giveOrder BIT,
    Customer_payment BIT
)

CREATE TABLE [Order] (
    Customer_id NVARCHAR(100),
	Item_id NVARCHAR(100),
	Order_quantity int,
	Order_responsive NVARCHAR(100),
	Order_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id),
	FOREIGN KEY (Item_id) REFERENCES Item(Item_id),
    Order_billStatus BIT,
)


-- Adding data to Staff table
INSERT INTO Staff (Staff_id, Staff_name, Staff_pic, Staff_role, Staff_user, Staff_pass, Staff_phoneNum, Staff_status) VALUES 
('S1', 'Lam Tan Phat', '../asset/img/img_customer/staff/escapethepdf.png', 'Staff', 'S1PhatLT', '12345', '0987654321', 1),
('S2', 'Le Huu Khoa', '../asset/img/img_customer/staff/escapethepdf.png', 'Staff', 'S2KhoaLH', '12345', '0984634345', 1),
('S3', 'Nguyen Thanh Bao', '../asset/img/img_customer/staff/escapethepdf.png', 'Staff', 'S3BaoNT', '12345', '0987654321', 0)

select * from Staff where Staff_id = 'S2'

-- Adding data to Item table
-- Add Drink
INSERT INTO Item (Item_id, Item_name, Item_price, Item_picture, Item_type) VALUES 
('I1', 'BLACK COFFEE', 18.000, '../asset/img/img_customer/order/drink/coffee-cup.png', 'Drink'),
('I2', 'COCA COLA', 10.000, '../asset/img/img_customer/order/drink/coca.png', 'Drink'),
('I3', 'PEPSI', 10.000, '../asset/img/img_customer/order/drink/pepsi.png', 'Drink'),
('I6', 'Vinamilk Chocolate', 5.000, '../asset/img/img_customer/order/drink/vinamilkSocola.png', 'Drink')


-- Add Drink
INSERT INTO Item (Item_id, Item_name, Item_price, Item_picture, Item_type) VALUES 
('I4', 'SPICY NOODLES', 50.000, '../asset/img/img_customer/order/food/spicynoodles.png', 'Food'),
('I5', 'CHEESE NOODLES', 48.000, '../asset/img/img_customer/order/food/cheesenoodles.png', 'Food'),
('I7', 'CHICKEN NOODLES', 48.000, '../asset/img/img_customer/order/food/chickenNoodle.png', 'Food'),
('I8', 'ICE-CREAM', 30.000, '../asset/img/img_customer/order/dessert/ice-cream.png', 'Dessert')


-- Adding data to Manager table
INSERT INTO Manager (Manager_name, Manager_user, Manager_pass) VALUES 
('admin', 'admin', 'admin')