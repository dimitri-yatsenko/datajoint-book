-- Ensure dev user exists and has broad privileges
CREATE USER IF NOT EXISTS 'dev'@'%' IDENTIFIED BY 'devpass';
GRANT ALL PRIVILEGES ON *.* TO 'dev'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
