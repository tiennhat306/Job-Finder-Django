import bcrypt

# SALT = 'random_salt'

# def hashing(original):
#     hashed = hashlib.sha256((original + SALT).encode('utf-8')).hexdigest()
#     return hashed

# def verifying(stored, provided):
#     hashed = hashing(provided)
#     return hashed == stored

import bcrypt

def hashing(password):
    """Hashes a password using bcrypt."""
    # Generate a random salt for each password
    salt = bcrypt.gensalt()
    # Hash the password with the salt
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
    return hashed_password.decode('utf-8')  # Decode for string storage

def verifying(stored_password, provided_password):
    """Verifies a provided password against a stored hashed password."""
    try:
        # Verify the password using bcrypt
        return bcrypt.checkpw(provided_password.encode('utf-8'), stored_password.encode('utf-8'))
    except (TypeError, ValueError):
        # Handle potential errors (e.g., invalid password format)
        return False
