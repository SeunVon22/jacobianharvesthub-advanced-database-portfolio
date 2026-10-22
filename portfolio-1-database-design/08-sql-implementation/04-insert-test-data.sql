
-- Jacobian HarvestHub Limited
-- Portfolio 1: Sample Data
-- Stage 1: Customers, Suppliers, and Categories

INSERT INTO customer
    (full_name, email, telephone, delivery_address)
VALUES
    ('Amina Yusuf', 'amina.yusuf@example.com',
     '+2348011110001', '12 Allen Avenue, Ikeja, Lagos'),
    ('David Okafor', 'david.okafor@example.com',
     '+2348022220002', '8 Independence Layout, Enugu'),
    ('Grace Adeyemi', 'grace.adeyemi@example.com',
     '+2348033330003', '24 Ring Road, Ibadan');

INSERT INTO supplier
    (supplier_name, email, telephone, address)
VALUES
    ('GreenFields Farms', 'contact@greenfields.example',
     '+2348044440004', 'Abeokuta, Ogun State'),
    ('GoldenGrain Suppliers', 'sales@goldengrain.example',
     '+2348055550005', 'Minna, Niger State'),
    ('FreshHarvest Produce', 'info@freshharvest.example',
     '+2348066660006', 'Jos, Plateau State');

INSERT INTO category
    (category_name, description)
VALUES
    ('Vegetables', 'Fresh vegetables and leafy greens'),
    ('Grains', 'Rice, maize, millet, and other grains'),
    ('Fruits', 'Fresh seasonal fruits');
