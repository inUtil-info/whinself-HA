# Whinself Add-on Documentation

## Quick Start

This guide will help you get started with Whinself in Home Assistant.

### 1. Access the Whinself Dashboard

Once the add-on is running, open your browser and go to:

```
http://[YOUR_HA_IP]:[PORT]
```

- By default, the port is `8888`, but it may be different if you changed the `portin` option.
- You can also use the "Open Web UI" button in the add-on panel.

### 2. Create an Account & Connect

1. Register a new account (or log in if you already have one).
2. Click **Subscribe** to activate your free trial (no payment info required).
3. After subscribing, a new category will appear in the web interface where you will see the QR code required to connect to WhatsApp.
4. Scan the QR code with WhatsApp on your phone:
   - Open WhatsApp > Settings > Linked Devices > Link a Device
   - Scan the QR code from the Whinself dashboard

After scanning the QR code, go to the **Service Status** category in the web interface. There you will see the status **Connected to WhatsApp** and the phone number you have enrolled with.

### 3. Test Sending a Message

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

This add-on wraps the whinself API for use in Home Assistant as a self-hosted WhatsApp API.

Repository: [https://github.com/inUtil-info/whinself-HA.git](https://github.com/inUtil-info/whinself-HA.git)

## Configuration options

All options are optional and correspond to environment variables supported by Whinself:

- **slotid**: Unique identifier for the WhatsApp instance (default: `slot1`)
- **nrurl**: URL endpoint for incoming WhatsApp messages (default: empty)
- **portin**: Port for the application to listen on (default: `8888`, internal use only)
- **devicename**: Name of the device (default: `WhatsApp Bot`)
- **debuglevel**: Debug logging level (0-4, default: `0`)
- **logstdout**: Enable logging to stdout (default: `false`)
- **logsse**: Enable Server-Sent Events logging (default: `false`)
- **qrurl**: URL for QR code generation (default: empty)

You can set these options in the add-on configuration panel.

## Port configuration and host network

By default, Whinself runs on port **8888**. You can change this port by setting the `portin` parameter in the add-on configuration. **Important:** The port you set in `portin` must also be exposed in the `ports` section of the add-on configuration. For example:

- If `portin` is set to `8888`, you must expose port `8888`.
- If `portin` is set to `9999`, you must expose port `9999`.

Example `ports` section:

```
ports:
  8888/tcp: 8888
  9999/tcp: 9999
```

After changing the port, restart the add-on for the changes to take effect.

### Host network

This add-on uses `host_network: true`, which means the Whinself service will be available both inside and outside Home Assistant, directly on the host's IP and the configured port.

## How to use

1. Add this repository to your Home Assistant Supervisor add-on store:
   `https://github.com/inUtil-info/whinself-HA.git`
2. Install the add-on from the Supervisor add-on store.
3. Configure the options as needed.
4. Start the add-on.
5. Access the service on the fixed port (default: 8888).

---

## How to receive WhatsApp messages in Home Assistant and forward them to a webhook

You can configure Whinself to POST incoming WhatsApp messages to a Home Assistant webhook, and then use an automation to forward those messages to any other webhook or service.

### 1. Create a webhook automation in Home Assistant

1. Go to **Settings > Automations & Scenes > Automations**.
2. Click **Add Automation** > **Start with an empty automation**.
3. Set a name, e.g., `Receive WhatsApp messages`.
4. Add a **Trigger**:
   - Type: **Webhook**
   - Webhook ID: `whinself_incoming`
5. Add an **Action**:
   - Type: **Call service**
   - Service: `rest_command.forward_whatsapp_message` (we will create it in the next step)
   - Data: You can use the template `{{ trigger.json }}` to pass the received content.

### 2. Set the endpoint in Whinself

In the add-on configuration, set `nrurl` to:

```
http://homeassistant.local:8123/api/webhook/whinself_incoming
```

Or use the local IP of your Home Assistant if needed.

### 3. (Optional) Create a rest_command to forward the message

In your `configuration.yaml` add:

```
rest_command:
  forward_whatsapp_message:
    url: "https://your-external-webhook.com/endpoint"
    method: POST
    headers:
      Content-Type: "application/json"
    payload: "{{ trigger.json | tojson }}"
```

This will forward the received content to another external webhook.

### 4. Customize the automation

You can modify the action to process the message, extract fields, send notifications, save to a file, etc.

---

#### References

- [Webhooks in Home Assistant](https://www.home-assistant.io/docs/automation/trigger/#webhook-trigger)
- [Whinself configuration documentation](https://docs.whinself.app/docs/install/configuration)

---

## How to add Whinself to the Home Assistant sidebar (iframe panel)

Since Ingress is not supported, you can add a shortcut to Whinself in the Home Assistant sidebar using a Webpage (iframe) panel:

1. Go to **Settings > Dashboards** in Home Assistant.
2. Click **Add panel** (bottom right) and select **Webpage**.
3. Set the URL to:
   ```
   http://homeassistant.local:8888
   ```
   (Or use your Home Assistant IP and the port you selected, e.g., `http://192.168.1.100:8888`)
4. Set a title and icon (e.g., WhatsApp icon: `mdi:whatsapp`).
5. Save. Now you will have a direct link to Whinself in your sidebar.

**Note:** You must allow Home Assistant to load iframes from this address. If you use HTTPS or a reverse proxy, adjust the URL accordingly.

## Troubleshooting

- If the add-on does not start, check the Supervisor logs for configuration errors.
- Ensure port 8888 (or the port you selected to run whinself) is not in use by another service.
- If messages are not received, verify the `nrurl` endpoint and your network/firewall settings.

## More Information

- [Official Whinself documentation](https://docs.whinself.app/docs/install/configuration)
