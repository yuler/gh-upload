owner=yuler
repo=static
file=fixtures/avatar.png
datetime=$(date +%Y-%m-%d\ %H:%M:%S)
message="Updated at: \`$datetime\`"

# Create blobs
blob_sha=$(gh api /repos/$owner/$repo/git/blobs -f "encoding=base64" -f "content=$(base64 $file)" | jq -r '.sha')
echo $blob_sha

# Parent sha
parent_sha=$(gh api /repos/$owner/$repo/branches/main | jq -r '.commit.sha')
echo $parent_sha

# Create tree
tree_sha=$(gh api -X POST /repos/yuler/static/git/trees \
  -f "tree[][path]=$file" -f "tree[][mode]=100644" -f "tree[][type]=blob" -f "tree[][sha]=$blob_sha" \
  -f "base_tree=${parent_sha}" | jq -r '.sha')
echo $tree_sha

# Post commit
commit_sha=$(gh api -X POST /repos/$owner/$repo/git/commits -f "tree=${tree_sha}" -f "parents[]=${parent_sha}" \
  -f "message=$message" | jq -r '.sha')
echo $commit_sha

# Update ref
gh api -X PATCH /repos/$owner/$repo/git/refs/heads/main -f "sha=$commit_sha"
