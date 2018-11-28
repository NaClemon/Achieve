from sklearn.metrics.pairwise import cosine_similarity

a = cosine_similarity([[5, 5, 4, 2, 4]], [[5, 4, 4, 5, 5]])
b = cosine_similarity([[2, 4, 4, 3, 3]], [[5, 4, 4, 5, 5]])
c = cosine_similarity([[1, 2, 5, 1, 1]], [[5, 4, 4, 5, 5]])
d = cosine_similarity([[2, 1, 2, 4, 1]], [[5, 4, 4, 5, 5]])

print(a)
print(b)
print(c)
print(d)