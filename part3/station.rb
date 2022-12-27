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
    @trains.select { |train| train.type == type }
  end

  def trains_count(type)
    trains_by_type(type).count
  end
end

=begin
part3 aleksejmatveev$ irb -r ./train.rb -r ./station.rb
2.5.3 :001 > train1 = Train.new(123, 23, 'pas')
 => #<Train:0x00007f9e769c1550 @number=123, @current_speed=0, @number_wagons=23, @type="pas"> 
2.5.3 :002 > train2 = Train.new(234, 43, 'gr')
 => #<Train:0x00007f9e7811a1e8 @number=234, @current_speed=0, @number_wagons=43, @type="gr"> 
2.5.3 :003 > train3 = Train.new(453, 20, 'pas')
 => #<Train:0x00007f9e78122cd0 @number=453, @current_speed=0, @number_wagons=20, @type="pas"> 
2.5.3 :004 > station = Station.new('qwe')
 => #<Station:0x00007f9e780c9518 @title="qwe", @trains=[]> 
2.5.3 :005 > station.add_train(train1)
 => [#<Train:0x00007f9e769c1550 @number=123, @current_speed=0, @number_wagons=23, @type="pas">] 
2.5.3 :006 > station.add_train(train2)
 => [#<Train:0x00007f9e769c1550 @number=123, @current_speed=0, @number_wagons=23, @type="pas">, #<Train:0x00007f9e7811a1e8 @number=234, @current_speed=0, @number_wagons=43, @type="gr">] 
2.5.3 :007 > station.add_train(train3)
 => [#<Train:0x00007f9e769c1550 @number=123, @current_speed=0, @number_wagons=23, @type="pas">, #<Train:0x00007f9e7811a1e8 @number=234, @current_speed=0, @number_wagons=43, @type="gr">, #<Train:0x00007f9e78122cd0 @number=453, @current_speed=0, @number_wagons=20, @type="pas">] 
2.5.3 :008 > station.trains_by_type('pas')
 => [#<Train:0x00007f9e769c1550 @number=123, @current_speed=0, @number_wagons=23, @type="pas">, #<Train:0x00007f9e78122cd0 @number=453, @current_speed=0, @number_wagons=20, @type="pas">] 
2.5.3 :009 > station.trains_by_type('gr')
 => [#<Train:0x00007f9e7811a1e8 @number=234, @current_speed=0, @number_wagons=43, @type="gr">] 
2.5.3 :010 > station.trains_count('pas')
 => 2 
2.5.3 :011 > station.send_train(train1)
 => #<Train:0x00007f9e769c1550 @number=123, @current_speed=0, @number_wagons=23, @type="pas"> 
2.5.3 :012 > station.trains
 => [#<Train:0x00007f9e7811a1e8 @number=234, @current_speed=0, @number_wagons=43, @type="gr">, #<Train:0x00007f9e78122cd0 @number=453, @current_speed=0, @number_wagons=20, @type="pas">] 
=end
