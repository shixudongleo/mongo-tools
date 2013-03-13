class ShardingController < ApplicationController

COLOR = ["#0E51A7", "#274D7E", "#05326D", "#4282D3", "#6997D3",
				 "#0ACF00", "#2D9B27", "#078600", "#42E73A", "#6EE768",
				 "#FFEC00", "#BFB530", "#A69A00", "#FFF140", "#FFF573",
				 "#FF5600", "#BF6030", "#A63800", "#FF8040", "#FFA273"]

	class Shard
		attr_accessor :name, :collections

		def initialize(name, collections)
			@name = name
			@collections = collections.sort_by{ |item| item.name }
		end

		def total_size
			sum = 0
			@collections.each { |coll| sum += coll.size }
			sum 
		end
	end

	class Collection
		attr_accessor :name, :size

		def initialize(name, size)
			@name = name
			@size = size
		end
	end

  def index

  end

  def show_shards
  	coll_a_1 = Collection.new("user", 30)
  	coll_a_2 = Collection.new("book", 90)

  	coll_b_1 = Collection.new("user", 50)
  	coll_b_2 = Collection.new("fruit", 10)

  	coll_c_1 = Collection.new("book", 100)
  	coll_c_2 = Collection.new("water", 50)
  	coll_c_3 = Collection.new("milk", 90)

  	shard_a = Shard.new("shard_a", [coll_a_1, coll_a_2])
  	shard_b = Shard.new("shard_b", [coll_b_1, coll_b_2])
  	shard_c = Shard.new("shard_c", [coll_c_1, coll_c_2, coll_c_3])

  	collections = shard_a.collections + shard_b.collections + shard_c.collections
  	collection_names = collections.map { | item | item.name }.sort
  	@color_table = {}

	 	i = 0
  	while i < collection_names.size 
  		@color_table[collection_names[i]] = COLOR[i]
  		i += 1
  	end
  	collections.each { |item| puts item.name }
  	puts @color_table
  	@shards = [shard_a, shard_b, shard_c]
  end

  def show_collections

  end

end
