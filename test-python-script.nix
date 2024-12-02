{pkgs}:
# pkgs.python3.pkgs.toPythonModule (pkgs.writePython "test-python-script" ''
pkgs.python3.pkgs.toPythonModule (pkgs.writers.writePython3 "test-python-script" {} ''
  print("hello fucking world")
'')
    # (pkgs.writers.writePython3 "test-python-script" { } ''
    #     print("hello fucking world")
    #   '')
