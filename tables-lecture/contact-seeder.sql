CREATE DATABASE IF NOT EXISTS contacts_manager;

-- plurarlize the name

IF NOT EXISTS (Select * from contacts)
then``
CREATE TABLE contacts (
    --     colum name datatype(), SPECIAL
                          id INT UNSIGNED NOT NULL AUTO_INCREMENT,
                          author_name VARCHAR(50),
                          creation_date TIMESTAMP  DEFAULT CURRENT_TIMESTAMP(),
                          title  VARCHAR(150) NOT NULL,
                          content TEXT NOT NULL,
                          PRIMARY KEY (id)
);

Select * from contacts;