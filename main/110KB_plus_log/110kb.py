import os
import random
import string

file_size_kb = 110
file_name = "110.txt"

# Define the characters you want to include
allowed_characters = string.ascii_letters + string.digits + "\n" + "!@#~#$%^&*()_+=-"

# Create the file and write random content to it
with open(file_name, "w") as file:
    while os.path.getsize(file_name) < file_size_kb * 1024:
        random_character = random.choice(allowed_characters)
        file.write(random_character)

print(f"File '{file_name}' created with a size of {file_size_kb}KB.")
