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
			@collections.each { |coll| sum += coll.get_size_in_shard(@name) }
			sum 
		end

	end

	class Collection
		attr_accessor :name, :size, :shards_info

		def initialize(name, size, shards_info)
			@name = name
			@size = size
      @shards_info = shards_info
		end

    def get_size_in_shard(shard_name)
      @shards_info[shard_name]
    end

    def get_shards_info_by_percent
      sum = @shards_info.map { | key, value | value }.inject { | sum, item | sum += item }
      puts sum
      @shards_info.inject({}) { |h, (k, v)| h[k] = v / sum.to_f; h }
    end
	end

  def index

  end

  def show_shards

    coll_user = Collection.new("user", 80, { "shard_a" => 30, "shard_b" => 50 })
    coll_book = Collection.new("book", 190, { "shard_a" => 90, "shard_c" => 100 })
    coll_fruit = Collection.new("fruit", 10, { "shard_b" => 10 })
    coll_water = Collection.new("water", 50, { "shard_c" => 50 })
    coll_milk = Collection.new("milk", 90, { "shard_c" => 90 })
    coll_coffee = Collection.new("coffee", 200, { "shard_a" => 50, "shard_b" => 50, "shard_c" => 50, "shard_d" => 50 })

    shard_a = Shard.new("shard_a", [coll_user, coll_book])
    shard_b = Shard.new("shard_b", [coll_user, coll_fruit])
    shard_c = Shard.new("shard_c", [coll_book, coll_water, coll_milk])
    shard_d = Shard.new("shard_d", [coll_coffee])
    @shards = [shard_a, shard_b, shard_c, shard_d]

    collections = shard_a.collections + shard_b.collections + shard_c.collections + shard_d.collections.uniq
  	collection_names = collections.map { | item | item.name }.sort
    shard_names = @shards.map { | item | item.name }.sort

  	@shard_color_table = {}
    @collection_color_table = {}

	 	i = 0
  	while i < shard_names.size 
  		@shard_color_table[shard_names[i]] = COLOR[i]
  		i += 1
  	end

    j = 0
    while j < collection_names.size 
      @collection_color_table[collection_names[j]] = COLOR[j + shard_names.size]
      j += 1
    end

    #test in the console
    collections.each { | item | puts item.name }
    puts @shard_color_table
    puts @collection_color_table
    @shards.each { | item | puts item.name }
  end

  def show_collections
    coll_user = Collection.new("user", 80, { "shard_a" => 30, "shard_b" => 50 })
    coll_book = Collection.new("book", 190, { "shard_a" => 90, "shard_c" => 100 })
    coll_fruit = Collection.new("fruit", 10, { "shard_b" => 10 })
    coll_water = Collection.new("water", 50, { "shard_c" => 50 })
    coll_milk = Collection.new("milk", 90, { "shard_c" => 90 })
    coll_coffee = Collection.new("coffee", 200, { "shard_a" => 50, "shard_b" => 50, "shard_c" => 50, "shard_d" => 50 })

    shard_a = Shard.new("shard_a", [coll_user, coll_book])
    shard_b = Shard.new("shard_b", [coll_user, coll_fruit])
    shard_c = Shard.new("shard_c", [coll_book, coll_water, coll_milk])
    shard_d = Shard.new("shard_d", [coll_coffee])
    @shards = [shard_a, shard_b, shard_c, shard_d]

    collections = shard_a.collections + shard_b.collections + shard_c.collections + shard_d.collections.uniq
    collection_names = collections.map { | item | item.name }.sort
    shard_names = @shards.map { | item | item.name }.sort

    @shard_color_table = {}
    @collection_color_table = {}

    i = 0
    while i < shard_names.size 
      @shard_color_table[shard_names[i]] = COLOR[i]
      i += 1
    end

    j = 0
    while j < collection_names.size 
      @collection_color_table[collection_names[j]] = COLOR[j + shard_names.size]
      j += 1
    end

    #test in the console
    #collections.each { | item | puts item.name }
    #puts @shard_color_table
    #puts @collection_color_table
    #@shards.each { | item | puts item.name }
    puts coll_user.shards_info
    puts coll_user.get_shards_info_by_percent
    @collection = coll_coffee
  end

end
