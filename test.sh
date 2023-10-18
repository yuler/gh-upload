owner=yuler
repo=static
file=fixtures/avatar.png
message="Add avatar.png"

# Create blobs
blob_sha=$(gh api /repos/$owner/$repo/git/blobs -F "encoding=base64" -F "content=$(base64 $file)" | jq -r '.sha')
echo $blob_sha

# Last sha
parent_sha=$(gh api /repos/$owner/$repo/branches/main | jq -r '.commit.sha')
echo $parent_sha

# Create tree
tree_sha=$(gh api -X POST /repos/yuler/static/git/trees \
  -F "tree[][path]=avatar.png" -f "tree[][mode]=100644" -F "tree[][type]=blob" -F "tree[][sha]=$blob_sha" \
  -F "base_tree=${parent_sha}" | jq -r '.sha')
echo $tree_sha

# Post commit
commit_sha=$(gh api -X POST /repos/$owner/$repo/git/commits -F "tree=${tree_sha}" -F "parents[]=${parent_sha}" \
  -F "message=$message" | jq -r '.sha')
echo $commit_sha

# Update ref
gh api -X PATCH /repos/$owner/$repo/git/refs/heads/main -F "sha=$commit_sha"
