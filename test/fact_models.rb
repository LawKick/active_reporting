class PostFactModel < ActiveReporting::FactModel
  dimension :creator
  dimension :state
  dimension :created_on

  dimension_filter :some_filter, ->(x) { where(creator_id: x) }
end

class UserFactModel < ActiveReporting::FactModel
  default_dimension_label :username
end

class DateDimensionFactModel < ActiveReporting::FactModel
  default_dimension_label :date

  dimension_hierarchy [:date, :month, :year, :quarter]
  hierarchy_label :month, :month_str
end
