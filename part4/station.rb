class Station
  attr_accessor :trains, :title

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

  def show_train
    @trains.map(&:number)
  end

end
