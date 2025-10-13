# D608 Data Processing Pipeline Project

## Overview

This project implements a data pipeline using **Docker**, **Apache Airflow**, and **PostgreSQL** (or your local database), as required for the D608 capstone. All steps are version controlled in Git, with modular operators to stage, transform, and test data—**without cloud resources**.

## Repository Structure

```
d608_data_processing/
├── dags/
│   └── final_project.py
├── plugins/
│   └── final_project_operators/
│       ├── stage_redshift.py
│       ├── load_fact.py
│       ├── load_dimension.py
│       ├── data_quality.py
│       └── final_project_sql_statements.py
├── create_tables.sql
├── README.md
```

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/YourUsername/d608_data_processing.git
cd d608_data_processing
```

### 2. Install Docker

- Download and install [Docker Desktop](https://www.docker.com/products/docker-desktop) (Windows/Mac) or `docker`/`docker-compose` (Linux).
- Confirm installation:
  ```bash
  docker --version
  docker-compose --version
  ```

### 3. Initialize the Database

- Place your data files (such as project log data and song data) in the appropriate folders if required (`data/`).
- Edit `create_tables.sql` as needed for your local (PostgreSQL) schema—adapt types if necessary.

### 4. Start the Pipeline Environment

Update/copy the following `docker-compose.yml` into your repository if not already present:

```yaml
version: '3'
services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_USER: airflow
      POSTGRES_PASSWORD: airflow
      POSTGRES_DB: sparkifydb
    ports:
      - "5432:5432"
    volumes:
      - ./create_tables.sql:/docker-entrypoint-initdb.d/create_tables.sql
  airflow:
    image: apache/airflow:2.8.1
    environment:
      AIRFLOW__CORE__SQL_ALCHEMY_CONN: postgresql+psycopg2://airflow:airflow@postgres:5432/sparkifydb
    volumes:
      - ./dags:/opt/airflow/dags
      - ./plugins:/opt/airflow/plugins
    ports:
      - "8080:8080"
```

Launch Docker containers:

```bash
docker-compose up --build
```

- Airflow UI: [http://localhost:8080](http://localhost:8080)
- PostgreSQL: (localhost:5432)

### 5. Validate Setup

- Run the Airflow DAG via the Airflow UI.
- Check logs for successful completion.
- Inspect PostgreSQL database for populated tables.

## ETL Workflow Description

- **Staging**: Custom operators move data from local files to the database’s staging tables.
- **Loading**: Fact and dimension tables are populated via SQL queries in `final_project_sql_statements.py`.
- **Testing**: Automated data quality checks ensure the integrity and completeness of results.

**All code logic mirrors assignment specifications and is modular for transparency and reproducibility.**

## Key Files

- `dags/final_project.py`: Main DAG controlling pipeline workflow.
- `plugins/final_project_operators/`: Custom Airflow operators and ETL SQL queries.
- `create_tables.sql`: Database schema.
- `README.md`: This document.

## How to Contribute

Fork the repo, create a feature branch, and submit a pull request. Follow commit best practices:

```bash
git add .
git commit -m "Descriptive commit message"
git push origin feature-branch
```

## Troubleshooting

- Check Airflow and PostgreSQL logs for error diagnostics.
- Validate local file paths in Docker volumes.
- If pipeline tasks fail, check the structure of custom operators and SQL types for compatibility with your DB.

## Project Submission

- Ensure all files are committed and pushed.
- Submit repository URL per the assignment instructions.

