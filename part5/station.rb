class Station
  include InstanceCounter

  attr_accessor :trains, :title

  @@stations = []

  def initialize(title)
    @title = title
    @trains = []
    @@stations << self
    register_instance
  end 

  def self.all
    @@stations
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

  def show_train
    @trains.map(&:number)
  end

end
