 
 
##  Asiigment Overview

The task involves building a data ingestion pipeline for user metrics using PostgreSQL and Docker. It encompasses a Python script for creating and storing user metrics, a SQL schema for defining the database structure, and Docker Compose setup for orchestrating the application and database containers.

### Components
- **Python Script (`app.py`)**: This script generates random user metrics and stores them in the PostgreSQL database.
- **SQL Schema (`assignment.sql`)**: This file defines the database tables and stored procedures for recording and analyzing user metrics.
- **Docker Compose (`docker-compose.yml`)**: This configuration sets up the services, networks, and volumes required to run the PostgreSQL database and Python application.
- **Dockerfile**: This file defines the environment for the Python application.

## Setup Instructions

### 1. Prepare the Environment

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Install Docker and Docker Compose**:
   Make sure to have Docker and Docker Compose installed on your machine by following the installation instructions from the [official Docker documentation](https://docs.docker.com/get-docker/) and [Docker Compose documentation](https://docs.docker.com/compose/install/).

### 2. Configure the Database

1. **Create the Database Schema**:
   - Navigate to the directory containing `assignment.sql`.
   - Run the following command to create the schema in your PostgreSQL database:
     ```bash
     docker-compose run db psql -U postgres -d metrics -f /app/assignment.sql
     ```

### 3. Build and Run the Application

1. **Build the Docker Images**:
   ```bash
   docker-compose build
   ```

2. **Start the Services**:
   ```bash
   docker-compose up
   ```

   This will initiate the PostgreSQL database and the Python application container.

## Usage

- **Application**: The Python application (`app.py`) generates random metrics and stores them in the PostgreSQL database every 10 seconds. You can adjust the sleep interval in the script if necessary.

- **Access the Database**: You can connect to the PostgreSQL database using the following credentials:
  - **Host**: `localhost`
  - **Port**: `5432`
  - **Username**: `postgres`
  - **Password**: `yourpassword`
  - **Database**: `metrics`

## File Descriptions

- **`app.py`**: Python script for generating and storing user metrics.
- **`assignment.sql`**: SQL script defining the database schema and stored procedures.
- **`docker-compose.yml`**: Docker Compose configuration for setting up the PostgreSQL database and Python application.
- **`Dockerfile`**: Defines the Docker image for the Python application.
- **`requirements.txt`**: Lists Python dependencies for the application.

## Additional Information

### Assumptions
- The PostgreSQL database is expected to be accessible on `localhost:5432`.
- The Python script and database are configured to use default settings.

### Potential Limitations
- The Python script uses random data generation, which may not accurately represent real-world scenarios.
- For production use, consider securing database credentials and implementing more robust data validation.

### Future Improvements
- Add error handling and logging to the Python script.
- Implement data validation and error checking in the SQL schema.
- Explore data visualization and reporting capabilities.
