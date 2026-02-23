# Custom Domain Setup - curiositynodes.cc

## 📋 DNS Configuration Required

To make **curiositynodes.cc** point to your GitHub Pages site, you need to add DNS records with your domain registrar.

### DNS Records to Add:

**Option 1: Root Domain (@)**
```
Type: A
Name: @
Value: 185.199.108.153
TTL: 3600

Type: A
Name: @
Value: 185.199.109.153
TTL: 3600

Type: A
Name: @
Value: 185.199.110.153
TTL: 3600

Type: A
Name: @
Value: 185.199.111.153
TTL: 3600
```

**Option 2: WWW Subdomain (Recommended)**
```
Type: CNAME
Name: www
Value: haroondilshad.github.io
TTL: 3600
```

**Option 3: Both (Best Practice)**
- Add all 4 A records for root domain (@)
- Add CNAME record for www subdomain
- This ensures both `curiositynodes.cc` and `www.curiositynodes.cc` work

### How to Configure:

1. **Log into your domain registrar** (wherever you bought curiositynodes.cc)
2. **Find DNS/Nameserver settings** (usually under "DNS Management" or "Advanced DNS")
3. **Add the records above**
4. **Wait for propagation** (can take 24-48 hours, but often much faster)

### Verify Configuration:

Once DNS propagates, you can verify:

```bash
# Check A records
dig curiositynodes.cc +short

# Check CNAME for www
dig www.curiositynodes.cc +short

# Check if site is accessible
curl -I https://curiositynodes.cc
```

Expected results:
- A records should show: 185.199.108.153, 185.199.109.153, 185.199.110.153, 185.199.111.153
- CNAME should show: haroondilshad.github.io
- HTTPS should work automatically (GitHub provides SSL certificate)

## ✅ Already Completed

The following has already been configured:

1. ✅ CNAME file added to repository (`curiositynodes.cc`)
2. ✅ File committed and pushed to GitHub
3. ✅ GitHub Pages is live at https://haroondilshad.github.io/gnoland-test11-guide/

## 🔄 After DNS Propagation

Once your DNS records are active:

1. **Verify in GitHub Settings:**
   - Go to https://github.com/haroondilshad/gnoland-test11-guide/settings/pages
   - You should see "Custom domain: curiositynodes.cc" with a green checkmark
   - "Enforce HTTPS" should be enabled automatically

2. **Test the site:**
   - https://curiositynodes.cc should load your landing page
   - https://curiositynodes.cc/guide.html should load the guide

3. **Update all links:**
   - The site is already configured to use curiositynodes.cc
   - No code changes needed once DNS is active

## 📞 Domain Registrar Examples

### If using Namecheap:
1. Log in → Domain List → Manage
2. Advanced DNS tab
3. Add A Records and CNAME as shown above

### If using Cloudflare:
1. Log in → Select domain
2. DNS → Records
3. Add A Records and CNAME
4. Set Proxy status to "DNS only" (gray cloud) for GitHub Pages

### If using GoDaddy:
1. Log in → My Products → DNS
2. Add A Records and CNAME as shown above

## ⚠️ Important Notes

- **DNS propagation** takes time (5 minutes to 48 hours)
- **HTTPS** will be enabled automatically by GitHub after DNS is verified
- **Don't delete** the CNAME file from the repository
- **Both URLs work** during transition: haroondilshad.github.io/gnoland-test11-guide/ and curiositynodes.cc

## 🔍 Troubleshooting

**If domain doesn't work after 24 hours:**

1. Check DNS with `dig curiositynodes.cc`
2. Verify CNAME file exists in repo root
3. Check GitHub Pages settings for errors
4. Ensure DNS records match exactly (no trailing dots, correct IPs)

**Current Status:**
- ✅ Repository: Configured with CNAME
- ⏳ DNS: Waiting for your configuration
- ⏳ Custom Domain: Will be active after DNS propagates

---

**Next Steps:** Add DNS records at your domain registrar, then wait for propagation. The site will automatically start serving at curiositynodes.cc once DNS is configured.
