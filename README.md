# Salon Appointment Scheduler
A salon database is managed where the information about the customer and services are used to make appointment.

## I. Database Design (PostgreSQL):

* Three Core Tables: The program revolves around three interconnected tables in a PostgreSQL database:

  * services Table:
    * Stores information about the salon's offerings.
    * Likely includes columns for:
      * service_id (Primary Key, Integer, Auto-incrementing)
      * name (Text, e.g., 'Haircut', 'Coloring', 'Manicure', Unique)
      * price (Numeric or Decimal)
    * customers Table:
      * Stores information about the salon's clients.
      * Likely includes columns for:
        * customer_id (Primary Key, Integer, Auto-incrementing)
        * phone (Character varying or Text, Unique, used to identify customers)
        * name (Text)
    * appointments Table:
      * Stores details of scheduled appointments.
      * Likely includes columns for:
        * appointment_id (Primary Key, Integer, Auto-incrementing)
        * customer_id (Foreign Key referencing customers.customer_id)
        * service_id (Foreign Key referencing services.service_id)
        * appointment_time (Timestamp or Date and Time)
* Relationships:

  * A customer can have multiple appointments (one-to-many relationship between customers and appointments).
  * A service can be part of multiple appointments (one-to-many relationship between services and appointments).
  * The appointments table acts as a linking table, connecting customers to the services they booked and the time of their appointment.
    
## II. Bash Script Functionality:

The Bash script will provide a command-line interface for users to interact with the PostgreSQL database. Key functionalities include:

* Displaying Available Services:

  * Queries the services table to list all available services with their names and prices.
  * Presents this information clearly to the user on the terminal.
* Booking an Appointment:

  * Prompts the user for their phone number.
  * Checks if the phone number exists in the customers table.
  * If not, it prompts for the customer's name and adds a new entry to the customers table.
    * If it exists, it retrieves the customer_id.
  * Displays the list of available services (as in the first point) with corresponding numbers for selection.
  * Prompts the user to select a service by entering its number.
  * Prompts the user to enter their desired appointment date and time.
  * Inserts a new record into the appointments table, linking the customer_id, service_id, and the provided appointment_time.
  * Provides confirmation to the user upon successful booking.
* Potentially (depending on the exact requirements):

  * Viewing Existing Appointments (for a specific customer): Prompts for a phone number and displays the upcoming appointments for that customer.
  * Cancelling Appointments: Allows a customer to cancel a previously booked appointment (likely by providing a phone number and identifying the appointment to cancel).
    
## III. Interaction with PostgreSQL:

* The Bash script will use command-line tools like psql to interact with the PostgreSQL database.
* It will execute SQL queries to:
  * Select data from the tables (e.g., to list services, find customers, view appointments).
  * Insert new data into the tables (e.g., to add new customers, book appointments).
  * Potentially update or delete data (e.g., to cancel appointments).
  * The script will likely involve:
    * Connecting to the database.
    * Constructing and executing SQL queries based on user input.
    * Processing the output of the SQL queries to display information to the user.
## IV. Learning Objectives:

This project aims to teach you:

* **Relational Database Design:** How to structure data into tables and define relationships between them.
* **SQL (Structured Query Language):** How to query, insert, update, and delete data in a relational database using SQL commands.
* **Bash Scripting:** How to write shell scripts to automate tasks and interact with external programs (in this case, psql).
* **Database Interaction from the Command Line:** How to use command-line tools to manage and interact with a database.
* **Data Management Concepts:** Understanding how to store and retrieve information effectively.
In essence, you'll be building a basic command-line application that uses a relational database as its backend to manage salon appointments. It emphasizes understanding database design principles and using SQL within a scripting environment.
