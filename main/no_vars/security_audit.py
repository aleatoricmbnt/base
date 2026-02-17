#!/usr/bin/env python3
import socket
import os
import sys
import subprocess

print("=== System Agent Pool Security Check ===\n")

# 1. User Information
print("1. USER & PRIVILEGES")
print(f"   User ID: {os.getuid()}")
print(f"   Effective UID: {os.geteuid()}")
print(f"   Group ID: {os.getgid()}")
print(f"   Running as root: {os.getuid() == 0}")
print()

# 2. Network Information
print("2. NETWORK INFORMATION")
hostname = socket.gethostname()
print(f"   Hostname: {hostname}")
try:
    my_ip = socket.gethostbyname(hostname)
    print(f"   IP Address: {my_ip}")
except:
    print(f"   IP Address: Unable to resolve")
print()

# 3. Filesystem Checks
print("3. FILESYSTEM WRITE ACCESS")
paths_to_test = [
    "/", "/bin", "/usr/bin", "/etc", "/root",
    "/tmp", "/home", "/opt/workdir"
]
for path in paths_to_test:
    test_file = os.path.join(path, ".write_test")
    try:
        with open(test_file, 'w') as f:
            f.write("test")
        os.remove(test_file)
        print(f"   ✓ {path:20} WRITABLE")
    except:
        print(f"   ✗ {path:20} READ-ONLY/DENIED")
print()

# 4. Network Connectivity
print("4. NETWORK CONNECTIVITY")
targets = [
    ("kubernetes.default.svc", 443),
    ("169.254.169.254", 80),  # Metadata
    ("8.8.8.8", 53),  # Google DNS
    ("1.1.1.1", 53),  # Cloudflare DNS
]

for host, port in targets:
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(2)
    try:
        result = sock.connect_ex((host, port))
        if result == 0:
            print(f"   ✓ {host:30}:{port:5} REACHABLE")
        else:
            print(f"   ✗ {host:30}:{port:5} UNREACHABLE")
    except Exception as e:
        print(f"   ✗ {host:30}:{port:5} ERROR: {e}")
    finally:
        sock.close()
print()

# 5. Available Tools
print("5. AVAILABLE SECURITY-RELEVANT TOOLS")
tools = ['docker', 'kubectl', 'nmap', 'nc', 'curl', 'wget', 'git', 'sudo']
for tool in tools:
    result = subprocess.run(['which', tool], capture_output=True, text=True)
    if result.returncode == 0:
        print(f"   ✓ {tool:15} {result.stdout.strip()}")
    else:
        print(f"   ✗ {tool:15} Not found")