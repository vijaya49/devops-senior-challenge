FROM public.ecr.aws/docker/library/python:3.11

# Set working directory inside the container
WORKDIR /app

# Copy only the app folder content into the container
COPY simple-time-service/ .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Ensure the start script is executable
RUN chmod +x start.sh

# Expose port 80 for the container
EXPOSE 80

# Start the app using the start script
CMD ["./start.sh"]
