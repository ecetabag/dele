# DELE B1 + Fitness

Vercel-ready version of the app.

## Secure Groq setup

Frontend:
- `config.js`
- calls `/api/groq`
- contains no Groq API key

Backend:
- `api/groq.js`
- reads `GROQ_API_KEY` from Vercel Environment Variables

See `VERCEL_DEPLOY.md` for deployment steps.
