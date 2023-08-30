import os
import random
import string

# Get total_size_mb from the environment variable or use the default value
total_size_mb = int(os.environ.get("TOTAL_SIZE_MB", 1))

# Get chunk_size_kb from the environment variable or use the default value
chunk_size_kb = int(os.environ.get("CHUNK_SIZE_KB", 1))

# Calculate chunk size in bytes
chunk_size_bytes = chunk_size_kb * 1024

# Define the characters you want to include
allowed_characters = string.ascii_letters + string.digits + "\n" + "!@#~#$%^&*()_+=-"

# ANSI escape codes for bright color and bold text
ANSI_BOLD = "\033[1m"
ANSI_RESET = "\033[0m"
ANSI_ORANGE = "\033[1;33m"

# Function to generate the header for a chunk
def generate_chunk_header(current_chunk, total_chunks):
    header = f"{ANSI_ORANGE}{'-' * 88}\n"
    header += f"{' ' * 40}CHUNK {current_chunk} / {total_chunks}\n"
    header += f"{'-' * 88}{ANSI_RESET}\n"
    return header

# Function to generate the footer for a chunk
# def generate_chunk_footer():
#     footer = f"{ANSI_ORANGE}\n{'-' * 88}\n"
#     footer += f"{' ' * 40}END OF CHUNK\n"
#     footer += f"{'-' * 88}\n{ANSI_RESET}\n"
#     return footer

# Function to continuously generate and stream random data
def stream_data():
    generated_size_bytes = 0
    current_chunk = 0
    total_chunks = total_size_mb * 1024 // chunk_size_kb
    
    while generated_size_bytes < total_size_mb * 1024 * 1024:
        current_chunk += 1
        
        # Generate a chunk header
        header = generate_chunk_header(current_chunk, total_chunks)
        
        # Generate a chunk of random content
        chunk = ''.join(random.choice(allowed_characters) for _ in range(chunk_size_bytes))
        
        # Generate a chunk footer
        # footer = generate_chunk_footer()
        
        # Print the header, chunk, and footer to the console
        print(header + chunk, end='', flush=True)
        
        # Update the generated size
        generated_size_bytes += chunk_size_bytes

stream_data()