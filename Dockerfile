# Use Alpine to reduce image size
FROM python:3.10-alpine

WORKDIR /app

# Install build tools for faiss
RUN apk add --no-cache build-base g++ git

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy only necessary files
COPY app/rag.py /app/app/rag.py
COPY app/rag_service.py /app/app/rag_service.py
COPY app/config.py /app/app/config.py
COPY app/local_model /app/app/local_model

# Copy vector data
COPY data/ /app/data/

ENV DATA_DIR=/app/data

# Start FastAPI server
CMD ["uvicorn", "app.rag_service:app", "--host", "0.0.0.0", "--port", "8000"]
