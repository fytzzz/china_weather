#执行rake命令，将地区数据到入到locations表中.
desc "import data to db."
namespace :db do
  namespace :china_weather do
    task :import_location => :environment do
      fpath = File.dirname(__FILE__) + "/../../doc/location.txt"
      results = Array.new
      File.open(fpath).read.split("\n\n\n").each do |item|
        results << [item.split("\n").first.split("=").first, item.split("\n")]
      end

      results.each do |result|
        printf("begin-")
        result.last.each do |item|
          item.each do |location|
            l = location.split("=")
            Location.create(:num => l.first, :name => l.last, :parent_id => result.first == l.first ? nil : result.first)
            printf(".")
          end
        end
        printf("-end\n")
      end
    end
  end
end