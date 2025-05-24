CREATE DATABASE IF NOT EXISTS `books`;
CREATE USER IF NOT EXISTS 'books-user'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON `books`.* TO 'books-user'@'localhost';
FLUSH PRIVILEGES;
    
