# Robot Framework and VScode settings Project

This project is created to save VScode devcontainer settings with Robot Framework and Browser library.

### Used extensions: 
- "ms-python.python",
- "ms-python.black-formatter",
- "d-biehl.robotcode",
- "github.copilot"

### Pabot run parallel with all browsers:
```
pabot --argumentfile1 arguments/firefox.args --argumentfile2 arguments/chromium.args --argumentfile3 arguments/safari.args --outputdir results --loglevel DEBUG tests/
```