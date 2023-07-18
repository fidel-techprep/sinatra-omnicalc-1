require "sinatra"
require "sinatra/reloader"


get("/") do
  @calc = "square"
  erb(:square)
end

get("/:calculation/new") do
  @calc = params.fetch("calculation").gsub("_", " ")
  if !["square root", "square", "payment", "random"].include?(@calc)
    @calc = "square"
    redirect "/" 
  end

  case @calc
  when "square"
    erb(:square)
  when "payment"
    erb(:payment)
  when "square root"
    erb(:square)
  when "random"
    erb(:random)
  end
end

get("/:calculation/results") do
  @calc = params.fetch("calculation").gsub("_", " ")
  
  case @calc
  when "square"
    @number = params.fetch("number").to_f
    @result = (@number ** 2).to_f
    erb(:square_result)
  when "square root"
    @number = params.fetch("number").to_f
    @result = Math.sqrt(@number)
    erb(:square_result)
  when "payment"
    @apr = params.fetch("apr").to_f / 100
    @years = params.fetch("years").to_i
    @pv = params.fetch("pv").to_f
    @payment_num = (@apr / 12) * @pv
    @payment_den =  1 - ((1 + (@apr / 12)) ** (-1 * (@years * 12)))
    @payment = (@payment_num / @payment_den)
    erb(:payment_result)
  when "random"
    @max = params.fetch("max").to_f
    @min = params.fetch("min").to_f
    @number = rand(@min..@max)
    erb(:random_result)
  end
end
