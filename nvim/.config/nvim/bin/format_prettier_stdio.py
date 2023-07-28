import sys
import subprocess

# Read HTML string from stdin
html_string = sys.stdin.read()

# Format the HTML using prettier
prettier_command = ["prettier", "--parser", "html", "--config", "/home/dennis/.prettierrc.json"]
formatted_html = subprocess.run(prettier_command, input=html_string.encode(), stdout=subprocess.PIPE).stdout.decode()

# Print the formatted HTML
print(formatted_html)
