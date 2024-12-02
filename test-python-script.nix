{pkgs}:
pkgs.python3.pkgs.toPythonModule (pkgs.writePython "test-python-script" ''
  print("hello fucking world")
'')
