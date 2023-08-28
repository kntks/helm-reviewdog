$trivy[].Results | map(select(.Misconfigurations))[] as $Results | $Results.Misconfigurations | map({
  "message": (.Title  + "<br> **Severity**:" + .Severity + "<br> **Description**: " + .Description + "<br> **Message**: " + .Message + "<br> **Expected**: " + .Resolution), 
  "path": ["charts", $Results.Target] | join("/"),
  "startLine":  ( .CauseMetadata.StartLine // 1 ) ,
  "endLine": ( .CauseMetadata.EndLine // 1 )
}) | {
  "source": {
    "name": "aquasecurity/trivy",
    "url": "https://github.com/aquasecurity/trivy"
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