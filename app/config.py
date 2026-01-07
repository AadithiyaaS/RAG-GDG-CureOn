# config.py

import os

LOCAL_EMBEDDING_MODEL = "all-MiniLM-L6-v2"

# Chunking
CHUNK_SIZE = 500
CHUNK_OVERLAP = 50

# Vector storage
DATA_DIR = os.getenv("DATA_DIR", "data")
VECTOR_INDEX_PATH = f"{DATA_DIR}/vector.index"
TEXT_STORE_PATH = f"{DATA_DIR}/texts.npy"
