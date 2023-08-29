import random
import string

# Define the total file size in megabytes
total_size_mb = 400
chunk_size_kb = 1024

# Calculate chunk size in bytes
chunk_size_bytes = chunk_size_kb * 1024

# Define the characters you want to include
allowed_characters = string.ascii_letters + string.digits + "\n" + "!@#~#$%^&*()_+=-"

# Function to continuously generate and stream random data
def stream_data():
    generated_size_bytes = 0
    while generated_size_bytes < total_size_mb * 1024 * 1024:
        # Generate a chunk of random content
        chunk = ''.join(random.choice(allowed_characters) for _ in range(chunk_size_bytes))
        
        # Print the chunk to the console
        print(chunk, end='', flush=True)
        
        # Update the generated size
        generated_size_bytes += chunk_size_bytes

stream_data()