class Station
  attr_reader :trains

  def initialize(title)
    @title = title
    @trains = []
  end 

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    trains_type = []
    @trains.each do |train|
      trains_type << train if train.type == type
    end
    trains_type.count 
  end

end

=begin
MacBook-Pro-Aleksej:part3 aleksejmatveev$ irb -r ./station.rb -r ./train.rb
2.5.3 :001 > train1 = Train.new(123, 23, 'pas')
 => #<Train:0x00007f8bf18183a8 @current_speed=0, @number=123, @number_wagons=23, @type="pas"> 
2.5.3 :002 > train2 = Train.new(234,20, 'gr')
 => #<Train:0x00007f8bf1a0b818 @current_speed=0, @number=234, @number_wagons=20, @type="gr"> 
2.5.3 :003 > train3 = Train.new(345, 15, 'pas')
 => #<Train:0x00007f8bf20d2818 @current_speed=0, @number=345, @number_wagons=15, @type="pas"> 
2.5.3 :004 > station = Station.new('qwe')
 => #<Station:0x00007f8bf1a62d20 @title="qwe", @trains=[]> 
2.5.3 :005 > station.add_train(train1)
 => [#<Train:0x00007f8bf18183a8 @current_speed=0, @number=123, @number_wagons=23, @type="pas">] 
2.5.3 :006 > station.add_train(train2)
 => 
[#<Train:0x00007f8bf18183a8 @current_speed=0, @number=123, @number_wagons=23, @type="pas">,
 #<Train:0x00007f8bf1a0b818 @current_speed=0, @number=234, @number_wagons=20, @type="gr">] 
2.5.3 :007 > station.add_train(train3)
 => 
[#<Train:0x00007f8bf18183a8 @current_speed=0, @number=123, @number_wagons=23, @type="pas">,
 #<Train:0x00007f8bf1a0b818 @current_speed=0, @number=234, @number_wagons=20, @type="gr">,
 #<Train:0x00007f8bf20d2818 @current_speed=0, @number=345, @number_wagons=15, @type="pas">] 
2.5.3 :008 > station.trains_by_type('pas')
 => 2 
2.5.3 :009 > station.trains_by_type('gr')
 => 1 
=end
