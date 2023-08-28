$checkov[].results.failed_checks | map({
  "message": ("**CheckId**: "+ .check_id + "<br> **Check Name**: " + .check_name + "<br> **Guideline**: " + .guideline), 
  "path": ("charts" + .repo_file_path),
  "startLine": .file_line_range[0],
  "endLine": .file_line_range[1]
}) | {
  "source": {
    "name": "bridgecrewioz/checkov",
    "url": "https://github.com/bridgecrewio/checkov"
  },
  "severity": "WARNING",
  "diagnostics": [ .[] | { 
    "message": .message,
    "location": {
      "path": .path,
      "range": { 
        "start": {
          "line": .startLine
        },
        "end": {
          "line": .endLine
        }
      }
    }
  }]
}