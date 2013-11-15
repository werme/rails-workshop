class MovieDecorator < Draper::Decorator
  delegate_all

  def epicness
    case rating
    when 10
      "very epic"
    when 9
      "slightly epic"
    when 3..8
      "not that epic"
    else
      "horrible"
    end
  end
end
