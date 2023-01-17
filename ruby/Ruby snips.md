Ruby snips

- File read - slurp
  ```ruby
  File.readlines('resources/nginx_logs').each   do |line|
  
      d = line.chomp.split(/\s+/)
  
  end	
  ```

- Read STDIN line by line 
  ```ruby
  ARGF.each do |line|
  	puts line
  end
  ```

- Mixlib shellout 

  ```ruby
  require 'mixlib/shellout'
  
  def shellout!(*c)
        cmd = Mixlib::ShellOut.new(*c)
        cmd.timeout = 3600
        cmd.run_command
        cmd.error!
        cmd.stdout
  end
  
  begin
  
          shellout!("ls")
  
  rescue StandardError => e
          puts e
          puts "failed to execute"
  else
          puts "successfully executed"
  end
  ```

- `system()` 

  ```ruby
  system("echo foo | grep bar")
  puts $?.exitstatus
  puts $?.success? 
  puts $?.pid
  ```

  

- Rescue blocks

  ```ruby
  f = File.open("testfile")
  begin
    # .. process
  rescue
    # .. handle error
  else
    puts "Congratulations-- no errors!"
  ensure
    f.close unless f.nil?
  end
  ```

- Retry loop 
  ```ruby
  begin
      retries ||= 0
      puts "try ##{ retries }"
      raise "the roof"
  rescue
      retry if (retries += 1) < 3
  end
  ```

- Read json
  ```ruby
  require 'json'
  
  json_object = JSON.parse(File.read('file.json'))
  
  File.open('file.json',"w") do |f|
    f.write(JSON.pretty_generate(json_hash))
  end
  
  ```

- Dir walk
  ```ruby
  def walk(d)
  	Dir.foreach(d) do |x|
  		next if x == '.'  || x == '..'
  		path = "#{d}/#{x}"
  		walk(path) if File.directory?(path)
  		next  if File.directory?(path) # unsure about this line
  		steps_to_act_on_file(path)
  	end
  end
  
  # just a list of array can be collected
  
  Dir['*.png']
  Dir['**/*']  ## Recursively go through directories and get all files
  # Or
  Dir.glob('*.png')
  ```

  

- Threads
  ```ruby
  require 'thread'
  
  
  t = []
  
  
  m = Mutex.new
  
  200.times do |i|
  
  	t << Thread.new do 
  		
      # mutex lock but it could any task which you want to carry 
      m.synchronize  do
  			puts i
  		end
      
  	end
  
  end
  
  # fire threads
  t.map { |x|  x.join }
  ```

- 



