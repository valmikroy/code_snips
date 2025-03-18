# Python Code Snips



#### HTTP Request

```python
import requests
import json

headers = {'Authorization': 'Bearer Oracle'}
r = requests.get('http://169.254.169.254/opc/v2/instance/', headers=headers)

print(json.dumps(r.json(), indent=4))
```



#### JSON

```python
import json

# read from file 
with open('data.json') as f:
    data = json.load(f)
    
# write to file
f = open('data.json','w')
json.dump(json_data_str,f)
f.close()
    
```



#### Time difference 

```python
from dateutil.parser import parse
import datetime

def get_timediff(ts):
    start_time = parse(ts,fuzzy=True)
    now = datetime.datetime.now(datetime.timezone.utc)

    return int((now-start_time).total_seconds()/60)
```



#### Quick cmdline

```python
import click

@click.command()
@click.option('--count', default=1, help='number of greetings')
#@click.argument('name')
def hello(count, name="blah"):
    for x in range(count):
        click.echo(f"Hello {name}!")

if __name__ == '__main__':
    hello()
```



#### Pattern extraction 

```python
import re
text = 'gfgfdAAA1234ZZZuijjk'

m = re.search('AAA(.+?)ZZZ', text)
if m:
    found = m.group(1)

found
```





## K8S

#### Fetch container  logs
```python
import kubernetes

w = kubernetes.watch.Watch()

line_cnt = 10
for l in w.stream( v1.read_namespaced_pod_log,
        name="my-pod-9qzsf",
        container="my-container",
        namespace="my-relay",
        since_seconds=300,
        _preload_content=False
        
):
        line_cnt -= 1      
        if not line_cnt:
            w.stop()    
        print(json.loads(l)['ts'])

print("INFO:: Logs reading thread has finished")
```







####  kubelet API query 

``` python
import kubernetes

api_client=kubernetes.client.ApiClient()

ret_metrics = api_client.call_api('/api/v1/nodes/10.0.29.209/proxy/metrics/cadvisor', 
                                  'GET', 
                                  auth_settings = ['BearerToken'], 
                                  response_type='json', 
                                  _preload_content=False) 
response = ret_metrics[0].data.decode('utf-8')

pprint(response)

# kubectl get --raw /api/v1/nodes/<node-name>/proxy/containerLogs/{podNamespace}/{podID}/{containerName}
# available APIs https://github.com/kubernetes/kubernetes/blob/14344b57e56258e87cbe80c8cd80399855eca424/pkg/kubelet/server/auth_test.go#L110-L143
```



