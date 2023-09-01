Ruby snips



- Array 
  ```ruby
  headers = %w{Name Title Email}
  
  # Concat multiple arrays
  
  [foo, bar, baz].reduce([], :concat)
  
  ```

  

- String 
  ```ruby
  # Multiline 
  
  multiline_string = <<-EOM
  This is a very long string
  that contains interpolation
  like #{4 + 5} \n\n
  EOM
  
  # Replace string 
  'mislocated cat, vindicating'.gsub('cat', 'dog')
  
  ```

  



- File read 
  ```ruby
  File.readlines('resources/nginx_logs').each   do |line|
      d = line.chomp.split(/\s+/)
  end	
  
  
  b = IO.readlines("testfile", chomp: true)
  b[0]   #=> "This is line one"
  
  
  
  # Another way of reading
  
  IO.read("testfile")              #=> "This is line one\nThis is line two\nThis is line three\nAnd so on...\n"
  IO.read("testfile", 20)          #=> "This is line one\nThi"
  IO.read("testfile", 20, 10)      #=> "ne one\nThis is line "
  IO.read("binfile", mode: "rb")   #=> "\xF7\x00\x00\x0E\x12"
  ```

- File write
  ```ruby
  File.write("File.name","{daata: data}")
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

- [Case statement](https://www.rubyguides.com/2015/10/ruby-case/)

  ```ruby
  case capacity
  when 0
    "You ran out of gas."
  when 1..20
    "The tank is almost empty. Quickly, find a gas station!"
  when 21..70
    "You should be ok for now."
  when 71..100
    "The tank is almost full."
  else
    "Error: capacity has an invalid value (#{capacity})"
  end
  
  
  
  case serial_code
  when /\AC/
    "Low risk"
  when /\AL/
    "Medium risk"
  when /\AX/
    "High risk"
  else
    "Unknown risk"
  end
  ```

- is a hash
  ```ruby
  @some_var.is_a?(Hash)
  ```

- Spec jumpstart 
  ```ruby
  class Serial
    attr_accessor  :data
  
    def initialize
  
      @data = {
          'l1' => {
              'l2' => {
                  'l3' => {
                      'l4' => 'value'
                  }
              }
          }
      }
    end
  
    def serialize_hash
      d = self.data
    end
  end
  
  describe Serial, ".roll" do
    it "it returns random total within expected range" do
      out = Serial.new.serialize_hash
      expect(out).to eq('')
    end
  end
  
  ```

- CSV
  ```ruby
  # Credit https://devcamp.com/site_blogs/ruby-csv-generator-tutorial
  # Usage: rspec csv.rb
  
  require 'csv'
  
  
  class Serial
    attr_accessor  :data, :header, :row_header
  
    def initialize
      @header = %w( Name Title Email )
      @row_header = %w( R1 R2 R3 )
      @data = [
        ["Darth Vader", "CEO", "betterthan@theforce.com"],
        ["Luke Skywalker", "Dev", "daddy@issues.com"],
        ["Kylo Ren", "COO", "daddy2@issues.com"],
      ]
    end
  
    def csv_generate
      string = CSV.generate do |csv|
        csv <<  [].concat([''], self.header)
        self.data.each_with_index do |r,i|
          r_header =  self.row_header[i] || nil
          csv << [].concat([r_header] , r )
        end  
  
      end  
  
      #IO.write("sample.csv",string)
      return string
    end  
  end
  
  describe Serial, ".roll" do
    it "it returns random total within expected range" do
      test_output=<<-EOM
  "",Name,Title,Email
  R1,Darth Vader,CEO,betterthan@theforce.com
  R2,Luke Skywalker,Dev,daddy@issues.com
  R3,Kylo Ren,COO,daddy2@issues.com
      EOM
  
      out = Serial.new.csv_generate
      expect(out).to eq(test_output)
    end
  end
  
  ```

  
  
  Generate ruby csv quickly
  
  
  ```ruby
  csv_string = CSV.generate do |csv|
      csv_data.each do |r|
          csv << r
      end    
  end
  ```
  
  



- Rspec template
  ```ruby
  
  describe '#destroy' do
  	let(:resource) { FactoryBot.create :device }
  	let(:type)     { Type.find resource.type_id }
    
    context 'when resource is found' do
      it 'sets the type_id field' do
        expect(resource.type_id).to eq(type.id)
      end
    end  
    
    context 'when resource is found' do
      it 'responds with 200' do
          expect(response).to respond_with_content_type(:json)
        	expect(hero.equipment).to include "sword"
      end  
    end
  
  end
  
  
  # Skip broken tests
  
  describe 'Command', pending: "Fix is pending" do
      context 'when resource is found' do
      it 'responds with 200' do
          expect(response).to respond_with_content_type(:json)
        	expect(hero.equipment).to include "sword"
      end  
    end
  end  
  ```

  

- Create callbacks
  ```ruby
  def verify1(a)
  	puts "Verify 1 - #{a}"
  end
  
  
  def verify2(a)
  	puts "Verify 2 - #{a}"
  end
  
  
  
  
  ds = [
  	[ method(:verify1) , %w( a b c d )  ],
  	[ method(:verify2) , %w( e f g h)  ]
  ]
  
  
  ds.each do  |v|
  
     v_func = v[0]
     v[1].each do |i|
  	v_func.call(i)
     end
  
  end
  ```

  
