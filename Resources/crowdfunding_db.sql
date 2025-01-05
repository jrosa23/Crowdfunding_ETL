
CREATE TABLE category (
	category_id VARCHAR NOT NULL, 
	category VARCHAR, 
	PRIMARY KEY (category_id)
)

;

CREATE TABLE contacts (
	contact_id SERIAL NOT NULL, 
	first_name VARCHAR, 
	last_name VARCHAR, 
	email VARCHAR, 
	PRIMARY KEY (contact_id)
)

;

CREATE TABLE subcategory (
	subcategory_id VARCHAR NOT NULL, 
	subcategory VARCHAR, 
	PRIMARY KEY (subcategory_id)
)

;

CREATE TABLE campaign (
	cf_id SERIAL NOT NULL, 
	contact_id INTEGER, 
	company_name VARCHAR, 
	description VARCHAR, 
	goal FLOAT, 
	pledged FLOAT, 
	outcome VARCHAR, 
	backers_count INTEGER, 
	country VARCHAR, 
	currency VARCHAR, 
	launched_date DATE, 
	end_date DATE, 
	category_id VARCHAR, 
	subcategory_id VARCHAR, 
	PRIMARY KEY (cf_id), 
	FOREIGN KEY(contact_id) REFERENCES contacts (contact_id), 
	FOREIGN KEY(category_id) REFERENCES category (category_id), 
	FOREIGN KEY(subcategory_id) REFERENCES subcategory (subcategory_id)
)

;
