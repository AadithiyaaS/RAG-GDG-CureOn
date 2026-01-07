# Slim Python base
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies needed for faiss
RUN apt-get update && \
    apt-get install -y build-essential git && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements first (for Docker cache)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire app package
COPY app /app/app

# Copy vector store + texts
COPY data /app/data

# Environment variable for data path
ENV DATA_DIR=/app/data

# IMPORTANT: use Render's dynamic PORT
CMD ["sh", "-c", "uvicorn app.rag_service:app --host 0.0.0.0 --port ${PORT:-8000}"]
