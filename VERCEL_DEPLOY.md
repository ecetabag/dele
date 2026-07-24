# Deploy this app securely to Vercel

## 1. Important
There is NO Groq API key in the browser files in this folder.

The browser sends AI requests to:

`/api/groq`

The server function in `api/groq.js` reads the secret from:

`process.env.GROQ_API_KEY`

## 2. Create a GitHub repository

Open Terminal in this folder:

```bash
git init
git add .
git commit -m "Initial secure Vercel app"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```

Before pushing, you can verify no Groq key was accidentally included:

```bash
grep -R -E "gsk_[A-Za-z0-9]{20,}" .
```

It should return nothing.

## 3. Import the repository into Vercel

- Open Vercel
- Add New → Project
- Import your GitHub repository
- Deploy

No build command is required for the static website.

## 4. Add the secret Groq key in Vercel

Go to:

Project → Settings → Environment Variables

Add:

- Name: `GROQ_API_KEY`
- Value: your real Groq API key

Enable it for Production and Preview.

Then redeploy.

Optional environment variable:

- `GROQ_MODEL`

If omitted, the server currently defaults to `llama-3.3-70b-versatile`.

## 5. Updating the website later

```bash
git add .
git commit -m "Update app"
git push
```

Vercel will redeploy from GitHub.

## Security note

Never paste the real Groq key into:
- `index.html`
- `app.js`
- `config.js`
- GitHub

The real key should exist only in Vercel Environment Variables.
