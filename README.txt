# DELE B1 + 30-Day Fitness Offline App

Open `index.html` directly in a modern browser. No server or internet connection is required.

Notes:
- All progress is stored in browser `localStorage` under the key `sprint30_state_v5`.
- Browser speech synthesis and microphone transcription depend on browser/OS support. The app always provides text fallbacks.
- The DELE practice material in this app is newly written and format-inspired, not copied from an official exam.
- Automated writing/readiness scores are practice estimates, not official DELE results.

AI features:
- The app uses Groq for optional AI translation and AI meal generation.
- The interface does not ask for an API key.
- Open `config.js` once and replace `PASTE_YOUR_GROQ_KEY_HERE` with your Groq API key.
- Default Groq endpoint: https://api.groq.com/openai/v1/chat/completions
- Default model: llama-3.3-70b-versatile
- The offline dictionary, lessons, progress tracking, and rotating meal plan still work without an API key.
- Never upload or share `config.js` after placing a real API key inside it.
