import faiss
import numpy as np
from sentence_transformers import SentenceTransformer
from config import *

# Load vector store ONCE at startup
index = faiss.read_index(VECTOR_INDEX_PATH)
texts = np.load(TEXT_STORE_PATH, allow_pickle=True)

# Load embedding model
model = SentenceTransformer(LOCAL_EMBEDDING_MODEL)

def embed_query(query):
    return model.encode([query], convert_to_numpy=True).astype("float32")[0]

def retrieve(query, k=4):
    q_emb = embed_query(query).reshape(1, -1)
    _, ids = index.search(q_emb, k)
    return [texts[i] for i in ids[0]]

def build_prompt(query, context):
    return f"""
Answer the question using ONLY the context below.
If the answer is not present, say "I don't know".

Context:
{context}

Question:
{query}
""".strip()
