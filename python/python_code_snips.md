# Python Code Snips



#### Query 

```python
import requests
import json

headers = {'Authorization': 'Bearer Oracle'}
r = requests.get('http://169.254.169.254/opc/v2/instance/', headers=headers)

print(json.dumps(r.json(), indent=4))
```



#### Json

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

