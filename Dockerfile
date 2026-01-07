# Use slim Python base for FAISS compatibility and small image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install build tools for FAISS and git
RUN apt-get update && \
    apt-get install -y build-essential git && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python packages without cache
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy only necessary app files
COPY app/rag.py /app/app/rag.py
COPY app/rag_service.py /app/app/rag_service.py
COPY app/config.py /app/app/config.py

# Copy pre-downloaded MiniLM model
COPY app/local_model /app/app/local_model

# Copy FAISS vector data
COPY data/ /app/data/

# Set environment variable for data
ENV DATA_DIR=/app/data

# Start FastAPI server
CMD ["uvicorn", "app.rag_service:app", "--host", "0.0.0.0", "--port", "8000"]
