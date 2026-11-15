# Security headers for web apps

A baseline for anything served to a browser. It comes from `felpsxp-finance`, where it runs in
production. Adjust the Content Security Policy to the origins the app really talks to, and verify
the result with `curl -sI <url>` after the deploy.

| Header | Value | What it does |
| ------ | ----- | ------------ |
| `Strict-Transport-Security` | `max-age=63072000; includeSubDomains` | Forces HTTPS for two years |
| `X-Content-Type-Options` | `nosniff` | Stops the browser from guessing content types |
| `X-Frame-Options` | `DENY` | Blocks framing, for browsers without CSP `frame-ancestors` |
| `Referrer-Policy` | `strict-origin-when-cross-origin` | Keeps paths out of cross-origin referrers |
| `Permissions-Policy` | `camera=(), microphone=(), geolocation=(), payment=()` | Turns off browser features the app does not use |
| `Content-Security-Policy` | see below | Limits where code and data can come from |

## Content Security Policy

Start strict and open only what a real need asks for:

```text
default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data: blob:;
font-src 'self' data:; connect-src 'self'; object-src 'none'; base-uri 'self'; form-action 'self';
frame-ancestors 'none'; upgrade-insecure-requests
```

Add the API and database origins to `connect-src`, and storage origins to `img-src`. Avoid
`'unsafe-inline'` and `'unsafe-eval'` in `script-src`: with them, the policy stops protecting
against injected scripts.

## On Vercel

```json
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        { "key": "Strict-Transport-Security", "value": "max-age=63072000; includeSubDomains" },
        { "key": "X-Content-Type-Options", "value": "nosniff" },
        { "key": "X-Frame-Options", "value": "DENY" },
        { "key": "Referrer-Policy", "value": "strict-origin-when-cross-origin" },
        { "key": "Permissions-Policy", "value": "camera=(), microphone=(), geolocation=(), payment=()" }
      ]
    }
  ]
}
```

Add the `Content-Security-Policy` entry to the same list once it is adjusted for the app.
