export default async function handler(req, res) {
  if (req.method !== "POST") {
    res.setHeader("Allow", "POST");
    return res.status(405).json({ error: "Method not allowed" });
  }

  const apiKey = process.env.GROQ_API_KEY;
  if (!apiKey) {
    return res.status(500).json({ error: "GROQ_API_KEY is not configured on Vercel." });
  }

  const body =
    typeof req.body === "string"
      ? (() => {
          try {
            return JSON.parse(req.body);
          } catch {
            return {};
          }
        })()
      : req.body || {};

  const systemPrompt =
    typeof body.systemPrompt === "string" ? body.systemPrompt.trim() : "";
  const userPrompt =
    typeof body.userPrompt === "string" ? body.userPrompt.trim() : "";

  if (!systemPrompt || !userPrompt) {
    return res.status(400).json({ error: "Missing AI prompt." });
  }

  // Avoid unexpectedly large requests from the public endpoint.
  if (systemPrompt.length > 8000 || userPrompt.length > 20000) {
    return res.status(413).json({ error: "Prompt is too large." });
  }

  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), 25000);

  try {
    const response = await fetch(
      "https://api.groq.com/openai/v1/chat/completions",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${apiKey}`,
        },
        body: JSON.stringify({
          model: process.env.GROQ_MODEL || "llama-3.3-70b-versatile",
          messages: [
            { role: "system", content: systemPrompt },
            { role: "user", content: userPrompt },
          ],
          temperature: 0.2,
        }),
        signal: controller.signal,
      }
    );

    const data = await response.json().catch(() => ({}));

    if (!response.ok) {
      console.error("Groq API error:", response.status, data);
      return res.status(response.status).json({
        error:
          data?.error?.message ||
          data?.error ||
          `Groq request failed (${response.status}).`,
      });
    }

    const content = data?.choices?.[0]?.message?.content;
    if (!content) {
      return res.status(502).json({ error: "Groq returned an empty response." });
    }

    return res.status(200).json({ content });
  } catch (error) {
    if (error?.name === "AbortError") {
      return res.status(504).json({ error: "Groq request timed out." });
    }

    console.error("Server error:", error);
    return res.status(500).json({ error: "Could not contact Groq." });
  } finally {
    clearTimeout(timeout);
  }
}
