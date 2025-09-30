#!/usr/bin/env bash
set -eo pipefail

# Setup remote debugging for Killercoda scenarios
# This script configures SSH and starts cloudflared tunnel for remote access

echo "🔧 Setting up remote debugging..."

# Configure SSH for password authentication
echo "📝 Configuring SSH..."
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Restart SSH service
echo "🔄 Restarting SSH service..."
systemctl restart ssh || service ssh restart

# Set root password
echo "🔑 Setting root password..."
echo "root:test123" | chpasswd

# Install cloudflared
echo "📥 Installing cloudflared..."
if ! command -v cloudflared &> /dev/null; then
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /tmp/cloudflared-linux-amd64
    chmod +x /tmp/cloudflared-linux-amd64
    mv /tmp/cloudflared-linux-amd64 /usr/local/bin/cloudflared
    echo "✓ cloudflared installed"
else
    echo "✓ cloudflared already installed"
fi

# Create startup script for tunnel
cat > /usr/local/bin/start_remote_debug << 'SCRIPT'
#!/usr/bin/env bash
echo ""
echo "=========================================="
echo "🚀 Starting Cloudflared Tunnel"
echo "=========================================="
echo ""
cloudflared tunnel --url ssh://localhost:22
SCRIPT

chmod +x /usr/local/bin/start_remote_debug

echo ""
echo "✅ Remote debugging setup complete!"
echo ""
echo "To start the tunnel, run:"
echo "  start_remote_debug"
echo ""
echo "Or manually:"
echo "  cloudflared tunnel --url ssh://localhost:22"
echo ""
echo "Then connect from your local machine using the URL provided."
echo ""