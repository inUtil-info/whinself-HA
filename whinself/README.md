# Home Assistant whinself Add-on

## Quick Start

This guide will help you get started with Whinself in Home Assistant.

## 1. Access the Whinself Dashboard

Once the add-on is running, open your browser and go to:

```
http://[YOUR_HA_IP]:[PORT]
```

- By default, the port is `8888`, but it may be different if you changed the `portin` option.
- You can also use the "Open Web UI" button in the add-on panel.

## 2. Create an Account & Connect

1. Register a new account (or log in if you already have one).
2. Click **Subscribe** to activate your free trial (no payment info required).
3. After subscribing, a new category will appear in the web interface where you will see the QR code required to connect to WhatsApp.
4. Scan the QR code with WhatsApp on your phone:
   - Open WhatsApp > Settings > Linked Devices > Link a Device
   - Scan the QR code from the Whinself dashboard

After scanning the QR code, go to the **Service Status** category in the web interface. There you will see the status **Connected to WhatsApp** and the phone number you have enrolled with.

## 3. Test Sending a Message

You can test sending a message using a tool like `curl`:

```
curl -X POST http://[YOUR_HA_IP]:[PORT]/wspout \
  -H "Content-Type: application/json" \
  -d '{
    "text": "Hello from Whinself!",
    "jid": "1234567890@s.whatsapp.net"
  }'
```

Replace `1234567890` with the recipient's phone number (including country code).

---

For more advanced configuration (changing ports, webhook URLs, device name, etc.), use the add-on configuration panel in Home Assistant.

For more information, see the [official Whinself documentation](https://docs.whinself.app/docs/tutorials/quick-start).

## How it works

- This add-on wraps the official Whinself self-hosted WhatsApp API.
- All configuration is done via the add-on options panel in Home Assistant.
- You can use Home Assistant webhooks to receive WhatsApp messages and trigger automations or forward them to other services.

---

This repository contains custom Home Assistant add-ons.

## Add-ons provided

- **whinself**: Self-hosted WhatsApp API wrapper.

---

For more information, see each add-on's folder.
