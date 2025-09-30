## Killercoda assets

Those are Killercoda assets that can be pulled from Killercoda CLI. Killercoda assets consist of multiple scripts, as well as background and foreground shell scripts.

## Available Assets

### setup_remote_debug.sh

Configures remote debugging access to Killercoda scenarios via SSH and cloudflared tunnel.

**Usage in Killercoda:**
```bash
setup_remote_debug.sh
start_remote_debug
```

**Features:**
- Configures SSH for password authentication
- Sets root password (test123)
- Installs cloudflared
- Creates helper command `start_remote_debug`

**Include in index.json:**
```json
{
  "file": "setup_remote_debug.sh",
  "target": "/usr/local/bin/",
  "chmod": "+x"
}
```

See [killercoda-remote-debugging.md](obsidian://open?vault=Notes&file=killercoda-remote-debugging.md) for complete setup and usage documentation.
