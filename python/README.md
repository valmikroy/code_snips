# Python Code Snips



Print json 

```python
import requests
import json

headers = {'Authorization': 'Bearer Oracle'}
r = requests.get('http://169.254.169.254/opc/v2/instance/', headers=headers)

print(json.dumps(r.json(), indent=4))
```



