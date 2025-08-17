from src.utils import create_embedding

# Test the create_embedding function
test_text = "This is a test sentence."
embedding = create_embedding(test_text)

print(f"Generated embedding for '{test_text}':")
print(embedding)