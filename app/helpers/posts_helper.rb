module PostsHelper
  def convertCategory list
    final_string = ""
    list.length.times do |i|
      final_string += list[i].name + "_"
    end
    final_string.split("_").join(",")
  end
end
