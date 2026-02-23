#!/bin/bash

# Cloudflare DNS Setup Script for curiositynodes.cc
# This script adds GitHub Pages DNS records to Cloudflare

set -e

echo "🔐 Cloudflare DNS Setup for curiositynodes.cc"
echo "=============================================="
echo ""

# Check if API token is provided
if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
    echo "📝 To get your Cloudflare API Token:"
    echo "   1. Visit: https://dash.cloudflare.com/profile/api-tokens"
    echo "   2. Click 'Create Token'"
    echo "   3. Use 'Edit zone DNS' template"
    echo "   4. Select zone: curiositynodes.cc"
    echo "   5. Copy the token"
    echo ""
    echo "Then run:"
    echo "   export CLOUDFLARE_API_TOKEN='your-token-here'"
    echo "   bash $0"
    echo ""
    exit 1
fi

echo "✅ API Token found"
echo ""

# Get Zone ID
echo "🔍 Finding zone ID for curiositynodes.cc..."
ZONE_RESPONSE=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=curiositynodes.cc" \
    -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
    -H "Content-Type: application/json")

ZONE_ID=$(echo $ZONE_RESPONSE | grep -o '"id":"[^"]*' | head -1 | cut -d'"' -f4)

if [ -z "$ZONE_ID" ]; then
    echo "❌ Error: Could not find zone for curiositynodes.cc"
    echo "Response: $ZONE_RESPONSE"
    exit 1
fi

echo "✅ Zone ID: $ZONE_ID"
echo ""

# Function to add DNS record
add_dns_record() {
    local type=$1
    local name=$2
    local content=$3
    local proxied=$4
    
    echo "➕ Adding $type record: $name → $content"
    
    RESPONSE=$(curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
        -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
        -H "Content-Type: application/json" \
        --data "{\"type\":\"$type\",\"name\":\"$name\",\"content\":\"$content\",\"ttl\":3600,\"proxied\":$proxied}")
    
    SUCCESS=$(echo $RESPONSE | grep -o '"success":[^,]*' | cut -d':' -f2)
    
    if [ "$SUCCESS" = "true" ]; then
        echo "   ✅ Success"
    else
        ERROR=$(echo $RESPONSE | grep -o '"message":"[^"]*' | cut -d'"' -f4)
        echo "   ⚠️  $ERROR (may already exist)"
    fi
    echo ""
}

# Add A records for GitHub Pages
echo "📝 Adding GitHub Pages A records..."
add_dns_record "A" "@" "185.199.108.153" false
add_dns_record "A" "@" "185.199.109.153" false
add_dns_record "A" "@" "185.199.110.153" false
add_dns_record "A" "@" "185.199.111.153" false

# Add CNAME record for www
echo "📝 Adding CNAME record for www..."
add_dns_record "CNAME" "www" "haroondilshad.github.io" false

echo "✅ DNS Configuration Complete!"
echo ""
echo "🔍 Verifying DNS records..."
sleep 2
dig +short curiositynodes.cc
echo ""
echo "⏳ Note: DNS propagation can take a few minutes to 24 hours"
echo "🌐 Your site will be available at: https://curiositynodes.cc"
echo ""
echo "📋 Next steps:"
echo "   1. Wait for DNS to propagate (check with: dig curiositynodes.cc)"
echo "   2. GitHub will automatically enable HTTPS"
echo "   3. Visit https://github.com/haroondilshad/gnoland-test11-guide/settings/pages to verify"
