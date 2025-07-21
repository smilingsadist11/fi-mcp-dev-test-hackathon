# Quick Start: Example curl Commands for fi-mcp-dev

This guide provides ready-to-use curl commands to test the fi-mcp-dev server endpoints and authentication flow.

---

## 1. Initialize Session (POST to /mcp/)

```
curl -X POST http://localhost:8080/mcp/ \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","method":"initialize","id":1,"params":{}}' \
  -i
```
- **Response:**
  - Look for the `Mcp-Session-Id` header in the response.
  - Save this session ID for all further requests.

---

## 2. Login (Web Page, Mock)

Open in your browser:
```
http://localhost:8080/mockWebPage?sessionId=<your-session-id>
```

or

```
curl --request POST \
  --url 'http://localhost:8080/mockWebPage?sessionId=<your-session-id>>'
```

- Enter your allowed phone number and submit the form.

---

## 3. Call a Tool (POST to /mcp/)

```
curl -X POST http://localhost:8080/mcp/ \
  -H "Content-Type: application/json" \
  -H "Mcp-Session-Id: <your-session-id>" \
  -d '{"jsonrpc":"2.0","method":"tools/call","id":1,"params":{"name":"fetch_net_worth"}}'
```
- **Response:**
  - Returns tool data if logged in and phone number is allowed.
  - If not logged in, returns a message with a login URL.

---

## 4. Listen for Notifications (GET to /mcp/)

```
curl -X GET http://localhost:8080/mcp/ \
  -H "Mcp-Session-Id: <your-session-id>"
```
- **Response:**
  - Streams events (SSE) for notifications.

---

## 5. Terminate Session (DELETE to /mcp/)

```
curl -X DELETE http://localhost:8080/mcp/ \
  -H "Mcp-Session-Id: <your-session-id>"
```
- **Response:**
  - Terminates the session.

---

Replace `<your-session-id>` with the value from the initialize response.

For more details, see the main README.
