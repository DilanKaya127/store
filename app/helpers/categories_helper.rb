module CategoriesHelper
    def category_icon(name)
      case name
      when "Beverages"
        "🍹"
      when "Condiments"
        "🧂"
      when "Confections"
        "🍬"
      when "Dairy Products"
        "🧀"
      when "Grains/Cereals"
        "🥖"
      when "Meat/Poultry"
        "🍗"
      when "Produce"
        "🍎"
      when "Seafood"
        "🐟"
      else
        "📦"
      end
    end
end
