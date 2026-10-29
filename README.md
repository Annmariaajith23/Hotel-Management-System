# Hotel Management System

A web-based Hotel Management System built with **Python Flask**,
**Oracle Database**, and **HTML/CSS**. The application provides a
central interface for managing hotel information, rooms, customers,
reservations, invoices, bills, and daily room prices.

## Features

-   **Dashboard** --- displays summary counts for hotels, rooms,
    customers, and reservations.
-   **Customer Management** --- view, add, edit, and delete customer
    records.
-   **Hotel Management** --- maintain hotel details and locations.
-   **Room Management** --- manage room numbers, categories, and
    associated hotels.
-   **Reservation Management** --- create, view, update, and delete
    reservations.
-   **Reservation Summary** --- combines customer, reservation, room,
    hotel, and current-day price information using SQL joins.
-   **Invoice Management** --- manage invoices associated with
    customers.
-   **Bill Management** --- maintain bill details and amounts.
-   **Today's Price** --- maintain daily hotel prices and available-room
    counts.
-   **Login and Logout** --- session-based access to the application.
-   **Input validation** --- HTML validation helps prevent invalid
    values in forms; database triggers can provide an additional
    validation layer when configured in Oracle.

## Technology Stack

  Layer                    Technology
  ------------------------ ------------------------
  Frontend                 HTML, CSS
  Backend                  Python, Flask
  Database                 Oracle Database
  Python database driver   `oracledb`
  Template rendering       Jinja2 (through Flask)

## Project Structure

``` text
hotel_management_system_new/
├── app.py
├── requirements.txt
├── templates/
│   ├── dashboard.html
│   ├── login.html
│   ├── sidebar.html
│   ├── customers.html
│   ├── edit_customer.html
│   ├── hotels.html
│   ├── edit_hotel.html
│   ├── rooms.html
│   ├── edit_room.html
│   ├── reservations.html
│   ├── edit_reservation.html
│   ├── reservation_summary.html
│   ├── invoices.html
│   ├── edit_invoice.html
│   ├── bills.html
│   ├── edit_bill.html
│   ├── today_price.html
│   └── edit_today_price.html
└── static/
    ├── css/
    │   └── style.css
    └── js/
        └── script.js
```

## Prerequisites

Before running the application, install or prepare:

1.  **Python 3.10+** (use a version compatible with your installed
    `oracledb` package).
2.  **Oracle Database** accessible from your computer.
3.  **Oracle Instant Client** if you use the application's Thick mode
    configuration.
4.  **Git** (optional, for cloning the repository).

> **Database setup note:** The ZIP version used to prepare this README
> does not include an Oracle `.sql` schema/setup script. Create the
> tables and any required constraints/triggers in your Oracle schema
> before launching the application. The application expects tables such
> as `Hotel`, `Rooms`, `Customer`, `Reservation`, `Invoice`, `Bill`,
> `Today_Price`, and `Login` to exist with the columns referenced in
> `app.py`.

## Configuration

Open `app.py` and review the Oracle connection settings near the top of
the file:

``` python
oracledb.init_oracle_client(
    lib_dir="/path/to/your/instantclient"
)

def get_db_connection():
    return oracledb.connect(
        user="YOUR_ORACLE_USERNAME",
        password="YOUR_ORACLE_PASSWORD",
        dsn="localhost:1521/XE"
    )
```

-   Replace the Instant Client path with the path on your own machine.
-   Set the Oracle username and password to match your database account.
-   Update the DSN if your Oracle host, port, or service name differs.
-   Do not commit real database passwords, secret keys, or other
    credentials to a public repository. For a public deployment, load
    them from environment variables and use a securely generated Flask
    secret key.
-   The project uses Oracle Thick mode. If you prefer Thin mode and your
    Oracle setup supports it, consult the `python-oracledb`
    documentation before removing the Instant Client initialization.

## Installation and Run

### 1. Clone the repository

``` bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
cd hotel_management_system_new
```

Alternatively, download the repository ZIP and open a terminal in the
project directory.

### 2. Create and activate a virtual environment

**macOS / Linux**

``` bash
python3 -m venv .venv
source .venv/bin/activate
```

**Windows PowerShell**

``` powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
```

### 3. Install dependencies

``` bash
python -m pip install --upgrade pip
pip install flask oracledb
```

If your `requirements.txt` contains dependencies, you can install them
with:

``` bash
pip install -r requirements.txt
```

### 4. Prepare Oracle Database

Create the required tables and relationships in the Oracle schema
configured in `app.py`, and add any sample data needed to test the
application. Ensure that the table and column names match the SQL
statements in the Flask routes.

### 5. Start the application

``` bash
python app.py
```

Open the local address printed by Flask in your browser. In a typical
local setup, this is:

``` text
http://127.0.0.1:5000
```

Log in using a record supported by the application's `Login` table.

## Reservation Summary and SQL Joins

The Reservation Summary page combines information across related tables.
In the current implementation, the query connects:

-   `Customer` to `Reservation` through `Guest_id`
-   `Reservation` to `Rooms` through `Room_no`
-   `Rooms` to `Hotel` through `Hotel_id`
-   `Hotel` to `Today_Price` through `Hotel_id`

The daily-price join filters `Today_Price` to the current database date.
A `LEFT JOIN` is used for the daily price so that a reservation can
still appear when a matching price has not been entered for today; the
price can then display as **Not Set**.

## Validation and Error Handling

The application uses HTML form constraints such as `required` and `min`
to provide immediate browser feedback for invalid values. Oracle
constraints or triggers should also be configured for database-level
validation. Client-side validation improves usability, but it should not
replace server-side and database validation.

## Troubleshooting

### Oracle connection fails

-   Verify that Oracle Database is running and reachable.
-   Check the username, password, DSN, and service name in `app.py`.
-   Confirm that the Oracle Instant Client path is correct if Thick mode
    is enabled.
-   Ensure the Instant Client architecture matches your Python
    installation and operating system.

### `ORA-00942: table or view does not exist`

-   Confirm that the required tables exist in the Oracle schema used by
    Flask.
-   Check that the application connects as the schema owner or has the
    required permissions.
-   Verify table and column names against the SQL queries in `app.py`.

### Login redirects back to the login page

-   Confirm that the expected login record exists in the `Login` table.
-   Check the login route and session configuration in `app.py`.

### Port 5000 is already in use

Stop the other process using the port, or change the Flask development
server port in the `app.run(...)` configuration.

## Security Notes

This project is intended as an academic/demo application. Before using
it in production:

-   Move credentials and the Flask secret key into environment
    variables.
-   Use a strong, unique secret key.
-   Add appropriate authentication, authorization, and password-hashing
    practices.
-   Use HTTPS and secure session-cookie settings.
-   Add robust validation, logging, and error handling.
-   Do not expose detailed database exceptions to end users.

## Academic Project

This project demonstrates the integration of a web frontend, Flask
routes, Oracle SQL queries, CRUD operations, session handling, and joins
in a hotel-management context.
