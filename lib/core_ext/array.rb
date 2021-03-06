require 'will_paginate/collection'

class Array
  def to_tsv
    res = ''
    self.each do |element|
      FasterCSV.generate(res, :col_sep => "\t") do |csv|
        csv << element.to_tsv
      end
    end
    res
  end

  def paginate(options = {})
    page     = options[:page] || 1
    per_page = options[:per_page] || WillPaginate.per_page
    total    = options[:total_entries] || self.length

    WillPaginate::Collection.create(page, per_page, total) do |pager|
      pager.replace self[pager.offset, pager.per_page].to_a
    end
  end

  def to_insert_value_s
    res = self.map{|value| ActiveRecord::Base.connection.quote(value)}
    res = "(#{res.join(", ")})"
    res
  end
end
