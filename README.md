# Weather x Yelp Review Study Case
## Overview
Study case project that merge two massive, real-world datasets in order to draw conclusions about how weather affects Yelp reviews. Using [Yelp open dataset](https://business.yelp.com/data/resources/open-dataset/) and custom Weather data as our dataset.

## Data Architecture
This project implements a simple yet robust data pipeline designed for small to medium-scale data processing, emphasizing simplicity.
![Alt text](docs/images/data-architecture.png)

## Tech Stack
### Orchestration
- Apache Airflow: Workflow management and scheduling
- Handles dependencies, monitoring, and retry logic
- Provides a clean UI for pipeline monitoring
### Data Processing
- Python + Pandas: Data ingestion and initial processing
- dbt: SQL-based transformations for data cleaning and aggregation
- Lightweight approach suitable for datasets that don't require distributed processing
### Storage
- Postgres: Simple yet powerful database. Suitable for local data warehouse.
  - STAGING: Raw data landing zone
  - ODS: Cleaned and standardized data
  - DW: Analytics-ready aggregated data
### Visualization
- Dashboards: Connected to Postgres for real-time analytics
- Self-service reporting and data exploration

## Dataset Preparation
Since there are some restriction when trying to download the Yelp dataset using simple `curl`, I am mimicking browser behavior to bypass the restriction with this command.
```bash
curl -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
   -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" \
   -H "Accept-Language: en-US,en;q=0.5" \
   -H "Accept-Encoding: gzip, deflate" \
   -H "Connection: keep-alive" \
   -H "Upgrade-Insecure-Requests: 1" \
   -O https://business.yelp.com/external-assets/files/Yelp-JSON.zip
```
Then, use this command to extract the zip and tar file.
```bash
unzip Yelp-JSON.zip
tar -xvf 'Yelp JSON'/yelp_dataset.tar -C $(pwd)/dataset/yelp

# Clean up unnecessary files
rm Yelp-JSON.zip && rm -r 'Yelp JSON' && rm -r __MACOSX
```
Use `json_to_csv.py` script to convert the JSON files into CSV. Don't forget to clean up the JSON files later to save storage.
```bash
python -m venv myenv

source venv/bin/activate
pip install -r requirements.txt

python dataset/scripts/json_to_csv.py
```

## Installation
### Airflow
Generate environment variable for Airflow
```bash
./setup_airflow.sh
```
Run docker compose to deploy Airflow
```bash
docker compose -f airflow/docker-compose.yaml up -d
```