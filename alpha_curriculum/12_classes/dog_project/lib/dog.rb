class Dog
  def initialize(name, breed, age, bark, favorite_foods)
    @name = name
    @breed = breed
    @age = age
    @bark = bark
    @favorite_foods = favorite_foods
  end

  def name
    @name
  end

  def name=(new_name)
    @name = new_name
  end

  def breed
    @breed
  end

  def breed=(new_breed)
    @breed = new_breed
  end

  def age
    @age
  end

  def age=(new_age)
    @age = new_age
  end

  def bark
    if @age > 3
      @bark.upcase
    elsif @age <= 3
      @bark.downcase
    else
      nil
    end
  end

  def bark=(new_bark)
    @bark = new_bark
  end

  def favorite_foods
    @favorite_foods
  end

  def favorite_foods=(new_favs)
    @favorite_foods = new_favs
  end

  def favorite_food?(test_food)
    @favorite_foods.include?(test_food.capitalize)
  end
end
