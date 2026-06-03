#!/bin/bash
# Creates custom Ollama models with tuned system prompts.
# Run on JARVIS: bash ~/code/jarvis/bash/create-models.sh

set -euo pipefail

echo "=== Creating jarvis-assistant model ==="
ollama create jarvis-assistant -f - <<'EOF'
FROM qwen2.5:14b
SYSTEM "You are JARVIS, a helpful home assistant. Always respond in English. Keep responses brief and conversational."
EOF

echo ""
echo "Done. In Home Assistant, set the conversation agent to: jarvis-assistant"
