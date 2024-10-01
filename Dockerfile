# Use the official Python image as the base image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    default-libmysqlclient-dev \
    libmariadb-dev \
    build-essential \
    git && \
    rm -rf /var/lib/apt/lists/*

# Clone the GitHub repository
RUN git clone https://github.com/Mohanraj-2/raj.git .

# Install the Python dependencies from the requirements file
RUN pip install --no-cache-dir -r requirements.txt

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Expose the port on which the app will run
EXPOSE 8000

# Set the entry point to run the Django development server without StatReloader
CMD ["sh", "-c", "python manage.py runserver 0.0.0.0:8000 --noreload"]
