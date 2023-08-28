$kics[].queries | map({
  "message": (.query_name  +  " (queryId: "+ .query_id +") <br> **Severity**: " + .severity + "<br> **Description**: " + .description + "<br> **Expected**: " + .files[].expected_value),
  "path": .files[].file_name,
  "startLine": .files[].line
}) | {
  "source": {
    "name": "Checkmarx/kics",
    "url": "https://github.com/Checkmarx/kics"
  },
  "severity": "WARNING",
  "diagnostics": [ .[] | { 
    "message": .message, 
    "location": {
      "path": .path, 
      "range": { 
        "start": {
          "line": .startLine
        }
      }
    }
  }]
}