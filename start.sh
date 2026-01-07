#!/bin/bash
uvicorn app.rag_service:app --host 0.0.0.0 --port $PORT

