FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    python3-dev \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Install DBT
RUN pip install --no-cache-dir \
    dbt-core==1.9.0 \
    dbt-postgres==1.9.0

# Create dbt user
RUN useradd -m -u 1000 dbt_user
USER dbt_user

WORKDIR /usr/app/dbt

# Copy project files
COPY --chown=dbt_user:dbt_user . /usr/app/dbt/

# Set environment variables
ENV DBT_PROFILES_DIR=/usr/app/dbt

CMD ["dbt", "run"]