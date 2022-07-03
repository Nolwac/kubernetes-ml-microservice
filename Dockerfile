FROM python:3.7.3-stretch

# Create a working directory
WORKDIR /app

# Copy source code to working directory
COPY . /app

# upgrade pip
RUN pip install --upgrade pip --no-cache-dir

# Install packages from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
# hadolint ignore=DL3013

# Expose port 80
EXPOSE 80

# Run app.py at container launch
CMD [ "python", "app.py" ]

