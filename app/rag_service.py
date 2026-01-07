from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from rag import retrieve, build_prompt

app = FastAPI()

# CORS for React / JS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # for hackathon; restrict later
    allow_methods=["POST"],
    allow_headers=["*"],
)

class QueryRequest(BaseModel):
    query: str
    k: int = 4

class QueryResponse(BaseModel):
    prompt: str
    context: str

@app.post("/rag", response_model=QueryResponse)
def rag_endpoint(req: QueryRequest):
    docs = retrieve(req.query, req.k)
    context = "\n\n".join(docs)
    prompt = build_prompt(req.query, context)

    return {
        "prompt": prompt,
        "context": context
    }

@app.get("/health")
def health():
    return {"status": "ok"}

