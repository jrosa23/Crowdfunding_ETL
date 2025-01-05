      
# Crowdfunding ETL Project

## Overview

This repository contains an Extract, Transform, and Load (ETL) project focused on crowdfunding data. The project processes data from two Excel files, transforms it into a usable format, and prepares it for loading into a database. This repository includes Jupyter Notebooks for data processing, explanation documents, and a 'Resources' folder with raw data and derived output files.

## Contents

This repository contains the following:

*   **`Crowdfunding_ETL.ipynb`**: A Jupyter Notebook that performs the core ETL process, including data extraction, transformation, and preparation for loading.
*   **`Crowdfunding_SQL_Schema.ipynb`**: A Jupyter Notebook that sets up the database schema for the project, including creating tables and defining relationships.
*   **`SQL_Data_Upload.ipynb`**: A Jupyter Notebook that contains code to upload data into a database using the previously created schema.
*   **`Crowdfunding ETL Mini Project Starter Code Explanation.docx`**: A document describing the logic of the data processing using Python in `Crowdfunding_ETL.ipynb`.
*   **`Crowdfunding ETL SQL DB Setup.docx`**: A document describing the database set up process from the  `Crowdfunding_SQL_Schema.ipynb` Notebook.
*   **`Resources/`**: A directory containing the following files:
    *   **`contacts.xlsx`**: Raw input data containing information about people connected to various campaigns.
    *   **`crowdfunding.xlsx`**: Raw input data containing information about crowdfunding campaigns.
    *   **`category.csv`**: Derived CSV file containing unique categories for the campaigns
    *   **`subcategory.csv`**: Derived CSV file containing unique subcategories for the campaigns
    *   **`contacts.csv`**: Derived CSV file containing contact information, cleaned and formatted.
    *   **`campaign.csv`**: Derived CSV file containing campaign data, transformed and ready for database import.
    *   **`crowdfunding_db.sql`**: Database output in SQL format.
    *   **`crowdfunding_db_schema.json`**: Database schema output in JSON format.
    *   **`ETL_SQL_DB_Schema.pgerd`**: ERD representation of the database.

## Data Processing Logic

The ETL process is performed in the `Crowdfunding_ETL.ipynb` Notebook and is explained in detail within the `Crowdfunding ETL Mini Project Starter Code Explanation.docx` document. Here is an overview:

1.  **Importing and Setting Up:** The notebook begins by importing necessary Python libraries: `pandas`, `numpy`, `textwrap`, `datetime`, `json`, `re`, and `os`. Pandas display options are set to improve readability.

2.  **Extracting Data from Excel:** Data is loaded from `crowdfunding.xlsx` into a pandas DataFrame using `pd.read_excel()`. The code then inspects the DataFrame's raw data, data types, and column names.

3.  **Assigning Category and Subcategory Values:**
    *   The code checks for the existence of a combined category and subcategory column.
    *   If found, new category and subcategory columns are created by splitting the combined column using the `/` delimiter.
    *   Missing values in these new columns are replaced with the text "Unknown".
    *  A list of unique categories and subcategories is extracted for later ID mapping.

4.  **Formatting Function:** A utility function, `format_list_output`, is defined to format lists into wrapped, indented strings for better display.

5.  **Formatting and Counting Unique Items:** The unique categories and subcategories lists are formatted for display, and the counts of unique items is generated.

6. **Creating Numerical Arrays**: Two numpy arrays are created (`category_ids` and `subcategory_ids`) for assigning numerical IDs.

7.  **Creating String-Based IDs:** List comprehensions are used to create category IDs (e.g., `"cat1"`) and subcategory IDs (e.g., `"subcat1"`) by concatenating strings to the numerical IDs.

8. **Creating Category and Subcategory DataFrames:**
    *   Two DataFrames, `category_df` and `subcategory_df`, are constructed, pairing unique values with generated IDs.

9.  **Exporting Category and Subcategory DataFrames:** The generated DataFrames are saved as CSV files in the `Resources` folder.

10. **Setting Up the Campaign DataFrame:**
    *   The code creates a copy of the original data and renames the 'blurb', 'launched_at', and 'deadline' columns to 'description', 'launched_date', and 'end_date', respectively.
    *   The "goal" and "pledged" columns are converted to float, and 'launched_date' and 'end_date' columns are converted to date datatypes.

11.  **Mapping Categories and Subcategories:** The unique categories and subcategories are mapped to their respective IDs and merged with the `campaign_df`.

12. **Dropping Unwanted Columns:** The columns, `staff_pick`, `spotlight`, `category & sub-category`, `category`, and `subcategory` are dropped from `campaign_merged_df`, with the result saved to the new DataFrame, `campaign_cleaned`.

13. **Exporting the Campaign DataFrame:** The processed `campaign_cleaned` DataFrame is saved as a CSV file in the `Resources` folder.

## Database Setup Logic

The database setup is detailed within the `Crowdfunding ETL SQL DB Setup.docx` document and implemented in the `Crowdfunding_SQL_Schema.ipynb` Notebook. Here's an overview of the database creation process:

1. **SQLAlchemy Setup:** The notebook uses SQLAlchemy to set up a connection to a PostgreSQL database and creates the tables (category, subcategory, contacts, and campaign).
2. **Schema File Output:** A schema file (`crowdfunding_db_schema.sql`) is created by using SQLAlchemy to iterate through the table metadata and output the SQL create table statements.
3. **Database and Table Creation:** The code establishes the database connection and then creates the tables.
4. **Verification Queries:** Queries are written and executed to verify that the tables have been created.
5. **CSV Data Import:** The CSV files created in the ETL process (category, subcategory, contacts, campaign) are imported into their corresponding database tables using the to_sql method.
6. **Verification:** Queries are used again to verify the data was uploaded correctly.

## How to Use

1.  **Clone the Repository:** Clone this repository to your local machine.
2.  **Set Up Environment:** Ensure you have Python 3.x installed along with the required libraries: `pandas`, `numpy`, `textwrap`, `datetime`, `json`, `re`, `sqlalchemy`, and `psycopg2-binary`. 
3. **Download Input Data:** Make sure to download the original files from this repo and make it is within the resources folder.
4. **Run the ETL Notebook:** Open and execute the Crowdfunding_ETL.ipynb Jupyter Notebook to process the data.
5. **Run the Schema Creation Notebook:** Open and execute the Crowdfunding_SQL_Schema.ipynb Jupyter Notebook to generate the database schema and tables.
6. **Run the Data Upload Notebook:** Open and execute the SQL_Data_Upload.ipynb Jupyter Notebook to populate the tables with the data from CSV files.
7. **Inspect Results:** The resources folder should contain the following generated CSV files, the json schema output file, and SQL schema output file, category.csv, subcategory.csv, contacts.csv, and campaign.csv . The notebook outputs will give you the data in the correct format. The database itself will also contain the uploaded data.

## ERD Sketch

Here is a conceptual sketch of the database using an Entity Relationship Diagram:

    category
                      ----------------
                      * category_id (PK)
                       category

                           |
                           |
                         campaign
                      ---------------------
                      * cf_id (PK)
                      * contact_id (FK contacts)
                        company_name
                        description
                        goal
                        pledged
                        outcome
                        backers_count
                        country
                        currency
                        launched_date
                        end_date
                        category_id (FK category)
                        subcategory_id (FK subcategory)
                           |
                           |
                         subcategory
                      ------------------
                      * subcategory_id (PK)
                        subcategory

                           |
                           |
                         contacts
                      ------------------
                      * contact_id (PK)
                        first_name
                        last_name
                        email

The actual ERD diagram is at the bottom of page 4 of the ETL_SQL_DB_Setup_Explanation file.

## License

This project is licensed under the MIT License.
Contributions

Contributions are welcome. Please fork this repository and submit a pull request.
