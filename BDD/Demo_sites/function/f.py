import random
import string

def generate_username(prefix, length=5):
    # Combine the prefix with a random string
    random_suffix = ''.join(random.choices(string.ascii_lowercase + string.digits, k=length))
    username = f"{prefix}_{random_suffix}"
    return username

# Example usage
prefix = "user"
unique_username = generate_username(prefix)
print(unique_username)

# Python3 code to generate
# id using uuid4()



