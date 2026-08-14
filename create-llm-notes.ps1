$root = "LLM-80-20"

$files = @(
    "00-README.md",

    "01-NLP-FOUNDATIONS/01-what-is-nlp.md",
    "01-NLP-FOUNDATIONS/02-tokens-and-tokenization.md",
    "01-NLP-FOUNDATIONS/03-vocabulary-and-token-ids.md",
    "01-NLP-FOUNDATIONS/04-one-hot-encoding.md",
    "01-NLP-FOUNDATIONS/05-word-embeddings.md",
    "01-NLP-FOUNDATIONS/06-word2vec.md",
    "01-NLP-FOUNDATIONS/07-glove.md",
    "01-NLP-FOUNDATIONS/08-context-and-word-meaning.md",

    "02-ATTENTION/01-why-attention.md",
    "02-ATTENTION/02-attention-intuition.md",
    "02-ATTENTION/03-query-key-value.md",
    "02-ATTENTION/04-attention-score.md",
    "02-ATTENTION/05-scaled-dot-product-attention.md",
    "02-ATTENTION/06-softmax-in-attention.md",
    "02-ATTENTION/07-self-attention.md",

    "03-TRANSFORMERS/01-why-rnn-lstm-were-not-enough.md",
    "03-TRANSFORMERS/02-transformer-overview.md",
    "03-TRANSFORMERS/03-positional-encoding.md",
    "03-TRANSFORMERS/04-multi-head-attention.md",
    "03-TRANSFORMERS/05-feed-forward-network.md",
    "03-TRANSFORMERS/06-residual-connections.md",
    "03-TRANSFORMERS/07-layer-normalization.md",
    "03-TRANSFORMERS/08-transformer-encoder.md",
    "03-TRANSFORMERS/09-transformer-decoder.md",
    "03-TRANSFORMERS/10-complete-transformer.md",

    "04-GPT-AND-LLM-FUNDAMENTALS/01-what-is-an-llm.md",
    "04-GPT-AND-LLM-FUNDAMENTALS/02-what-is-gpt.md",
    "04-GPT-AND-LLM-FUNDAMENTALS/03-autoregressive-language-modeling.md",
    "04-GPT-AND-LLM-FUNDAMENTALS/04-next-token-prediction.md",
    "04-GPT-AND-LLM-FUNDAMENTALS/05-logits-and-probabilities.md",
    "04-GPT-AND-LLM-FUNDAMENTALS/06-softmax.md",
    "04-GPT-AND-LLM-FUNDAMENTALS/07-context-window.md",
    "04-GPT-AND-LLM-FUNDAMENTALS/08-parameters.md",
    "04-GPT-AND-LLM-FUNDAMENTALS/09-inference.md",
    "04-GPT-AND-LLM-FUNDAMENTALS/10-how-an-llm-generates-text.md",

    "05-LLM-TRAINING/01-training-data.md",
    "05-LLM-TRAINING/02-pretraining.md",
    "05-LLM-TRAINING/03-cross-entropy-loss.md",
    "05-LLM-TRAINING/04-gradient-descent.md",
    "05-LLM-TRAINING/05-backpropagation.md",
    "05-LLM-TRAINING/06-batch-epoch-and-iteration.md",
    "05-LLM-TRAINING/07-learning-rate.md",
    "05-LLM-TRAINING/08-gpu-and-compute.md",
    "05-LLM-TRAINING/09-llm-training-pipeline.md",

    "06-FINE-TUNING-AND-ALIGNMENT/01-pretraining-vs-fine-tuning.md",
    "06-FINE-TUNING-AND-ALIGNMENT/02-supervised-fine-tuning.md",
    "06-FINE-TUNING-AND-ALIGNMENT/03-instruction-tuning.md",
    "06-FINE-TUNING-AND-ALIGNMENT/04-rlhf.md",
    "06-FINE-TUNING-AND-ALIGNMENT/05-dpo.md",
    "06-FINE-TUNING-AND-ALIGNMENT/06-alignment.md",

    "07-LLM-APPLICATIONS/01-prompt-engineering.md",
    "07-LLM-APPLICATIONS/02-system-user-assistant-messages.md",
    "07-LLM-APPLICATIONS/03-llm-apis.md",
    "07-LLM-APPLICATIONS/04-structured-output.md",
    "07-LLM-APPLICATIONS/05-streaming.md",
    "07-LLM-APPLICATIONS/06-function-calling.md",
    "07-LLM-APPLICATIONS/07-tool-calling.md",
    "07-LLM-APPLICATIONS/08-llm-application-architecture.md",

    "08-RAG/01-what-is-rag.md",
    "08-RAG/02-embeddings-for-rag.md",
    "08-RAG/03-document-chunking.md",
    "08-RAG/04-vector-databases.md",
    "08-RAG/05-similarity-search.md",
    "08-RAG/06-cosine-similarity.md",
    "08-RAG/07-retrieval.md",
    "08-RAG/08-reranking.md",
    "08-RAG/09-rag-pipeline.md",
    "08-RAG/10-rag-vs-fine-tuning.md",

    "09-AGENTS/01-what-is-an-ai-agent.md",
    "09-AGENTS/02-agent-loop.md",
    "09-AGENTS/03-tools-and-function-calling.md",
    "09-AGENTS/04-agent-memory.md",
    "09-AGENTS/05-planning-and-reasoning.md",
    "09-AGENTS/06-agent-architecture.md",

    "10-LLM-EVALUATION/01-why-evaluate-llms.md",
    "10-LLM-EVALUATION/02-evaluation-metrics.md",
    "10-LLM-EVALUATION/03-hallucination.md",
    "10-LLM-EVALUATION/04-rag-evaluation.md",
    "10-LLM-EVALUATION/05-llm-evaluation-pipeline.md",

    "11-QUICK-REVISION/01-llm-cheat-sheet.md",
    "11-QUICK-REVISION/02-transformer-cheat-sheet.md",
    "11-QUICK-REVISION/03-attention-cheat-sheet.md",
    "11-QUICK-REVISION/04-gpt-cheat-sheet.md",
    "11-QUICK-REVISION/05-rag-cheat-sheet.md",
    "11-QUICK-REVISION/06-interview-questions.md",
    "11-QUICK-REVISION/07-important-diagrams.md"
)

foreach ($file in $files) {
    $path = Join-Path $root $file
    $directory = Split-Path $path

    if (!(Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }

    if (!(Test-Path $path)) {
        New-Item -ItemType File -Path $path -Force | Out-Null
    }
}

Write-Host ""
Write-Host "LLM 80/20 notes structure created successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Location: $((Get-Location).Path)\$root"
Write-Host "Files created: $($files.Count)"